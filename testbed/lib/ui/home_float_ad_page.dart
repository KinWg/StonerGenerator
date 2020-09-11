import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';

class HomeFloatAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeFloatAdState();
}

class _HomeFloatAdState extends State<HomeFloatAdPage>
    with CommonWidgetBuilderMixin, NavParamMixin {
  List<Map> ads = [];

  String json = '';

  var _posValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页浮窗广告'),
        actions: [
          Builder(
            builder: (context) =>
                InkWell(
                    onTap: () {
                      _save(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('保存当前广告')),
                    )),
          ),
          Builder(
            builder: (context) =>
                InkWell(
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
                      FlatButton(
                        child: Text(
                          '复制',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: json.replaceAll('\\', '')));
                        },
                      )
                    ],
                  )),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
              ),
              buildWeightInput(),
              buildPayCountInput(),
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
    final dialogAds = HomeFloatList()
      ..ads = ads;
    setState(() {
      json = dialogAds.toJson();
    });
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
      ..weight = int.parse(weightController.text ?? 0)
      ..payCount = int.parse(payCountController.text ?? 0);

    switch (groupValue) {
      case 0:
        if (bookIdController.text?.isNotEmpty != true) {
          showTip(context, '书本ID不能为空');
          return;
        }

        ad.cmd = StonerCommand(
            stoner: NavModuleParam(
                book: NavBookParam(
                    bookId: bookIdController.text,
                    bookName: bookNameController.text,
                    jumpReader: bookJumpValue)));
        break;
      case 1:
        if (jumpUrlController.text?.isNotEmpty != true) {
          showTip(context, '跳转URL不能为空');
          return;
        }
        ad.cmd =
            StonerCommand(stoner: NavModuleParam(web: jumpUrlController.text));
        break;
      case 2:
        ad.cmd = StonerCommand(stoner: NavModuleParam(route: 'revenue'));
        break;
      case 4:
        if (moduleIdController.text?.isNotEmpty != true) {
          showTip(context, '模块ID不能为空');
          return;
        }
        if (moduleTitleController.text?.isNotEmpty != true) {
          showTip(context, '模块标题不能为空');
          return;
        }
        ad.cmd = StonerCommand(
            stoner: NavModuleParam(
                page: NavPageParam(
                    title: moduleTitleController.text,
                    module: int.parse(moduleIdController.text))));
        break;
      case 5:
        if (activityIdController.text?.isNotEmpty != true) {
          showTip(context, '活动聚合页ID不能为空');
          return;
        }
        ad.cmd = StonerCommand(
            stoner: NavModuleParam(
                activity: NavActivityParam(id: activityIdController.text,
                    name: activityTitleController.text ?? ''),
            )
        );
        break;
      default:
        break;
    }

    ads.add(ad.toJson());
    if (cleanData) {
      clearCommonData();
      clearJumpData();
    }

    setState(() {});
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
}

class HomeFloatList {
  List<Map> ads = List();

  String toJson() {
    final map = {
      'ads': ads,
    };
    return json.encode(map);
  }
}
