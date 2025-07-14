import { getSongCommentList } from "../common/Api"
import promptAction from '@ohos.promptAction'
class CommentService {
  //获取登录的用户信息
  async getSongCommentData() {
    const response = await getSongCommentList()
    if (response.success) {
      let data = JSON.stringify(response.data)
      console.log("获取歌曲评论列表：" + data)
      return JSON.parse(data)

    } else {
      promptAction.showToast({
        message: response.message,
        duration: 5000
      })
    }
  }
}

let commentService = new CommentService()
export default commentService