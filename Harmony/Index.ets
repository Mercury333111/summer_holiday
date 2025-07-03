@Entry
@Component
struct Index {
  @State message: string = 'Hello OpenHarmony';

  build() {
    Column() { //列布局
      Text(`你好：${this.message}`)
        .fontSize(30)
        .fontColor('#000000')
      Button('click here')
        .onClick(()=>{
          this.message = 'ok'
        })
        .width(100)
        .height(50)
        .margin({top:20})
      //图片   resources/base/media
      Image($r('app.media.startIcon'))//引入资源
        .width(100)
        .height(100)
        .margin({top:20})
      //配置   resources/base/element
      Text($r('app.string.mylabel'))//引入资源
        .fontColor($r('app.color.mycolor'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#eeeeee')
  }
}