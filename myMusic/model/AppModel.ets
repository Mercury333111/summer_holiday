// 轮播图接口
export interface SwiperModel{
  id: number,
  title: string,
  url: string,
  imgurl: string,
  state: number,
  order: number,
  createdAt: string,
  updatedAt: string

}

// 歌单接口
export class SongListModel{
  id?: number
  title?: string
  pic?: string
  introduction?: string
  style?: string
  createdAt?: string
  updatedAt?: string
  constructor(id: number,title: string,pic: string,introduction: string,style: string,createdAt: string,updatedAt: string){
    this.id = id
    this.title = title
    this.pic = pic
    this.introduction = introduction
    this.style = style
    this.createdAt = createdAt
    this.updatedAt = updatedAt
  }
}
// 歌手
export class SingerModel{
  id:number;
  name:string;
  sex:string;
  pic:string;
  birth:string;
  location:string;
  introduction:string;
  createdAt:string;
  updatedAt:string;
  constructor(id:number,name:string,sex:string,pic:string,birth:string,location:string,introduction:string,createdAt:string,updatedAt:string){
    this.id = id;
    this.name = name;
    this.sex = sex;
    this.pic = pic;
    this.birth = birth;
    this.location = location;
    this.introduction = introduction;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}

// 歌曲
export interface  SongModel {
  id: number;
  singer_id: number;
  name: string;
  introduction: string;
  pic: string;
  url: string;
  lyric: string;
}
// 歌手详情
export  interface SingerDetailModel {
  id?:number;
  name?:string;
  sex?:string;
  pic?:string;
  birth?:string;
  location?:string;
  introduction?:string;
  createdAt?:string;
  updatedAt?:string;
  songs?:SongModel[];
}

// 歌单详情
export interface SongListDetailModel {
  songList: SongListModel;
  songs:SongModel[];
}
// 歌曲详情
export interface  SongDetailModel {
  id: number;
  singer_id: number;
  name: string;
  introduction: string;
  pic: string;
  url: string;
  lyric: string;
  singer: SingerModel;
}

// 搜索分类
@Observed
export class searchCateNameModel{
  id:number;
  title:string;
  type:number;
  constructor(id:number,title:string,type:number) {
    this.id = id;
    this.title = title;
    this.type = type;
  }

}

export  interface  UserModel {
  id?: number;
  username?: string;
  password?: string;
  birth?: string;
  introduction?: string;
  location?: string;
  avatar?: string;
  createdAt?: string;
  updatedAt?: string;

}

// 我的歌单
// 我的歌单列表
export interface consumer{
  username: string
  avatar: string
}
export class  MySongModel {
  id?: number;
  consumer:consumer
  song:SongModel
  singer:string
  constructor(id:number,consumer:consumer,song:SongModel,singer:string) {
    this.id = id;
    this.consumer =consumer
    this.song = song;
    this.singer = singer;
  }
}

// 歌曲评论列表  id user_id song_id song_list_id content up createdAt updatedAt consumer
export class SongCommentModel {
  id: number;
  user_id: number;
  song_id: number;
  song_list_id?: number;
  content: string;
  up: number;
  createdAt?: string;
  updatedAt?: string;
  reply?: SongCommentModel;
  consumer: consumer;
  song: SongModel;
  singer: string;
  commentCount: number;
  likeCount: number;
  isShow?: boolean;

  constructor(id: number, user_id: number, song_id: number, song_list_id: number, content: string, up: number,
    createdAt: string, updatedAt: string, consumer: consumer, song: SongModel, singer: string, reply: SongCommentModel,
    commentCount: number, likeCount: number) {
    this.id = id;
    this.user_id = user_id;
    this.song_id = song_id;
    this.song_list_id = song_list_id;
    this.content = content;
    this.up = up;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.consumer = consumer;
    this.song = song;
    this.singer = singer;
    this.reply = reply;
    this.commentCount = commentCount;
    this.likeCount = likeCount;

  }
}