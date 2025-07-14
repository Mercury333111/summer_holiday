import http from '@ohos.net.http'
import { ResponseModel} from "../model/paramModel"
import { ConfigUtil as Config } from "./ConfigUtil"

export function HttpGet(apiUri: string): Promise<ResponseModel> {
  let httpReq: http.HttpRequest = http.createHttp()
  let promiseData: Promise<http.HttpResponse> = httpReq.request(Config.SERVER+apiUri, {
    method: http.RequestMethod.GET,
    connectTimeout: Config.HTTP_CONNECT_TIMEOUT,
    readTimeout: Config.HTTP_READ_TIMEOUT,
  })

  let serverData: ResponseModel = new ResponseModel()
  return promiseData.then((response) => {
    httpReq.destroy() // 关闭请求，释放资源
    if (response.responseCode == Config.HTTP_CODE_200) {
      let data = `${response.result}` //把json对象转换成json字符串
      let result: object = JSON.parse(data) //把json字符串转换成json对象
      serverData.success = true
      serverData.message = result["message"] ||  Config.SERVER_NET_SUCCESS
      serverData.data = result["data"]
      return serverData
    } else {
      serverData.message = Config.SERVER_NET_ERROR
      return serverData
    }
  }).catch((e: object) => {
    httpReq.destroy() // 关闭请求，释放资源
    serverData.message = `${Config.SERVER_NET_ERROR}:${JSON.stringify(e)}`;
    return serverData;
  })
}


export function HttpPost<T>(apiUri: string, extraData?: T): Promise<ResponseModel> {
  let httpReq: http.HttpRequest = http.createHttp()
  let promiseData: Promise<http.HttpResponse> = httpReq.request(Config.SERVER+apiUri, {
    method: http.RequestMethod.POST,
    header: {
      'Content-Type': 'application/json'  // json数据
    },
    extraData: extraData,
    expectDataType:http.HttpDataType.OBJECT,  // 3.返回对象类型
    connectTimeout: Config.HTTP_CONNECT_TIMEOUT,
    readTimeout: Config.HTTP_READ_TIMEOUT
  })

  let serverData: ResponseModel = new ResponseModel()
  return promiseData.then((response) => {
    httpReq.destroy() // 关闭请求，释放资源
    if (response.responseCode == Config.HTTP_CODE_200) {
      let data = `${JSON.stringify(response.result)}` //把json对象转换成json字符串
      let result: object = JSON.parse(data) //把json字符串转换成json对象
      serverData.success = true
      serverData.message = result["message"]
      serverData.data = result['data']
      return serverData
    } else {
      serverData.message = Config.SERVER_NET_ERROR
      return serverData
    }
  }).catch((e: object) => {
    httpReq.destroy() // 关闭请求，释放资源
    serverData.message = `${Config.SERVER_NET_ERROR}:${JSON.stringify(e)}`;
    return serverData;
  })
}

