
class BaseResult<T>{

  int errorCode;
  String errorMsg;
  T data;

  BaseResult({
    this.errorCode,
    this.errorMsg,
    this.data
  });

  factory BaseResult.fromJson(Map<String, dynamic> json) {
    /*if (json["data"] != null) {
      *//*data = [];
      json["data"].forEach((v) {
        data.add(T.fromJson(v));
      });*//*

    }
    errorCode = json["errorCode"];
    errorMsg = json["errorMsg"];*/
    return BaseResult(
        errorCode: json['errorCode'],
        errorMsg:json['errorMsg'],
        data: json['data']
    );
  }



}