import { router } from "@kit.ArkUI"
@Component
export struct NavBar{
  @Prop title: string = ''
  build() {
    Column() {
      Row(){
        Image($r('app.media.back')).fillColor(Color.White)
          .width(30)
          .height(30)
          .onClick(()=>{
            router.back()
          })
          Text(`${this.title}`)
            .fontSize(20)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
          // 插值
          // Row(){
          //   if(this.child){
          //     this.child()
          //   }
          // }
          // .width(30)
      }
      .height(50)
      .alignItems(VerticalAlign.Center)
    }
    .backgroundColor(Color.Gray)
  }
}