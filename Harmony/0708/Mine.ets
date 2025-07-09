// 1.导入路由模块
import router from '@ohos.router';
@Component
export struct Mine {
  build() {
    Column() {
      Text('Mine').fontSize(20).fontColor(Color.Red)
      Button('跳转到登录页')
      .onClick(() => {
        // router.pushUrl() 产生历史记录 ， reouter.replaceUrl() 不产生历史记录
        router.pushUrl({
          url: 'pages/Login',
          params: {
             keyword:'女歌手',
             type: 1
          }
        })
      })
    }
    .width('100%')
    .height('100%')
  }
}