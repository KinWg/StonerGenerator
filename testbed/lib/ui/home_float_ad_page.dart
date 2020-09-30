import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/ad_preview_widget.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class HomeFloatAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeFloatAdState();
}

class _HomeFloatAdState extends State<HomeFloatAdPage>
    with CommonWidgetBuilderMixin, NavParamMixin {
  List<HomeFloatAd> ads = [];

  String json = '';

  var _posValue = 0;

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
              Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '显示位置',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Radio<int>(
                        groupValue: _posValue,
                        value: 0,
                        onChanged: (value) {
                          setState(() {
                            _posValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '全部',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        groupValue: _posValue,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            _posValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '阅读',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        groupValue: _posValue,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            _posValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '书城',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        groupValue: _posValue,
                        value: 3,
                        onChanged: (value) {
                          setState(() {
                            _posValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '我的',
                        style: titleStyle,
                      ),
                    ]),
              ),
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
              buildJumpWidget(),
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
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    AdPreviewWidget(ads, (index) {
                                      setState(() {});
                                    }),
                                backgroundColor: Colors.white,
                                elevation: 8.0);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              '查看已配置广告',
                              style: TextStyle(color: Colors.indigo.shade500),
                            )),
                          ))),
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
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void _generate(BuildContext context) {
    final dialogAds = HomeFloatList()..ads = ads.map((e) => e.toJson()).toList();
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

    final ad = HomeFloatAd()
      ..id = idController.text
      ..imgUrl = urlController.text
      ..startTime = startTime.millisecondsSinceEpoch ~/ 1000
      ..endTime = endTime.millisecondsSinceEpoch ~/ 1000
      ..position = _posValue
      ..login = loginValue == 0
      ..weight = int.parse(weightController.text ?? '0')
      ..payCount = int.parse(payCountController.text ?? '0');

    var error = false;
    buildNavCommand((cmd) => ad.cmd = cmd, (msg) {
      showTip(context, msg);
      error = true;
      return;
    });

    if (error) {
      return;
    }

    ads.add(ad);
    if (cleanData) {
      clearCommonData();
      clearJumpData();
    }

    setState(() {});

    showTip(context, '已添加');
  }
}

class HomeFloatAd {
  String id;
  StonerCommand cmd;
  String imgUrl;
  int startTime;
  int endTime;
  int position;
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
      'position': position,
      'login': login,
      'weight': weight,
      'payCount': payCount,
    };
    return map;
  }

  @override
  String toString() {
    return '广告ID: $id, 图片URL: $imgUrl, 位置: $position, '
        '开始时间: ${DateTime.fromMillisecondsSinceEpoch(startTime).toIso8601String()}, '
        '结束时间: ${DateTime.fromMillisecondsSinceEpoch(endTime).toIso8601String()}, '
        '登录后显示: $login, 优先级: $weight, 付费次数: $payCount, 跳转命令: ${cmd?.toJson()}';
  }
}

class HomeFloatList {
  List<Map> ads = [];

  String toJson() {
    final map = {
      'ads': ads,
    };
    return json.encode(map);
  }
}
