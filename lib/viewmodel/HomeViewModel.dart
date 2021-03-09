import 'package:flutter_farm/base/BaseChangeNotifierModel.dart';
import 'package:flutter_farm/entity/BaseResult.dart';
import 'package:flutter_farm/entity/banner_entity.dart';
import 'package:flutter_farm/http/HttpUtil.dart';
import 'package:flutter_farm/http/api.dart';
import 'package:flutter_farm/utils/toast_util.dart';

class HomeViewModel extends BaseChangeNotifierModel{
  List<BannerEntity> bannerList = [];
  List<String> list = [];

  Future<void> getBannerData() {
    HttpUtil.getInstance().get(Api.banner_url,
        success: (result) async{

         print(result);
         List<dynamic> dynamicList = BaseResult<List<dynamic>>.fromJson(result).data;
         dynamicList.forEach((element) {
           bannerList.add(BannerEntity.fromJson(element));
         });

         for(int i=0;i<15;i++){
           list.add("item$i");
         }

         error = false;

        },
        fail: (e) {
          error = true;
          ToastUtil.showError((e as ApiException).errorMsg);
        },
        complete: () {
          loading = false;
          notifyListeners();
        });
  }

  retry(){
    loading = true;
    notifyListeners();
    getBannerData();
  }

}