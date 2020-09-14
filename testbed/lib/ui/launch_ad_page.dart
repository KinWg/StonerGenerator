import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';

class LaunchAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LaunchAdState();
}

class _LaunchAdState extends State<LaunchAdPage>
    with CommonWidgetBuilderMixin, NavParamMixin {
  List<Map> ads = [];

  String json = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('开屏广告'),
        actions: [
          Builder(
            builder: (context) => InkWell(
                onTap: () {
                  _save(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('保存当前广告')),
                )),
          ),
          Builder(
            builder: (context) => InkWell(
                onTap: () {
                  _generate(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('生成')),
                )),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                height: 30,
                child: Text('当前广告数量: ${ads.length}'),
              ),
              Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        json,
                        style: TextStyle(fontSize: 12.0),
                      )),
                      Builder(
                          builder: (context) => FlatButton(
                              child: Text(
                                '复制',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: json.replaceAll('\\', '')));
                                showTip(context, '已复制');
                              }))
                    ],
                  )),
              buildIdInput(),
              buildImageUrlInput(),
              buildStartTime(),
              buildEndTime(),
              buildWeightInput(),
              Text('跳转设置'),
              SizedBox(
                height: 6,
              ),
              buildJumpRadio(),
              buildJumpWidget(),
            ],
          )),
    );
  }

  void _generate(BuildContext context) {
    final dialogAds = LaunchAdList()..ads = ads;
    setState(() {
      json = dialogAds.toJson();
    });
    showTip(context, 'JSON已生成');
  }

  void _save(BuildContext context, [bool cleanData = true]) {
    if (idController.text?.isNotEmpty != true) {
      showTip(context, 'ID不能为空');
      return;
    }
    if (urlController.text?.isNotEmpty != true) {
      showTip(context, '图片URL不能为空');
      return;
    }

    final ad = LaunchAd()
      ..id = idController.text
      ..imgUrl = urlController.text
      ..startTime = startTime.millisecondsSinceEpoch ~/ 1000
      ..endTime = endTime.millisecondsSinceEpoch ~/ 1000
      ..weight = int.parse(weightController.text ?? 0);

    buildNavCommand((cmd) => ad.cmd = cmd, (msg) {
      showTip(context, msg);
      return;
    });

    ads.add(ad.toJson());
    if (cleanData) {
      clearCommonData();
      clearJumpData();
    }

    setState(() {});

    showTip(context, '已添加');
  }
}

class LaunchAd {
  String id;
  StonerCommand cmd;
  String imgUrl;
  int startTime;
  int endTime;
  int weight;

  Map toJson() {
    final map = {
      'id': id,
      'cmd': cmd.toJson(),
      'imgUrl': imgUrl,
      'startTime': startTime,
      'endTime': endTime,
      'weight': weight,
    };
    return map;
  }
}

class LaunchAdList {
  List<Map> ads = List();

  String toJson() {
    final map = {
      'ads': ads,
    };
    return json.encode(map);
  }
}
