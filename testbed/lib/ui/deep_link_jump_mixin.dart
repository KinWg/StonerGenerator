import 'package:flutter/material.dart';

/// Created by Kin on 2020/9/11

mixin DeepLinkJumpMixin<T extends StatefulWidget> on State<T> {
  @protected
  var groupValue = 0;
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
  final chapterIdxController = TextEditingController();

  @protected
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

  @protected
  List<Widget> _getRadios() {
    final list = <Widget>[]..
    add(Radio<int>(
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
    ..add(Text('跳个人页', style: TextStyle(fontSize: 12.0)))
    ..add(Radio<int>(
      groupValue: groupValue,
      value: 6,
      onChanged: (value) {
        setState(() {
          groupValue = value;
        });
      },
    ))
    ..add(Text('跳书架', style: TextStyle(fontSize: 12.0)))
    ..add(Radio<int>(
      groupValue: groupValue,
      value: 7,
      onChanged: (value) {
        setState(() {
          groupValue = value;
        });
      },
    ))
    ..add(Text('跳首页', style: TextStyle(fontSize: 12.0)))
    ..add(Radio<int>(
      groupValue: groupValue,
      value: 8,
      onChanged: (value) {
        setState(() {
          groupValue = value;
        });
      },
    ))
    ..add(Text('跳客服', style: TextStyle(fontSize: 12.0)));
    return list;
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
      default:
        return Container();
    }
  }

  Widget _buildBookWidget() {
    return Container(
        height: 185,
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
                hintText: '名称，非必填',
                labelText: '书本名称',
              ),
            ),
            TextField(
              controller: chapterIdxController,
              decoration: InputDecoration(
                hintText: '从1开始',
                labelText: '第几章',
              ),
            ),
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
}