import { ConfigUtil as Config } from '../common/ConfigUtil'
import { SongCommentModel } from '../model/AppModel'
import { getSongCommentList, getReplyComment, addComment } from '../common/Api'
import promptAction from '@ohos.promptAction'
import CommentService from '../services/CommentService'

@Entry
@Component
export struct Comment {
  @State isShow: boolean = false
  @State momentList: SongCommentModel[] = []
  @State getReplyCommentList: SongCommentModel[] = []
  @State currentId: number = -1
  @State replyComment: string = ''
  @State commentId: number = -1
  @State songId: number = -1
  scroller = new Scroller()

  aboutToAppear () {
    this.getSongCommentData()
  }
  async getSongCommentData(){
    this.momentList = await CommentService.getSongCommentData()
  }
  //获取歌曲评论列表


  // 通过评论ID 获取回复评论列表getReplyComment
  async getReplyCommentData(id: number) {
    const response = await getReplyComment(id)
    if (response.success) {
      let data = JSON.stringify(response.data)
      console.log("获取歌曲评论列表：" + data)
      this.getReplyCommentList = JSON.parse(data)
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
      Scroll(this.scroller) {
        Column() {
          Column() {
          }.height(50)

          List({ space: 12 }) {
            ForEach(this.getReplyCommentList, (item: SongCommentModel) => {
              ListItem() {
                Column() {
                  Row({ space: 12 }) {
                    Row() {
                      Image(Config.SERVERURL + item.consumer.avatar)
                        .borderRadius(40)
                        .width(40)
                    }

                    Column({ space: 12 }) {
                      // 作者
                      Text(item.consumer.username)
                        .fontColor('#333333')
                      // 内容
                      Text(item.content)
                        .fontColor('#333333')
                        .fontSize(12)
                    }
                  }
                }
              }
            }, (item: SongCommentModel) => item.id.toString())
          }
        }
        .height(350)
        .padding(10)
      }

      Row({ space: 10 }) {
        TextInput({ placeholder: '请输入内容' })
          .layoutWeight(1)
          .onChange((value) => {
            this.replyComment = value
          })
        Button('发布')
          .fontSize(20)
          .onClick(() => {
            addComment({ content: this.replyComment, up: this.commentId, songId: this.songId }).then(res => {
              console.log('1111222' + JSON.stringify(res))
              this.getSongCommentData()
              this.getReplyCommentData(this.commentId)
            })
            this.isShow = false;
          })
      }
      .margin({ bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('互动广场')
            .fontColor('#333333').fontSize(22).fontWeight(FontWeight.Bold)
        }
        .padding(24)
        .width('100%')

        Row() {
          List({ space: 12 }) {
            ForEach(this.momentList, (item: SongCommentModel) => {
              ListItem() {
                Row({ space: 12 }) {
                  Row() {
                    Image(Config.SERVERURL + item.consumer.avatar)
                      .borderRadius(40)
                      .width(40)
                  }

                  Column({ space: 12 }) {
                    // 作者
                    Text(item.consumer.username)
                      .fontColor('#333333')
                    // 内容
                    Text(item.content)
                      .fontColor('#333333')
                      .fontSize(12)
                    // 音乐卡片
                    Row() {
                      Image(Config.SERVERURL + item.song.pic)
                        .width(60)
                        .aspectRatio(1)
                      Column({ space: 10 }) {
                        Text(item.song.name)
                          .fontColor('#f4f4f6')
                          .fontSize(12)
                        Text(item.singer)
                          .fontColor('#a8a8ad')
                          .fontSize(10)
                      }
                      .layoutWeight(1)
                      .height(60)
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.SpaceBetween)
                      .padding(12)

                      Image($r("app.media.ic_single_play"))
                        .width(20)
                        .fillColor('#ececec')
                        .margin({ right: 12 })
                    }
                    .backgroundColor('#666666')
                    .width('100%')
                    .borderRadius(8)
                    .clip(true)

                    Row({ space: 20 }) {
                      Row() {
                        Image($r('app.media.ic_share'))
                          .width(20)
                          .fillColor('#c9c8cd')
                        Text('分享')
                          .fontColor('#333333')
                          .fontSize(12)
                          .margin({ left: 4 })
                      }

                      Row() {
                        Image($r('app.media.ic_comment_o'))
                          .width(20)
                          .fillColor('#333333')
                          .onClick(() => {
                            this.isShow = true
                            this.songId = item.song_id
                            this.getReplyCommentData(item.id)
                            this.commentId = item.id
                            console.log('item.isShow', item.isShow)

                          })
                        Text(item.commentCount.toString())
                          .fontColor('#333333')
                          .fontSize(12)
                          .margin({ left: 4 })

                      }

                      Row() {
                        Image($r('app.media.ic_like'))
                          .width(20)
                          .fillColor('#333333')
                        Text(item.likeCount.toString())
                          .fontColor('#333333')
                          .fontSize(12)
                          .margin({ left: 4 })
                      }
                    }
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                }
                .alignItems(VerticalAlign.Top)
                .padding({
                  top: 24,
                  bottom: 24
                })
                .borderWidth({
                  bottom: 1
                })
                .borderColor('#292931')
              }
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
          .width('100%')
          .height('100%')
          .padding({ right: 32, left: 16 })

        }
        .layoutWeight(1)
        .bindSheet(this.isShow, this.myBuilder(), {
          height: 550,
          backgroundColor: '#ffffff',
          maskColor: Color.Gray,
          onDisappear: () => {
            this.isShow = false; // 确保任何方式关闭弹窗时状态都被更新
          }
        })

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#cccccc')

    }
    .width('100%')
    .height('100%')

  }
}

