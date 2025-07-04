@Entry
@Component
//网格布局
struct MyGrid {
  @State lists:number[] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  build() {
    Grid(){
      ForEach(this.lists, (item: number) => {
        GridItem(){
          Text('1')
          .fontSize(18)
          .fontColor(Color.Black)
          .padding(10)
          .backgroundColor(Color.Gray)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
        }
      }, (item:number)=>item.toString())
    }
    .rowsTemplate('1fr 1fr 1fr')
    .columnsGap(10)
    .rowsGap(10)
    .width('100%')
    .height('100%')
  }
}