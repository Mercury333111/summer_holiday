@Entry
@Component
struct blank{
  @State isOn :boolean=false  //监听
  build(){
    Column(){
      Row(){
        if(this.isOn){
          Text("空调：开启").fontSize(18).fontColor(Color.Green)
        } else{
          Text("空调：关闭").fontSize(18).fontColor(Color.Black)
        }
        Blank()
        Toggle({type:ToggleType.Switch, isOn:false})
          .onChange((isOn)=>{
            this.isOn = isOn
          })
      }
      .backgroundColor('#ffffff')
      .borderRadius(10)
      .padding({left:10,right:10,top:10,bottom:10})
      .width('100%')
    }
    .backgroundColor('#efefef')
    .padding(20)
    .width('100%')
  }
}