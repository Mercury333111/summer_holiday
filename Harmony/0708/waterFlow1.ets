/*
 * WaterFlow :瀑布流
 *
 * LazyForEach : 懒加载 , 当用户滚动到指定位置时，才加载数据
 * LazyForEach从提供的数据源中按需迭代数据，并在每次迭代过程中创建相应的组件。
 * 当在滚动容器中使用了LazyForEach，框架会根据滚动容器可视区域按需创建组件，
 * 当组件滑出可视区域外时，框架会进行组件销毁回收以降低内存占用
 * IDataSource 接口

 * */
import {GoodsModel} from './model/AppModel'
import http from '@ohos.net.http';
import {WaterFlowDataSource} from  './model/WaterFlowDataSource'
@Entry
@Component
struct waterFlow1 {
  @State dataSource: WaterFlowDataSource = new WaterFlowDataSource()
  @State recommendList: GoodsModel[]= []
  scroller: Scroller = new Scroller()
  // addData
  getIDataSource(){ // 将接口数据添加到 IDataSource 中
    for (let i = 0; i < this.recommendList.length; i++) {
      this.dataSource.addData(this.recommendList[i])
    }
  }
  async getRecommend(){
    let https = http.createHttp();
    const res = await https.request('http://47.120.13.185/api/goodsList?page=1&pageSize=4', {
      method: http.RequestMethod.GET,
      expectDataType:http.HttpDataType.OBJECT
    })
    this.recommendList = res.result['data']['list']
    //console.log(JSON.stringify(this.recommendList))
    this.getIDataSource()
  }
  // 生命周期
  aboutToAppear(): void {
    this.getRecommend()
  }
  build() {
    Column() {  // WaterFlow FlowItem
      Text('瀑布流').fontSize(30)
       WaterFlow(){
         LazyForEach(this.dataSource, (item:GoodsModel) => {
            FlowItem(){
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
            .backgroundColor('#ffffff')
            .padding(10)
          },(item:GoodsModel) =>item.id.toString())
       }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .backgroundColor('#eeeeee')
        .padding({top: 10, bottom: 10})
    }
    .height('100%')
    .width('100%')
  }
}