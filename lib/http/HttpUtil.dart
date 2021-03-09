
import 'dart:convert';

import 'package:dio/dio.dart';

import 'api.dart';

class HttpUtil {

  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Api.base_url,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
       // "version": "1.0.0"
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.jsonContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    //添加日志请求拦截 显示日志
    dio.interceptors.add(LogInterceptor(requestHeader:true,requestBody: true,responseHeader:true,responseBody: true)); //开启请求日志

    //Cookie管理 这个暂时不清楚
    //dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      //print("请求之前");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      // print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      // print("错误之前");
      // Do something with response error
      return e; //continue
    }));
  }

  /*
   * get请求
   * options:单个请求自定义配置
   * data：query  ?后的数据
   *
   */
  get(url, {data, options, cancelToken,Function success, Function fail, Function complete}) async {
    Response response;
    try {
      response = await dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      // print('get success---------${response.statusCode}');
    //   print('get success---------${response.data}');
//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码
      if(response.statusCode == 200){
       // var result = json.decode(Utf8Decoder().convert(response.data));
        success(response.data);
      }else{
        ApiException apiException;
        apiException.errorCode = -1;
        apiException.errorMsg = '未知错误';
        fail(apiException);
      }

    } on DioError catch (e) {
      print('get error---------$e');
      ApiException apiException = formatError(e);
      fail(apiException);
    }finally {
      if (complete != null) {
        complete();
      }
    }
    //return response;
  }

  /*
   * post请求
   *
   * formData：POST传递form表单
   */
  post(url, {queryData,formData, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(url,data: formData,
          queryParameters: queryData, options: options, cancelToken: cancelToken);
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('post error---------$e');
      ApiException apiException = formatError(e);

    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
            //进度
            print("$count $total");
          });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      var apiException = formatError(e);

    }
    return response.data;
  }

  /*
   * error统一处理
   */
  ApiException formatError(DioError e) {
    ApiException apiException = new ApiException();
    switch(e.type){
      case DioErrorType.CONNECT_TIMEOUT:
        apiException.errorCode = 408;
        apiException.errorMsg = "连接超时";
        break;
      case DioErrorType.SEND_TIMEOUT:
        apiException.errorCode = 408;
        apiException.errorMsg = "请求超时";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        apiException.errorCode = 408;
        apiException.errorMsg = "响应超时";
        break;
      case DioErrorType.RESPONSE:
        apiException.errorCode = -1;
        apiException.errorMsg = "出现异常";
        break;
      case DioErrorType.CANCEL:
        apiException.errorCode = -1;
        apiException.errorMsg = "请求取消";
        break;
      default:
        apiException.errorCode = -1;
        apiException.errorMsg = "未知错误";
        break;
    }
    return apiException;
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

}

class ApiException implements Exception{
  int errorCode;
  String errorMsg;
}