import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';

class ShelfAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShelfAdState();
}

class _ShelfAdState extends State<ShelfAdPage> with CommonWidgetBuilderMixin, NavParamMixin {
  List<Map> ads = [];

  String json = '';
  
  var _isNewValue = 1;
  
  final _adTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('书架广告'),
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
              Container(height: 30, child: Text('当前广告数量: ${ads.length}'),),
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
              TextField(
                controller: _adTextController,
                decoration: InputDecoration(
                  hintText: '',
                  labelText: '广告文字',
                ),
              ),
              buildLoginInput(),
              Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '限定新设备显示',
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
              ),
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
    final dialogAds = ShelfAdList()
      ..ads = ads
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

    buildNavCommand((cmd) => ad.cmd = cmd, (msg) {
      showTip(context, msg);
      return;
    });

    ads.add(ad.toJson());
    if (cleanData) {
      clearJumpData();
      clearCommonData();
      _adTextController.clear();
    }

    setState(() {
    });

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
