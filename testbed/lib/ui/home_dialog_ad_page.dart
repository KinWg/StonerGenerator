import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class HomeDialogAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDialogAdState();
}

class _HomeDialogAdState extends State<HomeDialogAdPage>
    with NavParamMixin, CommonWidgetBuilderMixin {
  List<Map> ads = [];

  String json = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Container(
                height: 30,
                child: Text(
                  '当前广告数量: ${ads.length}',
                  style: titleStyle,
                ),
              ),
              Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: Text(
                          'Json:',
                          style: titleStyle,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        json,
                        style: TextStyle(
                            fontSize: 12.0, color: Colors.indigo.shade300),
                      )),
                      Builder(
                          builder: (context) => FlatButton(
                              child: Text(
                                '复制',
                                style: textStyle,
                              ),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: json.replaceAll('\\', '')));
                                showTip(context, '已复制');
                              }))
                    ],
                  )),
              buildLine(),
              buildIdInput(),
              buildImageUrlInput(),
              buildStartTime(),
              buildEndTime(),
              buildLoginInput(),
              buildWeightInput(),
              buildPayCountInput(),
              buildLine(),
              Text(
                '跳转设置',
                style: titleStyle,
              ),
              SizedBox(
                height: 6,
              ),
              buildJumpRadio(),
              buildJumpWidget()
            ],
          )),
          Material(
            color: Colors.indigo.shade50,
            elevation: 4.0,
            child: Container(
              width: UIUtils.windowWidth - 30,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                        onTap: () {
                          _save(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            '保存当前广告',
                            style: TextStyle(color: Colors.indigo.shade500),
                          )),
                        )),
                  ),
                  Builder(
                    builder: (context) => InkWell(
                        onTap: () {
                          _generate(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            '生成',
                            style: TextStyle(color: Colors.indigo.shade500),
                          )),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void _generate(BuildContext context) {
    final dialogAds = DialogAdList()..ads = ads;
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

    final ad = DialogAd()
      ..id = idController.text
      ..imgUrl = urlController.text
      ..startTime = startTime.millisecondsSinceEpoch ~/ 1000
      ..endTime = endTime.millisecondsSinceEpoch ~/ 1000
      ..login = loginValue == 0
      ..weight = int.parse(weightController.text ?? 0)
      ..payCount = int.parse(payCountController.text ?? 0);

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

class DialogAd {
  String id;
  StonerCommand cmd;
  String imgUrl;
  int startTime;
  int endTime;
  bool login;
  int weight;
  int payCount;

  Map toJson() {
    final map = {
      'id': id,
      'cmd': cmd.toJson(),
      'imgUrl': imgUrl,
      'startTime': startTime,
      'endTime': endTime,
      'login': login,
      'weight': weight,
      'payCount': payCount,
    };
    return map;
  }

  @override
  String toString() {
    return '广告ID: $id, 图片URL: $imgUrl, '
    '开始时间: ${DateTime.fromMillisecondsSinceEpoch(startTime).toIso8601String()} '
    '结束时间: ${DateTime.fromMillisecondsSinceEpoch(endTime).toIso8601String()} '
    '登录后显示: $login 优先级: $weight 付费次数: $payCount 跳转命令: ${cmd.toJson()}';
  }
}

class DialogAdList {
  List<Map> ads = [];

  String toJson() {
    final map = {
      'ads': ads,
    };
    return json.encode(map);
  }
}
