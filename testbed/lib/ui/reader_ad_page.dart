import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

import 'ad_preview_widget.dart';

class ReaderAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReaderAdState();
}

class _ReaderAdState extends State<ReaderAdPage> with NavParamMixin, CommonWidgetBuilderMixin {
  List<ReaderFloatAd> ads = [];

  String json = '';

  final _chapterIdxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Container(
                    height: 30,
                    child: Text('当前广告数量: ${ads.length}', style: titleStyle,),
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
                  buildInput('第几章开始显示', '章节顺序', _chapterIdxController),
                  buildWeightInput(),
                  buildPayCountInput(),
                  buildLine(),
                  Text('跳转设置', style: titleStyle,),
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
                      Builder(builder: (context) => InkWell(
                          onTap: () {
                            showModalBottomSheet(context: context,
                                builder: (context) => AdPreviewWidget(ads, (index) {
                                  setState(() {});
                                }), backgroundColor: Colors.white, elevation: 8.0);
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
    final dialogAds = ReaderFloatAdList()..ads = ads.map((e) => e.toJson()).toList();
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
    if (_chapterIdxController.text?.isNotEmpty != true) {
      showTip(context, '章节顺序不能为空');
      return;
    }

    final ad = ReaderFloatAd()
      ..id = idController.text
      ..imgUrl = urlController.text
      ..startTime = startTime.millisecondsSinceEpoch ~/ 1000
      ..endTime = endTime.millisecondsSinceEpoch ~/ 1000
      ..chapterIdx = int.parse(_chapterIdxController.text ?? 1)
      ..login = loginValue == 0
      ..weight = int.parse(weightController.text ?? 0)
      ..payCount = int.parse(payCountController.text ?? 0);

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
      _chapterIdxController.clear();
    }

    setState(() {});

    showTip(context, '已添加');
  }
}

class ReaderFloatAd {
  String id;
  StonerCommand cmd;
  String imgUrl;
  int startTime;
  int endTime;
  bool login;
  int chapterIdx;
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
      'chapterIdx': chapterIdx,
      'weight': weight,
      'payCount': payCount,
    };
    return map;
  }

  @override
  String toString() {
    return '广告ID: $id, 图片URL: $imgUrl, 第几章显示: $chapterIdx, '
        '开始时间: ${DateTime.fromMillisecondsSinceEpoch(startTime).toIso8601String()} '
        '结束时间: ${DateTime.fromMillisecondsSinceEpoch(endTime).toIso8601String()} '
        '登录后显示: $login 优先级: $weight 付费次数: $payCount 跳转命令: ${cmd?.toJson()}';
  }
}

class ReaderFloatAdList {
  List<Map> ads = List();

  String toJson() {
    final map = {
      'ads': ads,
    };
    return json.encode(map);
  }
}
