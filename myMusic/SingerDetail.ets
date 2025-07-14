import router from '@ohos.router';
import {ParamModel} from './model/paramModel'
import {SingerDetailModel} from './model/AppModel'
import {getSingerDetail} from './common/Api'
import {ConfigUtil as Config} from './common/ConfigUtil'
import promptAction from '@ohos.promptAction'
import { ConfigurationConstant } from '@kit.AbilityKit';
import {NavBar} from './widget/NavBar'


@Entry
@Component

struct SingerDetail {
  @State cid: number = 0
  @State singerDetail:SingerDetailModel ={}
  aboutToAppear() {
    const params:ParamModel=  (router.getParams() as ParamModel)
    this.cid = params.cid?params.cid:0 // 处理undefined
    this.getSingerDetailData()
  }
  async getSingerDetailData(){
        const params:ParamModel = {
          id:this.cid
        }
        const res = await getSingerDetail(params)
        if (res.success) {
          this.singerDetail = JSON.parse(JSON.stringify(res.data))
          console.log('getSingerDetail'+ JSON.stringify(this.singerDetail))
        }else{
          promptAction.showToast({
            message: res.message,
            duration: 5000
          })
        }
  }
  build() {
    Column() {
      NavBar({title:'歌手详情'})
      // 播放页
      Column() {
        // 歌单明细
        Column() {
          // 简介
          Row({ space: 8 }) {
            Row() {
              Image(Config.SERVERURL+this.singerDetail.pic)
                .width('80%')
                .opacity(0.8)
                .fillColor('#ff5186')
            }
            .width(100)
            .aspectRatio(1)
            .borderRadius(8)
            .backgroundColor(Color.White)
            .justifyContent(FlexAlign.Center)

            Column({ space: 12 }) {
                Text(`${this.singerDetail.name}`)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                // Text(`${this.userInfo.username}`)
                //   .fontSize(12)
                //   .fontColor('#ffa49a9a')
                Blank()

            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          // 按钮
          Row() {
            Button() {
              Row({ space: 8 }) {
                Image($r('app.media.ic_share'))
                  .width(20)
                  .fillColor('#aa5c87')
                Text('分享')
                  .fontColor(Color.White)
                  .fontSize(12)
              }
              .width(100)
              .height(36)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#ff353333')
            }
            .clip(true)

            Button() {
              Row({ space: 8 }) {
                Image($r('app.media.ic_comment'))
                  .width(20)
                  .fillColor('#aa5c87')
                Text('评论')
                  .fontColor(Color.White)
                  .fontSize(12)
              }
              .width(100)
              .height(36)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#ff353333')
            }
            .clip(true)

            Button() {
              Row({ space: 8 }) {
                Image($r('app.media.ic_collect'))
                  .width(20)
                  .fillColor('#aa5c87')
                Text('收藏')
                  .fontColor(Color.White)
                  .fontSize(12)
              }
              .width(100)
              .height(36)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#ff353333')
            }
            .clip(true)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .height('30%')
        .justifyContent(FlexAlign.SpaceAround)
        .radialGradient({
          center: ['80%', '-10%'],
          radius: '100%',
          colors: [['#ff865d13', 0.0], [Color.Transparent, 1.0]]
        })
        .padding(16)
        // 播放列表
        Column() {
          Row({ space: 8 }) {
            Row({space:8}){
              Image($r("app.media.ic_play"))
                .width(16)
                .fillColor('#ff5186')
              Text(`播放全部 (${this.singerDetail.songs?this.singerDetail.songs.length:0})`)
                .fontColor('#333333')
                .fontSize(14)
            }
          }
          .width('100%')
          .padding(16)
          .border({
            width: { bottom: 1 },
            color: '#12ec5c87'
          })

          Column() {
            List() {
              ForEach(this.singerDetail.songs, (item: SingerDetailModel, index: number) => {
                ListItem() {
                  Row() {
                    // 前三首
                    Row() {
                      if (index === 0) {
                        Text((index + 1).toString())
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#ffffe426')
                      } else if (index === 1) {
                        Text((index + 1).toString())
                          .fontColor('#ff6600')
                          .fontWeight(FontWeight.Bold)
                      } else if (index === 2) {
                        Text((index + 1).toString())
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#ff6600')
                      } else {
                        Text((index + 1).toString())
                          .fontColor('#ffa49a9a')
                      }
                    }
                    .width(50)
                    .aspectRatio(1)
                    .justifyContent(FlexAlign.Center)
                    // 列表
                    Row({ space: 10 }) {
                      Image(Config.SERVERURL+item.pic)
                          .width(32)
                          .aspectRatio(1)
                          .borderRadius(4)
                      Column() {
                        Text(item.name)
                          .fontSize(14)
                          .fontColor('#000000')
                        Text(item.name)
                          .fontSize(12)
                          .fontColor(Color.Gray)
                      }
                      .layoutWeight(1)
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.Center)
                    }
                    .layoutWeight(1)

                    Image($r('app.media.ic_more'))
                      .width(24)
                      .height(24)
                      .margin({ right: 16 })
                      .fillColor(Color.Gray)
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .border({
                  width: { bottom: 1 },
                  color: '#12ec5c87'
                })
                .onClick(()=>{
                  //点击播放
                  console.log('+++++playone')
                  //AvPlayerUtils.playSingle(item)
                })
              })

              ListItem() {
                Row() {
                  Text('我是有底线的~')
                    .fontColor(Color.Gray)
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .padding(16)
              }
            }
            .layoutWeight(1)
          }
          .layoutWeight(1)
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor('#aaaaaa')
        .borderRadius({ topLeft: 12, topRight: 12 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#eeeeee')
  }
}

