import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';

class StonerNavPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StonerNavState();
}

class _StonerNavState extends State<StonerNavPage> with NavParamMixin {
  List<Map> ads = [];

  String json = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('配置后台自定义跳转链接'),
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
          )
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
              Text('跳转设置'),
              SizedBox(
                height: 6,
              ),
              buildJumpRadio(),
              buildJumpWidget()
            ],
          )),
    );
  }

  void _generate(BuildContext context) {
    buildNavCommand((cmd) {
      json = jsonEncode(cmd.toJson());
      clearJumpData();
      setState(() {});

      showTip(context, 'JSON已生成');
    }, (msg) {
      showTip(context, msg);
      return;
    });
  }
}
