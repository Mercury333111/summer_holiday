import {CartItem} from './CartItem'
import {CartModel} from './model/CartModel'
// @Observed 和 @ObjectLink  结合使用，实现对象传值修改 (必须用class实现)
@Entry
@Component
struct ObjectLink14 {
  @State cart: CartModel[] =[
    new CartModel(1, 'iphone', 8888, 1),
    new CartModel(2, 'ipad', 2000, 1),
    new CartModel(3, 'mac', 3000, 1)
  ]
  build() {
    Column() {
      List({space: 20}){
        ForEach(this.cart, (item:CartModel) => {
          ListItem(){
            Row() {
              Text(item.title)
              Text('单价：' + item.price)
              CartItem({item: item})
            }
            .justifyContent(FlexAlign.SpaceAround)
            .width('100%')
          }
          .backgroundColor('#eeeeee')
          .padding(20)
        },(item:CartModel) => item.id.toString())
      }
    }
    .width('100%')
    .height('100%')
  }
}