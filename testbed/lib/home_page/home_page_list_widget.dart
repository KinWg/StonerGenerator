import 'package:flutter/material.dart';
import 'package:testbed/home_page/home_page_model.dart';
import 'package:testbed/utils/ui_utils.dart';

/// Created by Kin on 2020/9/28

class HomePageListWidget extends StatefulWidget {
  final HomePageModel _model;

  HomePageListWidget(this._model);

  @override
  State createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageListWidget> {
  var _currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      color: Colors.white,
      child: Container(
        width: 300,
        color: Colors.white,
        height: UIUtils.windowHeight,
        child: ListTileTheme(
          selectedTileColor: Colors.indigo.shade100,
          child: ListView(
            children: _buildTiles(),
          ),
        ),
      ),
    );
  }

  List<ListTile> _buildTiles() {
    return [
      ListTile(
        title: Text('首页弹窗广告'),
        selected: _currentIndex == 0,
        onTap: () {
          _changeIndex(0);
        },
      ),
      ListTile(
        title: Text('首页浮窗广告'),
        selected: _currentIndex == 1,
        onTap: () {
          _changeIndex(1);
        },
      ),
      ListTile(
        title: Text('开屏广告'),
        selected: _currentIndex == 2,
        onTap: () {
          _changeIndex(2);
        },
      ),
      ListTile(
        title: Text('阅读器和VIP书本悬浮广告'),
        selected: _currentIndex == 3,
        onTap: () {
          _changeIndex(3);
        },
      ),
      ListTile(
        title: Text('书架广告'),
        selected: _currentIndex == 4,
        onTap: () {
          _changeIndex(4);
        },
      ),
      ListTile(
        title: Text('Appsflyer深度链接'),
        selected: _currentIndex == 5,
        onTap: () {
          _changeIndex(5);
        },
      ),
      ListTile(
        title: Text('Facebook深度链接'),
        selected: _currentIndex == 6,
        onTap: () {
          _changeIndex(6);
        },
      ),
      ListTile(
        title: Text('Google深度链接'),
        selected: _currentIndex == 7,
        onTap: () {
          _changeIndex(7);
        },
      ),
      ListTile(
        title: Text('配置后台自定义跳转链接'),
        selected: _currentIndex == 8,
        onTap: () {
          _changeIndex(8);
        },
      ),
      ListTile(
        title: Text('帮助和关于'),
        selected: _currentIndex == 9,
        onTap: () {
          _changeIndex(9);
        },
      ),
    ];
  }

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget._model.changeIndex(index);
  }
}