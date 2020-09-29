import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/deep_link_jump_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class AppsflyerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppsflyerPageState();
}

class _AppsflyerPageState extends State<AppsflyerPage> with DeepLinkJumpMixin, CommonWidgetBuilderMixin {
  String json = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:
          Container(
              child: ListView(
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
                              'DeepLink:',
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
                  Text('跳转设置', style: titleStyle,),
                  SizedBox(
                    height: 6,
                  ),
                  buildJumpRadio(),
                  buildJumpWidget(),
                ],
              ))),
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
                          _generate();
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

  void _generate() {
    switch (groupValue) {
      case 0:
        final map = <String, dynamic>{};
        if (bookIdController.text?.isNotEmpty == true) {
          map['bookId'] = bookIdController.text;
        }
        if (bookNameController.text?.isNotEmpty == true) {
          map['bookName'] = bookNameController.text;
        }
        if (chapterIdxController.text?.isNotEmpty == true) {
          map['seq'] = chapterIdxController.text;
        }

        final uri =
            Uri(scheme: 'waireadstoner', host: 'book', queryParameters: map);
        json = uri.toString();
        break;
      case 1:
        if (jumpUrlController.text?.isNotEmpty == true) {
          final uri = Uri(
              scheme: 'waireadstoner',
              host: 'web',
              queryParameters: {'url': jumpUrlController.text});
          json = uri.toString();
        }
        break;
      case 2:
        final uri = Uri(scheme: 'waireadstoner', host: 'revenue');
        json = uri.toString();
        break;
      case 4:
        if (moduleIdController.text?.isNotEmpty == true) {
          final map = <String, dynamic>{'module': moduleIdController.text};
          if (moduleTitleController.text?.isNotEmpty == true) {
            map['title'] = moduleTitleController.text;
          }
          final uri =
              Uri(scheme: 'waireadstoner', host: 'rank', queryParameters: map);
          json = uri.toString();
        }
        break;
      case 5:
        final uri = Uri(scheme: 'waireadstoner', host: 'personal');
        json = uri.toString();
        break;
      case 6:
        final uri = Uri(scheme: 'waireadstoner', host: 'shelf');
        json = uri.toString();
        break;
      case 7:
        final uri = Uri(scheme: 'waireadstoner', host: 'store');
        json = uri.toString();
        break;
      case 8:
        final uri = Uri(scheme: 'waireadstoner', host: 'customer');
        json = uri.toString();
        break;
      default:
        break;
    }

    setState(() {});
  }
}
