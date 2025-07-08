@Component
export struct  Home {
  build() {
    Column() {
      Text('Home').fontSize(20).fontColor(Color.Red)
    }
    .width('100%')
    .height('100%')
  }
}