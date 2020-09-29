import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/deep_link_jump_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class FacebookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> with DeepLinkJumpMixin, CommonWidgetBuilderMixin {
  String json = '';

  final _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ListView(
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
              buildInput('渠道', '必填, 建议别写中文', _channelController),
              Text('跳转设置',style: titleStyle,),
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

    switch (groupValue) {
      case 0:
        final map = Map<String, dynamic>();
        if (bookIdController.text?.isNotEmpty == true) {
          map['bookId'] = bookIdController.text;
        }
        if (bookNameController.text?.isNotEmpty == true) {
          map['bookName'] = bookNameController.text;
        }
        if (chapterIdxController.text?.isNotEmpty == true) {
          map['seq'] = chapterIdxController.text;
        }
        map['from'] = _channelController.text;

        final uri =
            Uri(scheme: 'waireadstoner', host: 'book', queryParameters: map);
        json = uri.toString();
        break;
      case 1:
        if (jumpUrlController.text?.isNotEmpty == true) {
          final uri = Uri(
              scheme: 'waireadstoner',
              host: 'web',
              queryParameters: {
                'url': jumpUrlController.text,
                'from': _channelController.text
              });
          json = uri.toString();
        }
        break;
      case 2:
        final uri = Uri(
            scheme: 'waireadstoner',
            host: 'revenue',
            queryParameters: {'from': _channelController.text});
        json = uri.toString();
        break;
      case 4:
        if (moduleIdController.text?.isNotEmpty == true) {
          final map = <String, dynamic>{'module': moduleIdController.text};
          if (moduleTitleController.text?.isNotEmpty == true) {
            map['title'] = moduleTitleController.text;
          }
          map['from'] = _channelController.text;
          final uri =
              Uri(scheme: 'waireadstoner', host: 'rank', queryParameters: map);
          json = uri.toString();
        }
        break;
      case 5:
        final uri = Uri(
            scheme: 'waireadstoner',
            host: 'personal',
            queryParameters: {'from': _channelController.text});
        json = uri.toString();
        break;
      case 6:
        final uri = Uri(
            scheme: 'waireadstoner',
            host: 'shelf',
            queryParameters: {'from': _channelController.text});
        json = uri.toString();
        break;
      case 7:
        final uri = Uri(
            scheme: 'waireadstoner',
            host: 'store',
            queryParameters: {'from': _channelController.text});
        json = uri.toString();
        break;
      case 8:
        final uri = Uri(
            scheme: 'waireadstoner',
            host: 'customer',
            queryParameters: {'from': _channelController.text});
        json = uri.toString();
        break;
      default:
        break;
    }

    setState(() {});
  }
}
