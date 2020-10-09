import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('使用时先填写好每个字段，编辑好之后点击添加加入队列，等待填好多个广告之后再点击生成，然后复制到配置后台'),
            SizedBox(height: 50),
            Text('版本日志'),
            Text('V 0.0.1 初始版本'),
            Text('V 0.0.2 增加数据检查，更新Appsflyer跳转命令格式'),
            Text('V 0.0.3 增加Facebook和Google的跳转命令'),
            Text('V 0.0.4 广告增加权重和付费次数限制，增加跳转活动页参数，增加跳Line配置'),
            Text('V 0.0.5 增加跳转命令，更换更适合桌面端的UI'),
            Text('V 0.1.0 New UI release'),
            Text('V 0.1.1 修复跳转阅读器的问题'),
            SizedBox(height: 20),
            Text('Ver 0.1.1'),
            Text('Written by Kin'),
        ],),
      ),
    );
  }
}