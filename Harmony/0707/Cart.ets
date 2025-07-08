@Component
export struct  Cart {
  build() {
    Column() {
      Text('Cart').fontSize(20).fontColor(Color.Red)
    }
    .width('100%')
    .height('100%')
  }
}