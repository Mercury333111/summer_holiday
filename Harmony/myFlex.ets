//多行布局
//e.g. 搜索记录，实现折行，列数不固定
/*
@Entry
@Component
struct myFlex {
  @State message : string = "hello world";
  @State hotSearch : string[] = ["歌手", "歌曲", "午夜DJ", "爱炉迪克", "MV",  "刻板印象", "弱水三千"]
  build() {
    Column() {
      Text('热门搜索')
        .fontSize(20)
        .padding(10)
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.hotSearch, (item: string) => {
          Text(item)
            .fontSize(16)
            .padding(10)
            .backgroundColor(Color.White)
            .fontColor(Color.Black)
            .margin(5)
            .borderRadius(5)
            .borderWidth(1)
            .borderColor(Color.Gray)
        }, (item:string) => item.toString())
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#eeeeeee')
  }
}
*/
@Entry
@Component
struct myFlex1 {
  @State message : string = "hello world";
  @State hotSearch : string[] = ["歌手", "歌曲", "午夜DJ", "爱炉迪克", "MV",  "刻板印象", "弱水三千"]
  build() {
    Column() {
      Flex({
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.SpaceAround,
        alignItems:ItemAlign.Center,
      }){
        Text('1').width(100).height(50).backgroundColor(Color.Yellow)
        Text('2').width(100).height(50).backgroundColor(Color.Pink)
          .alignSelf(ItemAlign.Baseline)
        Text('3').width(100).height(50).backgroundColor(Color.Green)
        Text('4').width(100).height(50).backgroundColor(Color.Orange)
      }
    }
    .width('100%')
    .height(300)
    .backgroundColor('#eeeeeee')
  }
}
