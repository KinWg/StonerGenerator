import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/toast.dart';

class GoogleS2sPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleS2sPageState();
}

class _GoogleS2sPageState extends State<GoogleS2sPage> {
  String json = '';

  final _channelController = TextEditingController();
  final _suffixController = TextEditingController();

  final _bookIdController = TextEditingController();
  final _chapterIdxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google深度链接'),
        actions: [
          Builder(
            builder: (context) => InkWell(
                onTap: () {
                  _generate(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('生成')),
                )),
          ),
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
              TextField(
                controller: _suffixController,
                decoration: InputDecoration(
                  hintText: '可选, 别写中文',
                  labelText: '前缀，可选',
                ),
              ),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  hintText: '必填, 别写中文',
                  labelText: '渠道',
                ),
              ),
              TextField(
                controller: _bookIdController,
                decoration: InputDecoration(
                  hintText: 'ID',
                  labelText: '书本ID',
                ),
              ),
              TextField(
                controller: _chapterIdxController,
                decoration: InputDecoration(
                  hintText: '从1开始，可选',
                  labelText: '第几章，可选',
                ),
              ),
            ],
          )),
    );
  }

  void _generate(BuildContext context) {
    if (_channelController.text?.isNotEmpty != true) {
      showTip(context, '渠道不能为空');
      return;
    }
    if (_bookIdController.text?.isNotEmpty != true) {
      showTip(context, '书本ID不能为空');
      return;
    }

    var adid = '${_suffixController.text}@p';
    adid += '@b_${_bookIdController.text}';
    if (_chapterIdxController.text?.isNotEmpty == true) {
      adid += '@c_${_chapterIdxController.text}';
    }
    adid += '@cn_${_channelController.text}';
    adid += '@';
    json = adid;

    setState(() {});
  }
}
