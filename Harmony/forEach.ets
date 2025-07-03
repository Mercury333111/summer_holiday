interface IUser {
  id: number;
  name: string;
  age: number;
  sex: string;
}
@Entry
@Component
struct Index{
  @State curIndex: number = 1
  @State user: IUser[] = [
    { id: 1, name: '张三', age: 18, sex: '男' },
    { id: 2, name: '李四', age: 19, sex: '女' },
    { id: 3, name: '王五', age: 20, sex: '男' }
  ]
  build() {
    Column({ space: 20 }) {
      ForEach(this.user, (item: IUser) => {
        Text(`id:${item.id} name:${item.name} age:${item.age} sex:${item.sex}`)
      },(item:IUser)=>item.id.toString())
      List({space:20}){
        ForEach(this.user,(item:IUser)=>{
          ListItem(){
            Text(`id:${item.id} name:${item.name} age:${item.age} sex:${item.sex}`)
              .fontSize(20)
              .width('100%')
              .padding(20)
              .backgroundColor(this.curIndex == item.id?Color.Red:Color.Gray)
              .textAlign(TextAlign.Center)
              .onClick(()=>{
                this.curIndex = item.id
              })
          }
        },(item:IUser)=>item.id.toString())
      }
    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
  }
}