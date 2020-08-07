import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppsflyerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppsflyerPageState();
}

class _AppsflyerPageState extends State<AppsflyerPage> {
  String json = "";

  var _groupValue = 0;
  var _bookJumpValue = 0;

  final _bookIdController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _jumpUrlController = TextEditingController();
  final _moduleTitleController = TextEditingController();
  final _moduleIdController = TextEditingController();
  final _chapterIdxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appsflyer深度链接"),
        actions: [
          InkWell(
              onTap: () {
                _generate();
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("生成")),
              )),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
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
                          "复制",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: json.replaceAll("\\", "")));
                        },
                      )
                    ],
                  )),
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
      value: 4,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳排行榜", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 5,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳个人页", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 6,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳书架", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 7,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳首页", style: TextStyle(fontSize: 12.0)));
    list.add(Radio<int>(
      groupValue: _groupValue,
      value: 8,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });
      },
    ));
    list.add(Text("跳客服", style: TextStyle(fontSize: 12.0)));
    return list;
  }

  Widget _buildBookWidget() {
    return Container(
        height: 185,
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
            TextField(
              controller: _chapterIdxController,
              decoration: InputDecoration(
                hintText: "从1开始",
                labelText: "第几章",
              ),
            ),
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

  void _generate() {
    switch (_groupValue) {
      case 0:
        final map = Map<String, dynamic>();
        if (_bookIdController.text?.isNotEmpty == true) {
          map["bookId"] = _bookIdController.text;
        }
        if (_bookNameController.text?.isNotEmpty == true) {
          map["bookName"] = _bookNameController.text;
        }
        if (_chapterIdxController.text?.isNotEmpty == true) {
          map["seq"] = _chapterIdxController.text;
        }

        final uri =
            Uri(scheme: "waireadstoner", host: "book", queryParameters: map);
        json = uri.toString();
        break;
      case 1:
        if (_jumpUrlController.text?.isNotEmpty == true) {
          final uri = Uri(
              scheme: "waireadstoner",
              host: "web",
              queryParameters: {"url": _jumpUrlController.text});
          json = uri.toString();
        }
        break;
      case 2:
        final uri = Uri(scheme: "waireadstoner", host: "revenue");
        json = uri.toString();
        break;
      case 4:
        if (_moduleIdController.text?.isNotEmpty == true) {
          final map = <String, dynamic>{"module": _moduleIdController.text};
          if (_moduleTitleController.text?.isNotEmpty == true) {
            map["title"] = _moduleTitleController.text;
          }
          final uri =
              Uri(scheme: "waireadstoner", host: "rank", queryParameters: map);
          json = uri.toString();
        }
        break;
      case 5:
        final uri = Uri(scheme: "waireadstoner", host: "personal");
        json = uri.toString();
        break;
      case 6:
        final uri = Uri(scheme: "waireadstoner", host: "shelf");
        json = uri.toString();
        break;
      case 7:
        final uri = Uri(scheme: "waireadstoner", host: "store");
        json = uri.toString();
        break;
      case 8:
        final uri = Uri(scheme: "waireadstoner", host: "customer");
        json = uri.toString();
        break;
      default:
        break;
    }

    setState(() {});
  }
}
