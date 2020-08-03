import 'package:flutter/material.dart';
import 'package:testbed/ui/about_page.dart';
import 'package:testbed/ui/appsflyer_page.dart';
import 'package:testbed/ui/home_dialog_ad_page.dart';
import 'package:testbed/ui/home_float_ad_page.dart';
import 'package:testbed/ui/launch_ad_page.dart';
import 'package:testbed/ui/reader_ad_page.dart';
import 'package:testbed/ui/shelf_ad_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("运营JSON生成器"),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          ListTile(
            title: Text("首页弹窗广告"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => HomeDialogAdPage()));
            },
          ),
          ListTile(
            title: Text("首页浮窗广告"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => HomeFloatAdPage()));
            },
          ),
          ListTile(
            title: Text("开屏广告"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LaunchAdPage()));
            },
          ),
          ListTile(
            title: Text("阅读器浮窗广告"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => ReaderAdPage()));
            },
          ),
          ListTile(
            title: Text("书架广告"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => ShelfAdPage()));
            },
          ),
          ListTile(
            title: Text("Appsflyer深度链接"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AppsflyerPage()));
            },
          ),
          ListTile(
            title: Text("帮助和关于"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AboutPage()));
            },
          ),
        ]),
      ),
    );
  }
}
