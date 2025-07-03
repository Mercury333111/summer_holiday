// Counter.ets
@Entry
@Component
struct DianZiMuYu {
  @State count: number = 0;

  build() {
    Column({ space: 20 }) {
      // 显示当前计数
      Text(`敲电子木鱼，攒赛博功德: ${this.count}`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 按钮组
      Row({ space: 20 }) {
        // 减1按钮
        Button('-1')
          .onClick(() => {
            this.count -= 1;
          })
          .width(100)
          .height(50)
          .fontSize(18)
          .type(ButtonType.Capsule)

        // 加1按钮
        Button('+1')
          .onClick(() => {
            this.count += 1;
          })
          .width(100)
          .height(50)
          .fontSize(18)
          .type(ButtonType.Capsule)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}