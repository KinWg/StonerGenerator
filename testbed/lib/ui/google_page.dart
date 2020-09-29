import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class GoogleS2sPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleS2sPageState();
}

class _GoogleS2sPageState extends State<GoogleS2sPage> with CommonWidgetBuilderMixin {
  String json = '';

  final _channelController = TextEditingController();
  final _suffixController = TextEditingController();

  final _bookIdController = TextEditingController();
  final _chapterIdxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:
          ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: Text(
                          '广告标题:',
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
              buildInput('前缀，可选', '可选, 别写中文', _suffixController),
              buildInput('渠道', '必填, 别写中文', _channelController),
              buildInput('书本ID', 'ID', _bookIdController),
              buildInput('第几章，可选', '从1开始，可选', _chapterIdxController),
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
      ),
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
