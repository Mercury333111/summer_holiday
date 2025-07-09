import http from '@ohos.net.http';
import {SwiperModel} from './model/AppModel'
/*
 * 1. import http from '@ohos.net.http';  //ajax
 * 2. 开启网络  module.json5
 * "requestPermissions": [
      {"name": "ohos.permission.INTERNET"}
   ],
   3. let https = http.createHttp();
   4. https.request('http://47.120.13.185/api/getSwiper', {})
   *
 * */
@Entry
@Component
struct http1 {
  @State swiperList: SwiperModel[]= []
  // async... await
  httpData(): Promise<string>{
    return new Promise((resolve, reject)=>{
      setTimeout(()=>{
        resolve('ok')
      },500)
    })
  }
  async loadData(){
    // this.httpData().then((res)=>{
    //   console.log(res)
    // })
    const res = await this.httpData()  // 异步转同步
    console.log(res)
    //...todo 其他任务
  }
  async getSwiper(){  /// async...await
    let https = http.createHttp();
    const res = await https.request('http://47.120.13.185/api/getSwiper', {
      method: http.RequestMethod.GET,
      expectDataType:http.HttpDataType.OBJECT
    })
    this.swiperList = res.result['data']
    console.log(JSON.stringify(this.swiperList))
  }
  // 生命周期
  aboutToAppear(): void {
    this.getSwiper()
    this.loadData()
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
  build() {
    Column() {
      this.getSwiperListWidget()
    }
    .height('100%')
    .width('100%')
  }
}