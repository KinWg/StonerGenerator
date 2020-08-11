import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/entity/param_entity.dart';
import 'package:testbed/ui/toast.dart';

class ShelfAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShelfAdState();
}

class _ShelfAdState extends State<ShelfAdPage> {
  List<Map> ads = List();

  String json = "";

  var _groupValue = 0;
  var _loginValue = 0;
  var _bookJumpValue = 0;
  var _isNewValue = 1;

  final _idController = TextEditingController();
  final _urlController = TextEditingController();
  final _adTextController = TextEditingController();
  final _bookIdController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _jumpUrlController = TextEditingController();
  final _moduleTitleController = TextEditingController();
  final _moduleIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("书架广告"),
        actions: [
          Builder(
            builder: (context) => InkWell(
                onTap: () {
                  _save(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("保存当前广告")),
                )),
          ),
          Builder(
            builder: (context) => InkWell(
                onTap: () {
                  _generate(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("生成")),
                )),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(height: 30, child: Text("当前广告数量: ${ads.length}"),),
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
                                "复制",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: json.replaceAll("\\", "")));
                                showTip(context, "已复制");
                              }))
                    ],
                  )),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  hintText: "广告ID",
                  labelText: "ID",
                ),
              ),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  hintText: "URL",
                  labelText: "图片URL",
                ),
              ),
              TextField(
                controller: _adTextController,
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "广告文字",
                ),
              ),
              Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "登录后显示",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Radio<int>(
                        groupValue: _loginValue,
                        value: 0,
                        onChanged: (value) {
                          setState(() {
                            _loginValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "是",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Radio<int>(
                        groupValue: _loginValue,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            _loginValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "否",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
              ),
              Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "限定新设备显示",
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
                        "是",
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
                        "否",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
              ),
              Text("跳转设置"),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _getRadios(),
                ),
              ),
              _buildJumpWidget(),
            ],
          )),
    );
  }

  List<Widget> _getRadios() {
    final list = List<Widget>();
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 0,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳书本", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 1,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳网页", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 2,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳充值", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 3,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳分类", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 4,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳排行榜", style: TextStyle(fontSize: 12.0)));
    return list;
  }

  Widget _buildBookWidget() {
    return Container(
        height: 165,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _bookIdController,
              decoration: InputDecoration(
                hintText: "ID",
                labelText: "书本ID",
              ),
            ),
            TextField(
              controller: _bookNameController,
              decoration: InputDecoration(
                hintText: "名称",
                labelText: "书本名称",
              ),
            ),
            Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("直接跳转到阅读器", style: TextStyle(fontSize: 12.0)),
                    SizedBox(
                      width: 10,
                    ),
                    Radio<int>(
                      groupValue: _bookJumpValue,
                      value: 0,
                      onChanged: (value) {
                        setState(() {
                          _bookJumpValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "是",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Radio<int>(
                      groupValue: _bookJumpValue,
                      value: 1,
                      onChanged: (value) {
                        setState(() {
                          _bookJumpValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "否",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ))
          ],
        ));
  }

  Widget _buildUrlWidget() {
    return Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _jumpUrlController,
              decoration: InputDecoration(
                hintText: "URL",
                labelText: "跳转页面",
              ),
            ),
          ],
        ));
  }

  Widget _buildModuleWidget() {
    return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _moduleTitleController,
              decoration: InputDecoration(
                hintText: "标题",
                labelText: "聚合页标题",
              ),
            ),
            TextField(
              controller: _moduleIdController,
              decoration: InputDecoration(
                hintText: "ID",
                labelText: "聚合页ID",
              ),
            ),
          ],
        ));
  }

  Widget _buildJumpWidget() {
    switch (_groupValue) {
      case 0:
        return _buildBookWidget();
      case 1:
        return _buildUrlWidget();
      case 4:
        return _buildModuleWidget();
      default:
        return Container();
    }
  }

  void _generate(BuildContext context) {
    final dialogAds = ShelfAdList()
      ..ads = ads
      ..adCount = ads.length;
    setState(() {
      json = dialogAds.toJson();
    });
    showTip(context, "JSON已生成");
  }

  void _save(BuildContext context, [bool cleanData = true]) {
    if (_idController.text?.isNotEmpty != true) {
      showTip(context, "ID不能为空");
      return;
    }
    if (_urlController.text?.isNotEmpty != true) {
      showTip(context, "图片URL不能为空");
      return;
    }

    final ad = ShelfAd()
      ..shelfAdsId = _idController.text
      ..imageUrl = _urlController.text
      ..isNew = _isNewValue
      ..login = _loginValue == 0;

    switch (_groupValue) {
      case 0:
        if (_bookIdController.text?.isNotEmpty != true) {
          showTip(context, "书本ID不能为空");
          return;
        }

        ad.cmd = StonerCommand(
            stoner: NavModuleParam(
                book: NavBookParam(
                    bookId: _bookIdController.text,
                    bookName: _bookNameController.text,
                    jumpReader: _bookJumpValue)));
        break;
      case 1:
        if (_jumpUrlController.text?.isNotEmpty != true) {
          showTip(context, "跳转URL不能为空");
          return;
        }
        ad.cmd =
            StonerCommand(stoner: NavModuleParam(web: _jumpUrlController.text));
        break;
      case 2:
        ad.cmd = StonerCommand(stoner: NavModuleParam(route: "revenue"));
        break;
      case 4:
        if (_moduleIdController.text?.isNotEmpty != true) {
          showTip(context, "聚合页ID不能为空");
          return;
        }
        if (_moduleTitleController.text?.isNotEmpty != true) {
          showTip(context, "聚合页标题不能为空");
          return;
        }
        ad.cmd = StonerCommand(
            stoner: NavModuleParam(
                page: NavPageParam(
                    title: _moduleTitleController.text,
                    module: int.parse(_moduleIdController.text))));
        break;
      default:
        break;
    }

    ads.add(ad.toJson());
    if (cleanData) {
      _idController.clear();
      _urlController.clear();
      _bookIdController.clear();
      _bookNameController.clear();
      _jumpUrlController.clear();
      _moduleTitleController.clear();
      _moduleIdController.clear();
    }

    setState(() {
    });

    showTip(context, "已添加");
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
      "shelfAdsId": shelfAdsId,
      "cmd": cmd.toJson(),
      "imageUrl": imageUrl,
      "adText": adText,
      "login": login,
      "isNew": isNew
    };
    return map;
  }
}

class ShelfAdList {
  int adCount = 0;
  List<Map> ads = List();

  String toJson() {
    final map = {
      "adCount": adCount,
      "ads": ads,
    };
    return json.encode(map);
  }
}
