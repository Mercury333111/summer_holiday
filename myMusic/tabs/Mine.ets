import router from '@ohos.router'; // 路由跳转

import { UserModel } from '../model/AppModel'
import { LoginModel } from '../model/paramModel'
import userService from '../services/UserService'

interface UserInfo {
  avatar: Resource; // 头像资源
  nickname: string; // 昵称
  signature: string; // 个性签名
}

interface ListItem {
  icon: Resource; // 图标资源
  name: string; // 标题
  route: string; // 描述
}

@Component
export struct Mine {
  @StorageLink("isLogin") isLogin: boolean = false
  @StorageLink("userInfo") userInfo: UserModel = {}

  //退出登录
  loginOut() {
    //清除用户数据
    userService.cleanUserData()
    this.isLogin = false
    this.userInfo = {}
  }

  // 功能选项数据
  @State list: ListItem[] = [
    { icon: $r('app.media.ic_favorite'), name: '我的歌单', route: 'OrderPage' },
    { icon: $r('app.media.ic_music'), name: '我的浏览记录', route: 'CollectionPage' },
    { icon: $r('app.media.setting'), name: '设置', route: 'SettingPage' }
  ];

  build() {
    Column() {
      // 1. 顶部用户信息区
      this.buildUserInfoArea()

      // 2. 功能选项列表
      List() {
        ForEach(this.list, (item: ListItem) => {
          ListItem() {
            this.buildFunctionItem(item)
          }
          .onClick(() => {
            // 跳转至对应页面
            router.pushUrl({ url: item.route })
          })
        })
      }
      .padding(16)
      .margin({ top: 20 })
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 3. 底部信息
      this.buildFooter()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EEEEEE')
  }

  // 构建用户信息区
  @Builder
  buildUserInfoArea() {
    Column() {
      // 背景图
      Image($r('app.media.found'))
        .width('100%')
        .height(200)
        .objectFit(ImageFit.Cover)
        .zIndex(1)

      // 头像（覆盖在背景图下方）
      //用户头像 和用户名
      Row() {
        if (this.isLogin) {
          Image($r("app.media.user")).width("148lpx").height("148lpx").borderRadius("74lpx")
        } else {
          Image($r("app.media.user")).width("148lpx").height("148lpx").borderRadius("74lpx").onClick(() => {
            router.pushUrl({
              url: "pages/Login"
            })
          })
        }


        Column() {
          if (this.isLogin) {
            Column() {
              Text(`${this.userInfo.username}`).fontSize("33lpx")
              Text("普通会员").fontSize("33lpx")
            }.alignItems(HorizontalAlign.Start)
            .height("148lpx")
            .justifyContent(FlexAlign.SpaceAround)
          } else {
            Text("登录/注册").fontSize("33lpx").width("100%").onClick(() => {
              router.pushUrl({
                url: "pages/pass/CodeLoginStepOne"
              })
            })
          }


        }
        .width("600lpx")
        .alignItems(HorizontalAlign.Start)
        .height("148lpx")
        .justifyContent(FlexAlign.SpaceAround)
        .margin({
          left: "40lpx"
        })

      }.height("188lpx").width("100%").position({ x: '20%', y: 70 }) // 调整位置覆盖背景
      .zIndex(2)

    }
    .width('100%')
  }

  // 构建功能选项Item
  @Builder
  buildFunctionItem(item: ListItem) {
    Row() {
      Image(item.icon)
        .width(24)
        .height(24)
        .fillColor(Color.Grey)
      Text(item.name)
        .fontSize(16)
        .margin({ left: 16 })
      Blank() // 推到右侧
      Image($r('app.media.right_arrow'))
        .width(16)
        .height(16)
        .opacity(0.6)
    }
    .padding(12)
    .width('100%')
  }

  // 构建底部信息
  @Builder
  buildFooter() {
    Column() {
      Button('退出登录')
        .fontSize(14)
        .backgroundColor('#4781c3')
        .margin({ top: 20 })
        .onClick(() => {
          this.loginOut()
        })
    }
  }
}