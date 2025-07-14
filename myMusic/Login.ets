import router from '@ohos.router'
import {UserModel } from './model/AppModel'
import {LoginModel} from './model/paramModel'
import inputMethod from '@ohos.inputMethod'
import { ConfigUtil as Config } from './common/ConfigUtil'
import preferencesUtil from './common/PreferencesUtil'
import promptAction from '@ohos.promptAction'
import {login} from './common/Api'
@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#99182431')
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('328vp')
  .margin({ top: 12 })
}

@Extend(Line)
function lineStyle() {
  .width('328vp')
  .height('1vp')
  .backgroundColor('#33182431')
}

@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}
@Entry
@Component
export struct Comment {
  // @State account: string = '';
  // @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  pathStack: NavPathStack = new NavPathStack();

  @State username: string = ''
  @State password: string = ''
  @StorageLink("isLogin") isLogin: boolean = false
  @StorageLink("userInfo") userInfo: UserModel = {}
  //登录
  async doLogin() {
    //隐藏键盘
    let im = inputMethod.getController()
    im.stopInputSession()
      const response = await login({
        username: this.username,
        password: this.password
      })
      console.log('response', JSON.stringify(response))
      if (response.success) {
        //执行登录
        //保存用户信息  preferencesUtil本地存储
        let user :string = JSON.stringify(response.data?response.data["user"]:"")
        await preferencesUtil.set("userinfoStore", "userinfo", user)
        //token
        //同步用户信息  状态管理
        this.isLogin = true
        this.userInfo = response.data?response.data["user"]:""
        PersistentStorage.persistProp("isLogin", this.isLogin)
        PersistentStorage.persistProp("userInfo", this.userInfo)
        router.back()
      } else {
        promptAction.showToast({
          message: response.message,
          duration: 5000
        })
      }

  }
  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height('48vp')
    .width('48vp')
    .backgroundColor('#F1F3F5')
  }
  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
      Column() {
        Image($r('app.media.logo'))
          .width('78vp')
          .height('78vp')
          .margin({ top: '150vp', bottom: '8vp' })
        Text('登录界面')
          .fontSize('24fp')
          .fontWeight(FontWeight.Medium)
          .fontColor('#182431')
        Text('更多')
          .fontSize('16fp')
          .fontColor('#99182431')
          .margin({
            bottom: '30vp',
            top: '8vp'
          })

        TextInput({placeholder:'请输入用户'})
          .maxLength(11)
          .type(InputType.Normal)
          .inputStyle()
          .onChange((value: string) => {
            this.username = value;
          })
        Line()
          .lineStyle()

        TextInput({ placeholder: '请输入密码'})
          .maxLength(8)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value;
          })
        Line()
          .lineStyle()

        Row() {
          Text('验证码登录')
            .blueTextStyle()
          Text('忘记密码')
            .blueTextStyle()
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('328vp')
        .margin({ top: '8vp' })

        Button('登录', { type: ButtonType.Capsule })
          .width('328vp')
          .height('40vp')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#4781c3')
          .margin({
            top: '48vp',
            bottom: '12vp'
          })
          .onClick(() => {
            this.doLogin()
          })
        Text('注册账号')
          .fontColor('#007DFF')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)

        if (this.isShowProgress) {
          LoadingProgress()
            .color('#182431')
            .width('30vp')
            .height('30vp')
            .margin({ top: '20vp' })
        }

        Blank()
        Text('其他登录方式')
          .fontColor('#838D97')
          .fontSize('12fp')
          .fontWeight(FontWeight.Medium)
          .margin({
            top: '50vp',
            bottom: '12vp'
          })
        Row({ space: 44 }) {
          this.imageButton($r('app.media.login_method1'))
          this.imageButton($r('app.media.login_method2'))
          this.imageButton($r('app.media.login_method3'))
        }
        .margin({ bottom: '16vp' })
      }
      .height('100%')
      .width('100%')
      .padding({
        left: '12vp',
        right: '12vp',
        bottom: '24vp'
      })
  }
}