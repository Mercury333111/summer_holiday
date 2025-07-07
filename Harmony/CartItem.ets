import {CartModel} from './model/CartModel'
@Component
export struct CartItem {
  @ObjectLink item: CartModel
  build() {
     Row(){
       Text('-').fontSize(18)
         .fontColor(Color.Gray)
         .width(30)
         .textAlign(TextAlign.Center)
         .onClick(()=>{
           if (this.item.count > 1) {
             this.item.count--
           }
         })
       Text(`${this.item.count}`)
         .fontSize(18)
         .textAlign(TextAlign.Center)
         .height(30)
         .layoutWeight(1)
         .borderWidth({left:1,right:1})
         .borderColor(Color.Gray)
         .borderStyle(BorderStyle.Solid)
       Text('+').fontSize(18)
         .width(30)
         .fontColor(Color.Gray)
         .textAlign(TextAlign.Center)
         .onClick(()=>{
           this.item.count++
         })
     }
     .width(100)
     .height(30)
     .justifyContent(FlexAlign.SpaceBetween)
     .borderWidth(1)
     .borderColor(Color.Gray)
     .borderStyle(BorderStyle.Solid)

  }
}