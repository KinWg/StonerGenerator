import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/ad_preview_widget.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class ShelfAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShelfAdState();
}

class _ShelfAdState extends State<ShelfAdPage>
    with CommonWidgetBuilderMixin, NavParamMixin {
  List<ShelfAd> ads = [];

  String json = '';

  var _isNewValue = 1;

  final _adTextController = TextEditingController();

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
                  )),
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
              buildInput('广告文字', '广告文字', _adTextController),
              buildLoginInput(),
              Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '限定新设备显示',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Radio<int>(
                        groupValue: _isNewValue,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            _isNewValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '是',
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        groupValue: _isNewValue,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            _isNewValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '否',
                        style: titleStyle,
                      ),
                    ]),
              ),
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
    final dialogAds = ShelfAdList()
      ..ads = ads.map((e) => e.toJson()).toList()
      ..adCount = ads.length;
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

    final ad = ShelfAd()
      ..shelfAdsId = idController.text
      ..imageUrl = urlController.text
      ..isNew = _isNewValue
      ..login = loginValue == 0;

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
      clearJumpData();
      clearCommonData();
      _adTextController.clear();
    }

    setState(() {});

    showTip(context, '已添加');
  }
}

class ShelfAd {
  String shelfAdsId;
  StonerCommand cmd;
  String imageUrl;
  String adText;
  bool login;
  int isNew;

  Map toJson() {
    final map = {
      'shelfAdsId': shelfAdsId,
      'cmd': cmd.toJson(),
      'imageUrl': imageUrl,
      'adText': adText,
      'login': login,
      'isNew': isNew,
    };
    return map;
  }

  @override
  String toString() {
    return '广告ID: $shelfAdsId, 图片URL: $imageUrl, 广告标题:$adText, '
        '登录后显示: $login, 新用户显示: $isNew, 跳转命令: ${cmd?.toJson()}';
  }
}

class ShelfAdList {
  int adCount = 0;
  List<Map> ads = List();

  String toJson() {
    final map = {
      'adCount': adCount,
      'ads': ads,
    };
    return json.encode(map);
  }
}
