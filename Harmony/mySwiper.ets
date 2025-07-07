@Entry
@Component
struct mySwiper {
  @State message : string = "Swiper"
  build() {
    Column() {
      Swiper() {
        Text('0')
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)


        Text('1')
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .fontSize(30)


        Text('2')
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Pink)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .indicator(
        Indicator.dot()
          .left(0)
          .itemWidth(15)
          .itemHeight(15)
          .selectedItemWidth(30)
          .selectedItemHeight(15)
          .color(Color.Red)
          .selectedColor(Color.Blue)
      )
      .displayArrow({
        showBackground: true,
        isSidebarMiddle: true,
        backgroundSize: 24,
        backgroundColor: Color.White,
        arrowSize: 18,
        arrowColor: Color.Blue
      }, false)
      .loop(true)
      //.loop(false) 不循环
      .autoPlay(true)
      .interval(3000)
    }
  }
}