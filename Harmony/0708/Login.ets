import {keyWords} from './model/paramModel'
import router from '@ohos.router';
import {NavBar} from './widget/NavBar'
@Entry
@Component
struct Login {
  // router.getParams() 接受传值数据
  @State keywords: string = (router.getParams() as keyWords).keyword
  @State type: number = (router.getParams() as keyWords).type
  build() {
    Column() {
      NavBar({title: '登录页面'})
      Text(`登录页面：${this.keywords}--${this.type}`).fontSize(30)
      Button('返回').onClick(()=>{
        router.back()
      })
    }
  }
}