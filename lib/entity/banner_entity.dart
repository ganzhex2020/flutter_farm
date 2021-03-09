/// desc : "扔物线"
/// id : 29
/// imagePath : "https://wanandroid.com/blogimgs/04d6f53b-65e8-4eda-89c0-5981e8688576.png"
/// isVisible : 1
/// order : 0
/// title : "我用 Jetpack Compose 写了个春节版微信主题，带炸弹特效"
/// type : 0
/// url : "http://i0k.cn/4KryA"

class BannerEntity {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerEntity({
      this.desc, 
      this.id, 
      this.imagePath, 
      this.isVisible, 
      this.order, 
      this.title, 
      this.type, 
      this.url});

  BannerEntity.fromJson(dynamic json) {
    desc = json["desc"];
    id = json["id"];
    imagePath = json["imagePath"];
    isVisible = json["isVisible"];
    order = json["order"];
    title = json["title"];
    type = json["type"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["desc"] = desc;
    map["id"] = id;
    map["imagePath"] = imagePath;
    map["isVisible"] = isVisible;
    map["order"] = order;
    map["title"] = title;
    map["type"] = type;
    map["url"] = url;
    return map;
  }

}