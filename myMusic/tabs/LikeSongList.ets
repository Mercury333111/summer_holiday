import { SongModel, MySongModel, UserModel } from '../model/AppModel'
import { geMySongList,addComment  } from '../common/Api'
import { AddCommentParam } from '../model/paramModel'
// promptAction
import promptAction from '@ohos.promptAction'
import router from '@ohos.router';
import CommentService from '../services/CommentService'

@Component
export struct LikeSongList {
  @StorageLink("isLogin") isLogin: boolean = false
  @StorageLink("userInfo") userInfo: UserModel = {}
  @State mySongList: MySongModel[] = []
  @State isShowComment: boolean = false
  @State content: string = ''
  @State songId :number= -1
  aboutToAppear() {

    this.getMySongData()
  }

  //获得我的歌单
  async getMySongData() {
    const response = await geMySongList()
    if (response.success) {
      let data = JSON.stringify(response.data)
      this.mySongList = JSON.parse(data)
      console.log("我的歌单：" + JSON.stringify(this.mySongList))
    } else {
      promptAction.showToast({
        message: response.message,
        duration: 5000
      })
    }
  }
  @Builder
  myBuilder() {
    Column() {
      Column(){}.height(50)
      Row({ space: 10 }) {
        TextInput({ placeholder: '请输入内容' })
          .layoutWeight(1)
          .onChange((value) => {
            this.content = value
          })
        Button('发布')
          .fontSize(20)
          .onClick(() => {
            addComment({ content: this.content, up: 0, songId: this.songId }).then(res => {
              console.log('1111222' + JSON.stringify(res))
              CommentService.getSongCommentData()
            })
            this.isShowComment = false;
          })
      }
      .margin({ bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
  }
  build() {
    if (this.isLogin) {
      Column() {
        // 播放页
        Column() {
          // 歌单明细
          Column() {
            // 简介
            Row({ space: 8 }) {
              Row() {
                Image($r('app.media.ic_favorite'))
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

                Text('我喜欢的音乐')
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text(`普通会员：${this.userInfo.username}`)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .fontSize(12)
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
                    .fillColor('#ec5c87')
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
                    .fillColor('#ec5c87')
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
                    .fillColor('#ec5c87')
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
              Row({ space: 8 }) {
                Image($r("app.media.ic_play"))
                  .width(16)
                  .fillColor('#ff5186')
                Text(`播放全部 (${this.mySongList.length})`)
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
                ForEach(this.mySongList, (item: MySongModel, index: number) => {
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
                            .fontColor('#ffffcc00')
                            .fontWeight(FontWeight.Bold)
                        } else if (index === 2) {
                          Text((index + 1).toString())
                            .fontWeight(FontWeight.Bold)
                            .fontColor('#ffff9900')
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
                        if (index < 3) {
                          Image(item.song.pic)
                            .width(32)
                            .aspectRatio(1)
                            .borderRadius(4)
                        }
                        Column() {
                          Text(item.song.name)
                            .fontSize(14)
                            .fontColor('#000000')
                          Text(item.singer['name'])
                            .fontSize(12)
                            .fontColor(Color.Gray)
                        }
                        .layoutWeight(1)
                        .alignItems(HorizontalAlign.Start)
                        .justifyContent(FlexAlign.Center)
                        Column() {
                          Image($r('app.media.ic_comment_o'))
                            .onClick(()=>{
                              this.isShowComment = !this.isShowComment
                              this.songId = item.song.id
                            })
                        }
                        .width(20)
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
                  .onClick(() => {
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
            .bindSheet(this.isShowComment, this.myBuilder(), {
              height: 200,
              backgroundColor: '#ffffff',
              maskColor: Color.Gray,
              onDisappear: () => {
                this.isShowComment = false; // 确保任何方式关闭弹窗时状态都被更新
              }
            })
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
    }else{
      Button('请求登录')
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Login"
          })
        })
    }
  }
}

