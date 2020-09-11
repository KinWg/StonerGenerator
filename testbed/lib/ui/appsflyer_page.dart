import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/deep_link_jump_mixin.dart';

class AppsflyerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppsflyerPageState();
}

class _AppsflyerPageState extends State<AppsflyerPage> with DeepLinkJumpMixin {
  String json = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appsflyer深度链接'),
        actions: [
          InkWell(
              onTap: () {
                _generate();
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('生成')),
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
