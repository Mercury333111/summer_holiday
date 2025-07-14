import router from '@ohos.router'
import { ConfigUtil as Config } from './common/ConfigUtil'
import { searchSong } from './common/Api'
import { SongListModel, SingerModel, SongModel, searchCateNameModel } from './model/AppModel'
import { ParamModel } from './model/paramModel'
import promptAction from '@ohos.promptAction'
import { PullToRefresh } from '@ohos/pulltorefresh'
import { SearchNav } from './widget/SearchNav'

import { SubHeaderItemWidget } from './widget/SubHeaderItemWidget'
import searchService from './services/SearchService'
import inputMethod from '@ohos.inputMethod'
import { AnimatorParams } from '@kit.MediaLibraryKit'
import { StatusBarViewExtensionAbility } from '@kit.StatusBarExtensionKit'

@Entry
@Component
struct songList {
  @State type: number = 1
  @State cid: string = ""
  @State keywords: string = ""
  @State songList: SongListModel[] = []
  private scroller: Scroller = new Scroller();
  @State page: number = 1
  @State hasMore: boolean = true
  @State sort: string = ""
  @State selectedSubHeaderIndex: number = 0
  @State subHeaderList: searchCateNameModel[] = [
    new searchCateNameModel(1, "歌曲", 1,),
    new searchCateNameModel(2, "歌手", 2,),
    new searchCateNameModel(3, "歌单", 3,),
  ];

  aboutToAppear() {
    let params: ParamModel = router.getParams() as ParamModel;
    this.keywords = params.keywords ?? ""
    this.getSongListData()
  }

  async getSongListData(songCate?: searchCateNameModel | undefined) {
    console.log("getSongListData" + songCate?.type)
    let params: ParamModel
    params = {
      type: songCate ? songCate.type : 1,
      keywords: this.keywords,
      page: this.page
    }
    //console.log("params"+JSON.stringify(params))
    const res = await searchSong(params)
    let tempData: SongListModel[] = JSON.parse(JSON.stringify(res.data)).list
    console.log("tempData" + JSON.stringify(tempData))
    this.songList = this.songList.concat(tempData)
    console.log("songList:" + JSON.stringify(this.songList))
    this.page++
    if (tempData.length < 6) {
      this.hasMore = false
    }


  }

  //筛选数据
  changeSubHeader(key: number) {
    console.log('changeSubHeader', key)
    this.selectedSubHeaderIndex = key
    //重置数据
    this.songList = []
    this.page = 1
    this.hasMore = true
    this.type = this.subHeaderList[key].type
    //重新请求数据
    this.getSongListData(this.subHeaderList[key])
  }

  //顶部导航和状态栏
  @Builder
  AppBarWidget() {
    Column() {
      //导航
      Row() {
        Row() {
          Image($r("app.media.back")).height(22).padding({ left: 6 }).fillColor(Color.Gray)
        }.width(20)
        .height('100%')
        .onClick(() => {
          router.back()
        })

        Row() {
          Search({
            value: this.keywords,
            placeholder: '查询 歌曲 ,歌单'
          })
            .height('96lpx')
            .backgroundColor('#FCF3EC')
            .placeholderColor(Color.Grey)
            .placeholderFont({ size: "38lpx", weight: 400 })
            .textFont({ size: "38lpx", weight: 400 })
            .margin({
              left: "44lpx",
              right: "44lpx"
            })
            .onChange(async (value) => {
              //执行搜索
              this.keywords = value
              //保存搜索关键词
              if (this.keywords != '') {
                await searchService.setHistoryData(value)
              }
              //重置数据
              this.songList = []
              this.page = 1
              this.hasMore = true
              //重新请求数据
              if (this.selectedSubHeaderIndex == 0) {
                this.getSongListData()
              }
              //隐藏键盘
              let im = inputMethod.getController()
              im.stopInputSession()
            })
        }.layoutWeight(1)
      }.width("100%").height("140lpx")
      .padding({
        left: "34lpx",
        right: "34lpx"
      }).justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor(Color.White)
  }

  //列表
  @Builder
  songListWidget() {
    Scroll(this.scroller) {
      Column({
        space: "28lpx"
      }) {
        ForEach(this.songList, (item: SongModel) => {
          Row() {
            Image(Config.SERVERURL + item.pic).width("260lpx").margin({ right: "34lpx" })
            Column() {
              Text(item.name).fontSize("44lpx").fontWeight(FontWeight.Bold)
              Text(`${item.introduction}`).fontSize("36lpx")
            }.layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceAround)
            .height("100%")
          }
          .width("100%")
          .height("440lpx")
          .backgroundColor("#ffffff")
          .borderRadius("15lpx")
          .padding("20lpx")
          .onClick(() => {
            console.log("点击了"+ item.id);
            if (this.type == 1){
              router.pushUrl({
                url: 'pages/SongsDetail',
                params: {
                  cid: item.id
                }
              })
            }else if (this.type == 2) {
              router.pushUrl({
                url: 'pages/SingerDetail',
                params: {
                  cid: item.id
                }
              })
            } else if (this.type == 3) {
              router.pushUrl({
                url: 'pages/SongListDetail',
                params: {
                  cid: item.id
                }
              })
            }
          })

        })
        if (!this.hasMore) {
          Text("-----我是有底线的-----").width("100%").margin("10lpx").textAlign(TextAlign.Center)
        }
      }.width("100%")
      .padding("28lpx")
    }.width("100%").edgeEffect(EdgeEffect.None)
  }

  //二级导航
  @Builder
  SubHeaderWidget() {
    Row() {
      ForEach(this.subHeaderList, (item: searchCateNameModel, key: number) => {
        SubHeaderItemWidget({
          item: item,
          index: key,
          selectedSubHeaderIndex: $selectedSubHeaderIndex, //@Link需要注意写法
          func: (index) => { //让子组件执行父组件的方法
            this.changeSubHeader(index)
          }
        })
      })

    }.width("100%")
    .height("120lpx")
    .backgroundColor(Color.White)
  }

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {
      Column() { //内容区域
        this.songListWidget()
        // PullToRefresh({
        //   // 必传项，列表组件所绑定的数据
        //   data: this.songList,
        //   // 必传项，需绑定传入主体布局内的列表或宫格组件
        //   scroller: this.scroller,
        //   // 必传项，自定义主体布局，内部有列表或宫格组件
        //   customList: () => {
        //     // 一个用@Builder修饰过的UI方法
        //     this.songListWidget()
        //   },
        //   // 可选项，上拉加载更多回调
        //   onLoadMore: () => {
        //     return new Promise<string>((resolve, reject) => {
        //       // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
        //       this.getSongListData()
        //     });
        //   }
        // })
      }
      .width('100%')
      .height('100%')
      .backgroundColor("#F4F4F4")
      .padding({
        top: "360lpx"
      })

      Column() { //头部
        SearchNav({
          keywords: this.keywords,
          songList: this.songList,
          page: this.page,
          hasMore: this.hasMore,
          selectedSubHeaderIndex: this.selectedSubHeaderIndex,
          getSongListData: () => {
            this.getSongListData()
          }


        })
        this.SubHeaderWidget()
      }.width('100%')
    }

  }
}