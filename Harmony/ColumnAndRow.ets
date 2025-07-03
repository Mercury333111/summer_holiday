@Entry
@Component
struct ColumnAndRow {
  build() {
    Column() {
      //垂直线性布局
      Text('垂直线性布局').fontSize(18).fontWeight(FontWeight.Bold).margin({ bottom: 10 })
      Column({ space: 10 }) {
        Text('项目1').width('100%').height(50).backgroundColor('#FFDDDD')
        Text('项目2').width('100%').height(50).backgroundColor('#DDFFDD')
        Text('项目3').width('100%').height(50).backgroundColor('#DDDDFF')
      }
      .width('90%')
      .padding(10)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      //水平线性布局
      Text('水平线性布局').fontSize(18).fontWeight(FontWeight.Bold).margin({ top: 20, bottom: 10 })
      Row({ space: 10 }) {
        Text('项目A').width('30%').height(50).backgroundColor('#FFDDDD')
        Text('项目B').width('30%').height(50).backgroundColor('#DDFFDD')
        Text('项目C').width('30%').height(50).backgroundColor('#DDDDFF')
      }
      .width('90%')
      .padding(10)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}