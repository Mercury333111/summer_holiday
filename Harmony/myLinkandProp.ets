import {Child} from './Child'
@Entry
@Component
struct LinkandProp13 {
  @State num: number = 1
  build() {
    Column() {
      Text(`父级的计数${this.num}`)
      Button(){
        Text('点击')
      }
      .padding(10)
      .margin(10)
      .onClick(()=>{
        this.num += 1
      })
      Child({
        num: this.num,
        color: Color.Red
      })
      Child({
        num: this.num,
        color: Color.Orange
      })
    }
    .width('100%')
    .height('100%')
  }
}