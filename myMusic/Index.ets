import{Home} from './tabs/Home'
import{Comment} from './tabs/Comment'
import{LikeSongList} from './tabs/LikeSongList'
import{Mine} from './tabs/Mine'
import {tabsData,TabBarModel} from './model/TabBar'
import userService from './services/UserService'
import { UserModel } from './model/AppModel'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router';


@Entry
@Component
struct Index {
  @StorageLink("isLogin") isLogin: boolean = false
  @StorageLink("userInfo") userInfo: UserModel = {}
  @State currentName:string = 'home'
  aboutToAppear() {
    this.initUser()
  }
  //获取用户登录状态
  async initUser() {
    let tempUserInfo = await userService.getUserData()
    if (tempUserInfo.username != undefined) {
      this.isLogin = true
      this.userInfo = tempUserInfo
      PersistentStorage.persistProp("isLogin", this.isLogin)
      PersistentStorage.persistProp("userInfo", this.userInfo)
      console.log(JSON.stringify(tempUserInfo)+'用户信息===============')
    }
  }
  @Builder
  TabBarWidget(item:TabBarModel){
    Column() {
      Row() {
        Image(item.icon)
          .fillColor(Color.White)
          .width(item.name === this.currentName ? 18 : 22)
          .aspectRatio(1)
      }
      .width(22)
      .aspectRatio(1)
      .borderRadius(22)
      .backgroundColor(item.name === this.currentName ? '#753061' : Color.Transparent)
      .justifyContent(FlexAlign.Center)
      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.currentName ? '#753061' : '#ffffff')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .margin({ top: 10 })
  }
  build() {
    Column() {
      Tabs({barPosition:BarPosition.End}) {
        ForEach(tabsData, (item:TabBarModel) => {
            TabContent(){
              if(item.name == 'home'){
                Home()
              }else if(item.name == 'likeSongList') {
                LikeSongList()
              }else if(item.name == 'comment') {
                Comment()
              }else if(item.name == 'mine') {
                Mine()
              }

            }
            .tabBar(this.TabBarWidget(item))
            .backgroundColor('#eeeeee')
        },(item:TabBarModel)=>item.name)
      }
      .onChange((index)=>{
        this.currentName = tabsData[index].name
      })
      .backgroundColor('#4781c3')
    }
    .height('100%')
    .width('100%')



  }
}