import {HttpGet,HttpPost} from './HttpUtil'
import {ParamModel,LoginModel,AddCommentParam} from '../model/paramModel'

// 1.获取轮播图
export const getSwiperList = ()=> HttpGet('/getSwiper')
// 2 推荐歌单
export const getRecommendSongList = ()=> HttpGet('/getRecommendSongList')
// 3推荐歌手
export const getRecommendSinger= ()=> HttpGet('/getRecommendSinger')

// 4 歌手详情getSingerDetail
export const getSingerDetail= (params:ParamModel)=> HttpGet(`/getSingerDetail?id=${params.id}`)

// 5 获得歌单详情
export const getListSongDetail= (params:ParamModel)=> HttpGet(`/getListSongDetail?id=${params.id}`)

// 6 获取所有歌单 getAllSongList
export const getAllSongList= (params:ParamModel)=> HttpGet(`/getAllSongList?page=${params.page}`)

// 7. 获取所有歌手
export const getAllSinger= (params:ParamModel)=> HttpGet(`/getAllSinger?page=${params.page}`)

// 8 搜索
export const searchSong= (params:ParamModel)=> HttpGet(encodeURI(`/searchSong?keywords=${params.keywords}&page=${params.page}&type=${params.type}`))

// 9 获取歌曲详情 getSongDetail
export const getSongDetail= (params:ParamModel)=> HttpGet(`/getSongDetail?id=${params.id}`)

// 10登录
export const login = (params:LoginModel) => HttpPost(`/login`,params);

// 11 我的歌曲
// 我的歌曲
export const geMySongList = () => HttpGet('/getMySongList');








// 12.获取歌曲评论列表  commentList
export const getSongCommentList = () => HttpGet(`/commentList`);
// 13.添加或添加回复评论  addComment
export const addComment = (params:AddCommentParam) => HttpPost(`/addComment`,params);
// 14.通过评论ID 获取回复评论列表
export const getReplyComment = (id:number) => HttpGet(`/getReplyComment?id=${id}`);
