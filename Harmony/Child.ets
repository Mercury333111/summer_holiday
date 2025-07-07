@Component
export  struct Child {
  // @State  子级接受父级 num值但不能修改 num值
  // @Link   父子双向传值 ： 父组件改变子组件num值，子组件也能改变父组件num值
  // @Prop  父向子传值: 父组件改变子组件num值，子组件不能改变父组件num值
  @Link num: number
  @State color: ResourceColor = Color.Blue
  build() {
    Column() {
      Text(`子级的计数${this.num}`)
      Button(){
        Text('子组件点击')
      }
      .padding(10)
      .margin(10)
      .backgroundColor(this.color)
      .onClick(()=>{
        this.num += 1
      })
    }
  }
}