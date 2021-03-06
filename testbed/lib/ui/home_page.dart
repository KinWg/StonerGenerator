import 'package:flutter/material.dart';
import 'package:testbed/ui/about_page.dart';
import 'package:testbed/ui/appsflyer_page.dart';
import 'package:testbed/ui/facebook_page.dart';
import 'package:testbed/ui/google_page.dart';
import 'package:testbed/ui/home_dialog_ad_page.dart';
import 'package:testbed/ui/home_float_ad_page.dart';
import 'package:testbed/ui/launch_ad_page.dart';
import 'package:testbed/ui/reader_ad_page.dart';
import 'package:testbed/ui/shelf_ad_page.dart';
import 'package:testbed/ui/stoner_nav_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('运营JSON生成器'),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          ListTile(
            title: Text('首页弹窗广告'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => HomeDialogAdPage()));
            },
          ),
          ListTile(
            title: Text('首页浮窗广告'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => HomeFloatAdPage()));
            },
          ),
          ListTile(
            title: Text('开屏广告'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LaunchAdPage()));
            },
          ),
          ListTile(
            title: Text('阅读器和VIP书本悬浮广告'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => ReaderAdPage()));
            },
          ),
          ListTile(
            title: Text('书架广告'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => ShelfAdPage()));
            },
          ),
          ListTile(
            title: Text('Appsflyer深度链接'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AppsflyerPage()));
            },
          ),
          ListTile(
            title: Text('Facebook深度链接'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => FacebookPage()));
            },
          ),
          ListTile(
            title: Text('Google深度链接'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => GoogleS2sPage()));
            },
          ),
          ListTile(
            title: Text('配置后台自定义跳转链接'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => StonerNavPage()));
            },
          ),
          ListTile(
            title: Text('帮助和关于'),
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
