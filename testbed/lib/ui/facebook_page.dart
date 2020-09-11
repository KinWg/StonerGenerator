import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/deep_link_jump_mixin.dart';
import 'package:testbed/ui/toast.dart';

class FacebookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> with DeepLinkJumpMixin {
  String json = '';

  final _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook深度链接'),
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
                              ClipboardData(text: json.replaceAll('\\', "")));
                        },
                      )
                    ],
                  )),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  hintText: '必填, 建议别写中文',
                  labelText: '渠道',
                ),
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
