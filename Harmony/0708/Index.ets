import{Home} from './Home'
import{Cate} from './Cate'
import{Cart} from './Cart'
import{Mine} from './Mine'
@Entry
@Component
struct Index {
  @State currentIndex:number = 0
  @Builder
  TabBarBuilder(title:string,index:number,icon:Resource,selectedIcon:Resource){
    Column() {
        Image(this.currentIndex === index ? selectedIcon : icon)
        .width(25)
        .height(25)
        Text(`${title}`)
          .fontSize(16)
          .fontColor(this.currentIndex === index ? '#d81e06' : '#6a6a6a')
          .margin({top: 5})
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }
  build() {
    Column() {
      Tabs({barPosition:BarPosition.End}){
         TabContent(){
           Home()
         }
         .tabBar(this.TabBarBuilder('首页',0,$r('app.media.user_icon'),$r('app.media.user_selected_icon')))
        TabContent(){
          Cate()
        }
        .tabBar(this.TabBarBuilder('分类',1,$r('app.media.cate_icon'),$r('app.media.cate_selected_icon')))
        TabContent(){
          Cart()
        }
        .tabBar(this.TabBarBuilder('购物车',2,$r('app.media.cart_icon'),$r('app.media.cart_selected_icon')))
        TabContent(){
          Mine()
        }
        .tabBar(this.TabBarBuilder('我的',3,$r('app.media.service_icon'),$r('app.media.service_selected_icon')))
      }
      .onChange((index)=>{
          this.currentIndex = index
      })
    }
    .height('100%')
    .width('100%')
  }
}