@Entry
@Component
//层叠布局
struct myStack{
  build() {
    Stack({alignContent:Alignment.BottomEnd}){
      Text('1').width('90%').height('100%').backgroundColor('#00ff00').align(Alignment.BottomEnd)
      Text('2').width('60%').height('80%').backgroundColor('#ff0000').align(Alignment.BottomEnd)
      Text('3').width('30%').height('60%').backgroundColor('#0000ff').align(Alignment.BottomEnd)
    }
    .width('100%').height(150)
  }
}