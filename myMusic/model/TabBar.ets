export interface  TabBarModel{
  title: string;
  name: string;
  icon: ResourceStr;
}
// TabBar 的数据实现
export const tabsData :TabBarModel[] = [
  {
    title: '首页',
    name: 'home',
    icon: $r('app.media.ic_recommend')
  },
  {
    title: '我的歌单',
    name: 'likeSongList',
    icon: $r('app.media.ic_logo')
  },
  {
    title: '评论',
    name: 'comment',
    icon: $r('app.media.ic_comment')
  },
  {
    title: '我的',
    name: 'mine',
    icon: $r('app.media.ic_mine')
  }
];