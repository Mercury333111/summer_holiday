import router from '@ohos.router'
import searchService from './services/SearchService'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Search1 {
  @State historySearch: string[] = []
  @State hotSearch: string[] = ['愿望', '青花瓷', '明天']
  @State keywords: string = ""

  aboutToAppear() {
    this.getHistoryData() //获取历史记录
  }

  //获取历史记录
  async getHistoryData() {
    this.historySearch = await searchService.getHistoryData()
  }
  //保存历史记录执行跳转
  async doSearch() {
    if (this.keywords != "") {
      await searchService.setHistoryData(this.keywords)
    }
    //替换路由
    router.replaceUrl({
      url: 'pages/SearchList',
      params: {
        "keywords": this.keywords,
        "cid": ""
      }
    })
  }

  //自定义组件必须使用根组件来包裹
  @Builder
  AppBarWidget() {
    Column() {
      //导航
      Row() {
        Row() {
          Image($r("app.media.back")).height("50lpx").padding({ left: "6lpx" })
        }.width("40lpx")
        .height('100%')
        .onClick(() => {
          router.back()
        })

        Row() {
          Search({
            value: this.keywords,
            placeholder: '查歌曲'
          })
            .height('96lpx')
            .backgroundColor('#cccccc')
            .placeholderColor('#999999')
            .placeholderFont({ size: "38lpx", weight: 400 })
            .textFont({ size: "38lpx", weight: 400 })
            .onChange((value: string) => {
              this.keywords = value
            })
            .margin({
              left: "44lpx",
              right: "44lpx"
            })
            .onSubmit(() => {
              this.doSearch()
            })
            .onFocus(() => {
              //模拟点击的方法
              //sendEventByKey("searchId", 10, "")
            })
            .id("searchId")
        }.layoutWeight(1)

        Row() {
          Text("搜索").fontSize("38lpx")
        }.width("100lpx").onClick(() => {
          this.doSearch()
        })
      }.width("100%").height("140lpx")
      .padding({
        left: "34lpx",
        right: "34lpx"
      }).justifyContent(FlexAlign.SpaceBetween)
    }
  }

  build() {
    Column() {
      this.AppBarWidget()
      Scroll() {
        Column() {
          if (this.historySearch.length > 0) {
            Row() {
              Text("搜索历史").padding({ left: "28lpx" }).fontSize('44lpx').fontWeight(FontWeight.Bold)
              Image($r("app.media.delete1")).width("70lpx").padding({ right: "28lpx" }).onClick(async () => {

                promptAction.showDialog({
                  title: "提示信息!",
                  message: '您确定要清空历史记录吗？',
                  buttons: [
                    {
                      text: '取消',
                      color: '#FF0000'
                    },
                    {
                      text: '确认',
                      color: '#0099FF'
                    }
                  ]
                }).then(async (result) => {
                  if (result.index === 1) {
                    await searchService.cleanHistoryData()
                    this.getHistoryData() // 再次获取历史记录
                  }
                })

              })
            }.width("100%")
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: "40lpx", bottom: "20lpx" })

            Flex({
              wrap: FlexWrap.Wrap
            }) {
              ForEach(this.historySearch, (item: string) => {
                Button({
                  type: ButtonType.Normal
                }) {
                  Text(item).fontSize("34lpx")
                }
                .padding({
                  left: "34lpx",
                  right: "34lpx",
                  top: "14lpx",
                  bottom: "14lpx"
                })
                .margin("20lpx")
                .backgroundColor("#eee")
                .borderRadius("14lpx")
                .onClick(() => {
                  this.keywords = item
                })
                .gesture(
                  LongPressGesture(
                    { duration: 1000 }
                  ).onAction(() => {
                    promptAction.showDialog({
                      title: "提示信息!",
                      message: '您确定要删除吗？',
                      buttons: [
                        {
                          text: '取消',
                          color: '#FF0000'
                        },
                        {
                          text: '确认',
                          color: '#0099FF'
                        }
                      ]
                    }).then(async (result) => {
                      if (result.index === 1) {
                        await searchService.deleteHistoryData(item)
                        this.getHistoryData()
                      }
                    })
                  })
                )
              })
            }
          }

          Row() {
            Text("猜你想搜").padding({ left: "28lpx" }).fontSize('44lpx').fontWeight(FontWeight.Bold)
          }.width("100%")
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: "40lpx", bottom: "20lpx" })

          Flex({
            wrap: FlexWrap.Wrap
          }) {
            ForEach(this.hotSearch, (item: string) => {
              Button({
                type: ButtonType.Normal
              }) {
                Text(item).fontSize("34lpx")
              }
              .padding({
                left: "34lpx",
                right: "34lpx",
                top: "14lpx",
                bottom: "14lpx"
              })
              .margin("20lpx")
              .backgroundColor("#eee")
              .borderRadius("14lpx")
              .onClick(() => {
                this.keywords = item
              })
            })
          }

        }.width("100%")
      }
    }
    .width('100%')
    .height('100%')
  }
}