// 接口返回值
export class ResponseModel{
  success:boolean;
  message:string;
  data:Array<object>;
  constructor(){
    this.success = false;
    this.message = "";
    this.data = [];
  }
}

// 传值参数
export class ParamModel{
  cid?:number;
  id?:number;
  page?:number;
  keywords?:string;
  type?:number;
}

//登录
export  interface  LoginModel {
  username:string,
  password:string
}
// 添加评论传值
export interface AddCommentParam {
  content:string;
  up:number,
  songId:number
}