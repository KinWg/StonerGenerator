import 'package:flutter/material.dart';

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
  var groupValue = 0;
  @protected
  var bookJumpValue = 0;
  
  Widget buildJumpRadio() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getRadios(),
      ),
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
      ..add(Text('跳活动聚合页', style: TextStyle(fontSize: 12.0)));
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
              controller: moduleTitleController,
              decoration: InputDecoration(
                hintText: '标题',
                labelText: '聚合页标题',
              ),
            ),
            TextField(
              controller: moduleIdController,
              decoration: InputDecoration(
                hintText: 'ID',
                labelText: '聚合页ID',
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
  }
}