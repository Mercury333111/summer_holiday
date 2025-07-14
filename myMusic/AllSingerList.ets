import { SingerModel} from './model/AppModel'
import { ConfigUtil as Config } from './common/ConfigUtil'
import { ParamModel } from './model/paramModel'
import {getAllSinger} from './common/Api'
import { NavBar } from './widget/NavBar'
@Entry
@Component
struct AllSingerList {
  @State singerList: SingerModel[] = []
  // 获取歌手
  async getSingerData () {
    let params:ParamModel ={
      page:1
    }
    const response = await getAllSinger(params)
    if (response.success) {
      let data = JSON.stringify(response.data)
      this.singerList = JSON.parse(data)
      console.log('提交歌手', this.singerList)
    }
  }
  aboutToAppear() {
    this.getSingerData()
  }
  build() {
    Column() {
      NavBar({title:'歌手列表'})
      Row() {
        Text('歌手列表').fontColor('#333333')
      }
      .padding(24)
      .width('100%')
      Row(){
        List({space:12}) {
          ForEach(this.singerList,(item:SingerModel,index:number)=>{
            ListItem() {
              Row({space:12}) {
                Row() {
                  Image(Config.SERVERURL+item.pic)
                    .borderRadius(8)
                    .width(60)
                }
                Column({space:12}) {
                  Text(item.name).fontColor('#333333')
                  Row({space:4}){
                    Text('VIP') .fontSize(10)
                      .padding({
                        left:6,
                        right:6,
                        top:2,
                        bottom:2
                      })
                      .border({
                        width:1,
                        color:'#c0a267'
                      }).borderRadius(10).fontColor('#c0a267')
                    Text(item.introduction)
                      .fontColor('#aaa9af')
                      .fontSize(12)
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Row() {
                  Image($r('app.media.ic_more'))
                    .fillColor('#aaa9af')
                    .width(24)
                }
              }
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
        }.width('100%').height('100%')
        .padding({
          left:24,
          right:24
        })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}
