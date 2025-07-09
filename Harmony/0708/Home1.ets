import http from '@ohos.net.http';
import {SwiperModel,GoodsModel} from './model/AppModel'
import {WaterFlowDataSource} from  './model/WaterFlowDataSource'
import {PullToRefresh} from '@ohos/pulltorefresh' // 1.引入分页模块PullToRefresh
@Component
export struct Home {
  @State swiperList: SwiperModel[]= []
  @State recommendList: GoodsModel[]= []
  @State dataSource: WaterFlowDataSource = new WaterFlowDataSource()
  @State page: number = 1
  @State isMore: boolean = true // 是否还有更多数据
  scroller: Scroller = new Scroller()
  // addData
  getIDataSource(){ // 将接口数据添加到 IDataSource 中
    for (let i = 0; i < this.recommendList.length; i++) {
      this.dataSource.addData(this.recommendList[i])
    }
  }
  // 获取轮播图接口
  async getSwiper(){  /// async...await
    let https = http.createHttp();
    const res = await https.request('http://47.120.13.185/api/getSwiper', {
      method: http.RequestMethod.GET,
      expectDataType:http.HttpDataType.OBJECT
    })
    this.swiperList = res.result['data']
    //console.log(JSON.stringify(this.swiperList))
  }
  // 获得商品推荐接口 http://47.120.13.185/api/goodsList?page=1&pageSize=4
  async getRecommend(resolve?: (value: string) => void){
    let https = http.createHttp();
    const res = await https.request(`http://47.120.13.185/api/goodsList?page=${this.page}&pageSize=6`, {
      method: http.RequestMethod.GET,
      expectDataType:http.HttpDataType.OBJECT
    })
    //this.recommendList = res.result['data']['list']
    //console.log(JSON.stringify(this.recommendList))
    //数据拼接
    let tempList : GoodsModel[] = res.result['data']['list']
    if (this.page == 1) {
      this.recommendList = tempList
    }else{
      // 不是第一页
      this.recommendList = this.recommendList.concat(tempList)
    }
    this.page++ // 再次调用page+1
    if (tempList.length < 4) {
      this.isMore = false
    }
    this.getIDataSource()
    // 刷新完成
    resolve && resolve('刷新完成')

  }
  // 生命周期
  aboutToAppear(): void {
    this.getSwiper()
    this.getRecommend()
  }
  // 轮播图布局  Image(`http://47.120.13.185/uploads/${item.imgurl}`)
  @Builder
  getSwiperListWidget(){
    Swiper() {
      ForEach(this.swiperList, (item: SwiperModel) => {
        Image(`http://47.120.13.185/uploads/${item.imgurl}`)
          .width('100%')
          .height(200)
          .objectFit(ImageFit.Cover)
      }, (item: SwiperModel) => item.id.toString())
    }
    .loop(true)  //无限循环
    .autoPlay(true) // 自动播放
    .interval(2000) // 轮播间隔时间
    //.displayArrow(true)
    .indicator(  // 指示器
      Indicator.dot()
        .left(0)
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color('#999999')
        .selectedColor('#ff6600')
    )
    .height(230)
  }
  // 推荐商品布局
  @Builder
  getRecommendListWidget(){
    Grid(){
      ForEach(this.recommendList, (item: GoodsModel) => {
        GridItem(){
          Column() {
            Image(`http://47.120.13.185/uploads/${item.imgurl}`)
              .width(160)
              .height(160)
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
          .padding(10)
          .backgroundColor('#ffffff')
        }
      }, (item: GoodsModel) => item.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(10)
    .rowsGap(10)
    .backgroundColor('#eeeeee')
    // Column(){
    //   WaterFlow(){
    //     LazyForEach(this.dataSource, (item:GoodsModel) => {
    //       FlowItem(){
    //         Column() {
    //           Image(`http://47.120.13.185/uploads/${item.imgurl}`)
    //             .width(150)
    //             .height(150)
    //             .objectFit(ImageFit.Cover)
    //             .margin(10)
    //             .borderRadius(5)
    //           Text(item.title)
    //             .fontSize(12)
    //             .fontColor('#333333')
    //             .margin(10)
    //           Text('￥' + item.price)
    //             .fontSize(12)
    //             .fontColor('#ff6600')
    //             .margin(10)
    //         }
    //       }
    //       .backgroundColor('#ffffff')
    //       .padding(10)
    //     },(item:GoodsModel) =>item.id.toString())
    //   }
    //   .columnsTemplate('1fr 1fr')
    //   .columnsGap(10)
    //   .rowsGap(10)
    //   .width('100%')
    //   .backgroundColor('#eeeeee')
    //   .padding({top: 10, bottom: 10})
    // }
    if (!this.isMore) {
      Text('-----没有更多数据了-----')
        .width('100%')
        .fontColor('#999999')
        .margin({top:25})
        .textAlign(TextAlign.Center)
    }

  }
  @Builder
  totalWidget(){
    Scroll(this.scroller){  // 包一个块
      Column(){
        this.getSwiperListWidget()
        this.getRecommendListWidget()
      }
    }
    .scrollBar(BarState.Off) // 隐藏滚动条
    .padding({bottom:20})
  }
  build() {
    Column() {
      PullToRefresh({
        data: this.recommendList,
        scroller:this.scroller, // 关联滚动
        customList:()=>{
          this.totalWidget()  // 初始化UI
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
    .height('100%')
    .width('100%')
  }
}