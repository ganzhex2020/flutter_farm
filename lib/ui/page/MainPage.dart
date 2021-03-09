import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_farm/common/Constant.dart';
import 'package:flutter_farm/common/SizeConfig.dart';

import 'HomePage.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  int _selectedIndex = 0;
  List<Widget> pageData = [];
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageData
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage());


  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return new Scaffold(
     /* body: IndexedStack(
        index: _selectedIndex,
        children: pageData,
      ),*/
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: pageData,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          _bottomItem(Constant.shichang, 'images/ic_home_normal.png',
              'images/ic_home_selected.png'),
          _bottomItem(Constant.muchang, 'images/ic_discovery_normal.png',
              'images/ic_discovery_selected.png'),
          _bottomItem(Constant.zhuanpan, 'images/ic_hot_normal.png',
              'images/ic_hot_selected.png'),
          _bottomItem(Constant.mime, 'images/ic_mine_normal.png',
              'images/ic_mine_selected.png')
        ],
        currentIndex: _selectedIndex,
        onTap: onTap/*(index) {
          setState(() {
            _selectedIndex = index;
          });
        }*/,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _bottomItem(String title, String normalIcon, String selectIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(normalIcon, width: 24, height: 24),
        activeIcon: Image.asset(selectIcon, width: 24, height: 24),
        label: title);
  }


}
