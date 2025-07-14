import http from '@ohos.net.http';
import {SwiperModel,SongListModel,SingerModel} from '../model/AppModel'
import {getSwiperList,getRecommendSongList,getRecommendSinger} from '../common/Api'
import {ConfigUtil as Config} from '../common/ConfigUtil'
import router from '@ohos.router';
@Component
export struct Home{
  @State swiperList:SwiperModel[] = []
  @State songList:SongListModel[] = []
  @State singerList:SingerModel[] = []
  // 获取轮播图接口
  async getSwiperData(){  /// async...await
    const res = await getSwiperList()
    this.swiperList = JSON.parse(JSON.stringify(res.data))
    console.log('swiperList'+ JSON.stringify(this.swiperList))
  }
  // 获取推荐歌单接口
  async recommendSongListData(){
    const res = await getRecommendSongList()
    this.songList = JSON.parse(JSON.stringify(res.data))

  }
  // 获取推荐歌手接口
  async recommendSingerData(){
    const res = await getRecommendSinger()
    this.singerList = JSON.parse(JSON.stringify(res.data))

  }
  // 生命周期
  aboutToAppear(): void {
    this.getSwiperData()
    this.recommendSongListData()
    this.recommendSingerData()
  }
  @Builder
  getSwiperListWidget(){
    Swiper() {
      ForEach(this.swiperList, (item: SwiperModel) => {
        Image(`${Config.SERVERURL}${item.imgurl}`)
          .width('100%')
          .height(200)
          .objectFit(ImageFit.Cover)
      }, (item: SwiperModel) => item.id.toString())
    }
    .loop(true)  //无限循环
    .autoPlay(true) // 自动播放
    .interval(2000) // 轮播间隔时间
    //.displayArrow(true)
    .indicator(  // 指示器
      Indicator.dot()
        .left(0)
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color('#999999')
        .selectedColor('#ff6600')
    )
    .height(230)
  }
  @Builder
  getSongListWidget(){
    //   推荐歌单
    Column() {
      this.TitleBar('推荐歌单')
      // 歌单项
      Row() {
        Flex({
          wrap:FlexWrap.Wrap
        }){
          ForEach(this.songList, (item: SongListModel) => {
            Column() {
              Row() {
                Image(Config.SERVERURL +item.pic)
                  .width('100%')
                  .aspectRatio(1)
                  .borderRadius(8)
                Text(item.style)
                  .fontColor(Color.White)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .position({
                    x: 6,
                    y: 6
                  })
              }
              Text(item.title)
                .textAlign(TextAlign.Start)
                .fontSize(12)
                .fontColor('#000000')
                .maxLines(2)
                .textOverflow({
                  overflow: TextOverflow.Ellipsis
                })
                .margin({
                  top: 8
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('33%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/SongListDetail',
                params: {
                  cid: item.id
                }
              })
            })
          })
        }
      }
      .padding({
        left: 8,
        right: 8
      })
    }
  }
  @Builder
  getSingrWidget(){
    // 推荐歌手
    Column() {
      this.TitleBar('推荐歌手')
      // 歌单项
      Row() {
        Scroll() {
          Row({ space: 8 }) {
            ForEach(this.singerList, (item: SingerModel) => {
              Column() {
                Row() {
                  Image(Config.SERVERURL+item.pic)
                    .width('100%')
                    .borderRadius(8)
                  Text(item.name)
                    .fontColor(Color.White)
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .position({
                      x: 6,
                      y: 6
                    })
                }

                Text(item.name)
                  .textAlign(TextAlign.Start)
                  .fontSize(12)
                  .fontColor('#FFE9DFDF')
                  .maxLines(2)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
                  .margin({
                    top: 8
                  })
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .width('30%')
              .onClick(()=>{
                router.pushUrl({
                  url: 'pages/SingerDetail',
                  params: {
                    cid: item.id
                  }
                })
              })
            })
          }
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)
      }
      .padding({
        left: 8,
        right: 8
      })
    }
  }
  // 标题
  @Builder
  TitleBar(title: string) {
    // 标题
    Row() {
      Text(title)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .fontSize(18)

      Text('更多')
        .fontColor(Color.Gray)
        .onClick(() => {
          if (title=='推荐歌单') {
            router.pushUrl({url:'pages/AllSongList'})
          }else{
            router.pushUrl({url:'pages/AllSingerList'})
          }
        })
    }
    .width('100%')
    .height(50)
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }
  // 搜索框
  @Builder
  SearchInput() {
    Row() {
      Row({ space: 4 }) {
        Image($r('app.media.ic_search'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#6a828e')
        Text('生如夏花🔥')
          .fontColor('#6a828e')
          .layoutWeight(1)
        Image($r('app.media.ic_code'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#6a828e')
      }
      .width('100%')
      .padding(12)
      .borderRadius('60')
      .backgroundColor('#cccccc')
      .onClick(()=> {
        router.pushUrl({
          url: "pages/Search1"
        })
      })
    }
    .width('100%')
    .padding(12)
  }
  build() {
    Column() {
      Scroll(){
        Column() {
          this.SearchInput()
          this.getSwiperListWidget()
          this.getSongListWidget()
          this.getSingrWidget()
        }
      }

    }
    .width('100%')
    .height('100%')
  }
}