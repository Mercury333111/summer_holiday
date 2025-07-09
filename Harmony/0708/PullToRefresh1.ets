import http from '@ohos.net.http';
import {GoodsModel} from './model/AppModel'
//ohpm 构建工具  ohpm install @ohos/pulltorefresh
import {PullToRefresh} from '@ohos/pulltorefresh' // 1.引入分页模块PullToRefresh
@Entry
@Component
struct PullToRefresh1 {
  @State recommendList: GoodsModel[]= []
  @State page: number = 1
  @State isMore: boolean = true // 是否还有更多数据
  scroller: Scroller = new Scroller()
  async getRecommend(resolve?: (value: string) => void){
    let https = http.createHttp();
    const res = await https.request(`http://47.120.13.185/api/goodsList?page=${this.page}&pageSize=6`, {
      method: http.RequestMethod.GET,
      expectDataType:http.HttpDataType.OBJECT
    })
    //this.recommendList = res.result['data']['list']
    //数据拼接
    let tempList : GoodsModel[] = res.result['data']['list']
    if (this.page==1) {
      this.recommendList = tempList
    }else{
      // 不是第一页
      this.recommendList = this.recommendList.concat(tempList)
    }
    this.page++ // 再次调用page+1
    if (tempList.length < 6) {
       this.isMore = false
    }
    // 刷新完成
    resolve && resolve('刷新完成')

  }
  // 生命周期
  aboutToAppear(): void {
    this.getRecommend()
  }
  // 轮播图布局  Image(`http://47.120.13.185/uploads/${item.imgurl}`)
  // 推荐商品布局
  @Builder
  getRecommendListWidget(){
    Grid(){
      ForEach(this.recommendList, (item: GoodsModel) => {
        GridItem(){
          Column() {
            Image(`http://47.120.13.185/uploads/${item.imgurl}`)
              .width(150)
              .height(150)
              .objectFit(ImageFit.Cover)
              .margin(10)
              .borderRadius(5)
            Text(item.title)
              .fontSize(12)
              .fontColor('#333333')
              .margin(10)
            Text('￥' + item.price)
              .fontSize(12)
              .fontColor('#ff6600')
              .margin(10)
          }
        }
      }, (item: GoodsModel) => item.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(10)

  }
  @Builder
  totalWidgget(){
    Scroll(this.scroller) { // 包一个块
      Column() {
        this.getRecommendListWidget()
        if (!this.isMore) {
          Text('-----没有更多数据了-----')
            .width('100%')
            .fontColor('#999999')
            .margin(15)
            .textAlign(TextAlign.Center)
        }
      }
    }.scrollBar(BarState.Off) // 隐藏滚动条
  }
  build() {
    Column() {
       PullToRefresh({
         data: this.recommendList,
         scroller:this.scroller, // 关联滚动
         customList:()=>{
           this.totalWidgget()  // 初始化UI
         },
         onLoadMore:()=>{  // 上拉分页，判断是否触底，触底则加载下一页数据，必须返回Promise对象
           return new Promise<string>((resolve, reject)=>{
             setTimeout(()=>{
               this.getRecommend(resolve)
             }, 1000)
           })
         },
         onRefresh:()=>{ // 下拉刷新，必须返回Promise对象
           return new Promise<string>((resolve, reject)=>{
             setTimeout(()=>{
                // 刷新数据回到第一页
               this.page = 1
               this.getRecommend(resolve)
               this.isMore = true
             }, 1000)
           })
         }

       })
    }
    .height('70%')
    .width('100%')
  }
}