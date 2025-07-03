@Entry
@Component
struct layout {
  @State msg :string = 'Hello World'
  build() {
    Row() {
      Column() {
      }
      .width('10%')
      .height('80%')
      .backgroundColor('#ff0000')
      .layoutWeight(1)

      Column() {
      }
      .width('10%')
      .height('80%')
      .backgroundColor('#ff00ff')
      .layoutWeight(3)

      Column() {
      }
      .width('10%')
      .height('80%')
      .backgroundColor('#0000ff')
      .layoutWeight(1)
    }
      .backgroundColor('#eeeeee')
      .width('100%')
      .height('100%')
  }
}