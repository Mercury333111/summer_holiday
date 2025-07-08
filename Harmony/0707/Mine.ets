@Component
export struct Mine {
  build() {
    Column() {
      Text('Mine').fontSize(20).fontColor(Color.Red)
    }
    .width('100%')
    .height('100%')
  }
}