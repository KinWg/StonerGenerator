import 'package:flutter/material.dart';
import 'package:testbed/entity/param_entity.dart';

/// Created by Kin on 2020/9/11

mixin NavParamMixin<T extends StatefulWidget> on State<T> {
  @protected
  final bookIdController = TextEditingController();
  @protected
  final bookNameController = TextEditingController();
  @protected
  final jumpUrlController = TextEditingController();
  @protected
  final moduleTitleController = TextEditingController();
  @protected
  final moduleIdController = TextEditingController();
  @protected
  final activityTitleController = TextEditingController();
  @protected
  final activityIdController = TextEditingController();
  @protected
  final lineUrlController = TextEditingController();

  @protected
  var groupValue = 0;
  @protected
  var bookJumpValue = 0;

  Widget buildJumpRadio() {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _getRadios(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _getRadios2(),
          ),
        ],
      )
    );
  }

  List<Widget> _getRadios() {
    final list = <Widget>[]
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 0,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳书本', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 1,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳网页', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 2,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳充值', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 3,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳分类', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 4,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳排行榜', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 5,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳活动聚合页', style: TextStyle(fontSize: 12.0)))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 6,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳Line页面', style: TextStyle(fontSize: 12.0)));
    return list;
  }

  List<Widget> _getRadios2() {
    final list = <Widget>[]
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 7,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳VIP页面', style: TextStyle(fontSize: 12.0)));
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
              controller: bookIdController,
              decoration: InputDecoration(
                hintText: 'ID',
                labelText: '书本ID',
              ),
            ),
            TextField(
              controller: bookNameController,
              decoration: InputDecoration(
                hintText: '名称',
                labelText: '书本名称',
              ),
            ),
            Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('直接跳转到阅读器', style: TextStyle(fontSize: 12.0)),
                    SizedBox(
                      width: 10,
                    ),
                    Radio<int>(
                      groupValue: bookJumpValue,
                      value: 0,
                      onChanged: (value) {
                        setState(() {
                          bookJumpValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '是',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Radio<int>(
                      groupValue: bookJumpValue,
                      value: 1,
                      onChanged: (value) {
                        setState(() {
                          bookJumpValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '否',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )),
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
              controller: jumpUrlController,
              decoration: InputDecoration(
                hintText: 'URL',
                labelText: '跳转页面',
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
              controller: moduleTitleController,
              decoration: InputDecoration(
                hintText: '标题',
                labelText: '模块标题',
              ),
            ),
            TextField(
              controller: moduleIdController,
              decoration: InputDecoration(
                hintText: 'ID',
                labelText: '模块ID',
              ),
            ),
          ],
        ));
  }

  Widget _buildActivityWidget() {
    return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: activityTitleController,
              decoration: InputDecoration(
                hintText: '标题',
                labelText: '聚合页标题',
              ),
            ),
            TextField(
              controller: activityIdController,
              decoration: InputDecoration(
                hintText: 'ID',
                labelText: '聚合页ID',
              ),
            ),
          ],
        ));
  }

  Widget _buildLineWidget() {
    return Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: lineUrlController,
              decoration: InputDecoration(
                hintText: 'URL',
                labelText: 'Line地址，非短连接（如：https://line.me/R/ti/p/%40820oardu或line://ti/p/%40820oardu）',
              ),
            ),
          ],
        ));
  }

  @protected
  Widget buildJumpWidget() {
    switch (groupValue) {
      case 0:
        return _buildBookWidget();
      case 1:
        return _buildUrlWidget();
      case 4:
        return _buildModuleWidget();
      case 5:
        return _buildActivityWidget();
      case 6:
        return _buildLineWidget();
      default:
        return Container();
    }
  }

  @protected
  void clearJumpData() {
    bookIdController.clear();
    bookNameController.clear();
    jumpUrlController.clear();
    moduleTitleController.clear();
    moduleIdController.clear();
    activityIdController.clear();
    activityTitleController.clear();
    lineUrlController.clear();
  }

  @protected
  void buildNavCommand(
      Function(StonerCommand) succeedCallback, Function(String) failCallback) {
    StonerCommand cmd;
    switch (groupValue) {
      case 0:
        if (bookIdController.text?.isNotEmpty != true) {
          failCallback?.call('书本ID不能为空');
          return;
        }

        cmd = StonerCommand(
            stoner: NavModuleParam(
                book: NavBookParam(
                    bookId: bookIdController.text,
                    bookName: bookNameController.text,
                    jumpReader: bookJumpValue)));
        break;
      case 1:
        if (jumpUrlController.text?.isNotEmpty != true) {
          failCallback?.call('跳转URL不能为空');
          return;
        }
        cmd =
            StonerCommand(stoner: NavModuleParam(web: jumpUrlController.text));
        break;
      case 2:
        cmd = StonerCommand(stoner: NavModuleParam(route: 'revenue'));
        break;
      case 4:
        if (moduleIdController.text?.isNotEmpty != true) {
          failCallback?.call('模块ID不能为空');
          return;
        }
        if (moduleTitleController.text?.isNotEmpty != true) {
          failCallback?.call('模块标题不能为空');
          return;
        }
        cmd = StonerCommand(
            stoner: NavModuleParam(
                page: NavPageParam(
                    title: moduleTitleController.text,
                    module: int.parse(moduleIdController.text))));
        break;
      case 5:
        if (activityIdController.text?.isNotEmpty != true) {
          failCallback?.call('活动聚合页ID不能为空');
          return;
        }
        cmd = StonerCommand(
            stoner: NavModuleParam(
          activity: NavActivityParam(
              id: activityIdController.text,
              name: activityTitleController.text ?? ''),
        ));
        break;
      case 6:
        if (lineUrlController.text == null ||
            (!lineUrlController.text.startsWith('https://line.me/R/') &&
                !lineUrlController.text.startsWith('line://'))) {
          failCallback?.call('Line URL不符合规范');
          return;
        }
        cmd = StonerCommand(
            stoner: NavModuleParam(
                lineUri: lineUrlController.text
                    .replaceFirst('https://line.me/R/', 'line://')));
        break;
      case 7:
        cmd = StonerCommand(stoner: NavModuleParam(route: 'vipPage'));
        break;
      default:
        break;
    }
    succeedCallback?.call(cmd);
  }
}
