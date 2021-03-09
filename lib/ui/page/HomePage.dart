import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_farm/base/ProviderWidget.dart';
import 'package:flutter_farm/entity/banner_entity.dart';
import 'package:flutter_farm/ui/widget/LoadingContainer.dart';
import 'package:flutter_farm/viewmodel/HomeViewModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelInit: (model) {
          model.getBannerData();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: Scaffold(
                appBar: AppBar(
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    // centerTitle: true,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //    alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Text("登录",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            onTap: _handLogin,
                          ),
                        ),
                        Container(
                          //   alignment: Alignment.centerRight,
                          //   padding: EdgeInsets.all(10.0),

                          child: GestureDetector(
                            child: Text("注册",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            onTap: _handRegister,
                          ),
                        ),
                      ],
                    )),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _banner(model.bannerList),
                          _selectBar()
                        ],
                      ),
                    ),
                    SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return _gridItem(index);
                          /*Container(
                            margin: EdgeInsets.all(10),

                         //   height: 100,
                            alignment: Alignment.center,
                            child: _gridItem(index)//Text(model.list[index]),
                          ); */ //;
                        }, childCount: model.list.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 2 / 3))
                  ],
                ),
                /**/
              ));
        });
  }

  _banner(List<BannerEntity> bannerList) {
    return Container(
      width: double.infinity,
      height: 200.0,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Swiper(
            autoplay: true,
            onTap: (index) {
              //  NavigatorUtil.toDetails(context, bannerList[index].data);
            },
            // scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                // alignment:Alignment.center,
                fit: StackFit.expand, //未定位widget占满Stack整个空间
                children: <Widget>[
                  Image.network(bannerList[index].imagePath, fit: BoxFit.fill),
                  Positioned(
                      width: MediaQuery.of(context).size.width - 30,
                      bottom: 0,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 10, 15),
                          decoration: BoxDecoration(color: Colors.black12),
                          child: Text(bannerList[index].title,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12))))
                ],
              );
            },
            itemCount: bannerList?.length ?? 0,
            pagination: new SwiperPagination(
                alignment: Alignment.bottomRight,
                builder: DotSwiperPaginationBuilder(
                    activeColor: Colors.white, color: Colors.white24))),
      ),
    );
  }

  _gridItem(int index) {
    return Card(
      //  color: Colors.blue, //Card 背景颜色 为了便于识别，设置了红色 child 设置不全部沾满时可呈现
      //  elevation: 10.0, //传入double值，控制投影效果

      child: InkWell(
          onTap: () {
            print('Card tapped.');
          },
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                  //   width: 80,
                  //  width: 150,
                  height: 80,
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2013/10/09/02/26/cattle-192976_1280.jpg',
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail.png'),
                  fit: BoxFit.cover),
              Text('Item $index'),
              Text('Item $index'),
              Text('Item $index')
            ],
          )),
    );

    /* return GestureDetector(
      onTap: () {
        print('点击第 $index item');
      },

      child: Card(
          color: Colors.blue, //Card 背景颜色 为了便于识别，设置了红色 child 设置不全部沾满时可呈现
          elevation: 10.0, //传入double值，控制投影效果

          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.all(Radius.circular(20.0)),   //设定 Card 的倒角大小
            borderRadius: BorderRadius.only(  //设定 Card 的每个角的倒角大小
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
          ),

        //  clipBehavior: Clip.antiAlias,

          child:  Container(
            margin: EdgeInsets.all(8),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                CachedNetworkImage(
                    width: 80,
                    height: 80,
                    imageUrl:
                    'https://cdn.pixabay.com/photo/2013/10/09/02/26/cattle-192976_1280.jpg',
                    errorWidget: (context, url, error) =>
                        Image.asset('images/img_load_fail.png'),
                    fit: BoxFit.cover),
                Flexible(
                    flex: 1,
                    child:  Column(
                      children: <Widget>[
                        Text('Item $index'),
                        Text('Item $index'),
                        Text('Item $index')
                      ],
                    )
                )

              ],
            ),
          )
      ),

    );*/
  }

  _selectBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: _recharge,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/ic_home_recharge.png',
                height: 60,
                width: 60,
              ),
              Text("充值")
            ],
          ),
        ),
        GestureDetector(
          onTap: _withdraw,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/ic_home_tixian.png',
                height: 60,
                width: 60,
              ),
              Text("提款")
            ],
          ),
        ),
        GestureDetector(
          onTap: _kefu,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/ic_home_kefu.png',
                height: 60,
                width: 60,
              ),
              Text("客服")
            ],
          ),
        )
      ],
    ));
  }

  void _recharge() {
    print("recharge");
  }

  void _withdraw() {
    print("withdraw");
  }

  void _kefu() {
    print('kefu');
  }

  void _handLogin() {
    print("login");
  }

  void _handRegister() {
    print("register");
  }

  @override
  bool get wantKeepAlive => true;
}
