import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testbed/ui/common_widget_builder_mixin.dart';
import 'package:testbed/ui/nav_param_mixin.dart';
import 'package:testbed/ui/toast.dart';
import 'package:testbed/utils/ui_utils.dart';

class StonerNavPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StonerNavState();
}

class _StonerNavState extends State<StonerNavPage> with NavParamMixin, CommonWidgetBuilderMixin {
  List<Map> ads = [];

  String json = '';

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
                          '跳转命令:',
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
              Text('跳转设置',style: titleStyle,),
              SizedBox(
                height: 6,
              ),
              buildJumpRadio(),
              buildJumpWidget()
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
