import 'package:flutter/material.dart';
import 'package:testbed/utils/ui_utils.dart';

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
  final bookDetailIdController = TextEditingController();

  final _titleStyle = TextStyle(
      color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold);
  final _hintStyle = TextStyle(color: Colors.grey, fontSize: 16.0);
  final _textStyle = TextStyle(color: Colors.indigo.shade400, fontSize: 18.0);

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
    ..add(Text('跳书本', style: _titleStyle))
    ..add(Radio<int>(
      groupValue: groupValue,
      value: 1,
      onChanged: (value) {
        setState(() {
          groupValue = value;
        });
      },
    ))
    ..add(Text('跳网页', style: _titleStyle))
    ..add(Radio<int>(
      groupValue: groupValue,
      value: 2,
      onChanged: (value) {
        setState(() {
          groupValue = value;
        });
      },
    ))
    ..add(Text('跳充值', style: _titleStyle))
      ..add(Radio<int>(
        groupValue: groupValue,
        value: 9,
        onChanged: (value) {
          setState(() {
            groupValue = value;
          });
        },
      ))
      ..add(Text('跳详情页', style: _titleStyle));
    // ..add(Radio<int>(
    //   groupValue: groupValue,
    //   value: 4,
    //   onChanged: (value) {
    //     setState(() {
    //       groupValue = value;
    //     });
    //   },
    // ))
    // ..add(Text('跳排行榜', style: _titleStyle))
    // ..add(Radio<int>(
    //   groupValue: groupValue,
    //   value: 5,
    //   onChanged: (value) {
    //     setState(() {
    //       groupValue = value;
    //     });
    //   },
    // ))
    // ..add(Text('跳个人页', style: _titleStyle))
    // ..add(Radio<int>(
    //   groupValue: groupValue,
    //   value: 6,
    //   onChanged: (value) {
    //     setState(() {
    //       groupValue = value;
    //     });
    //   },
    // ))
    // ..add(Text('跳书架', style: _titleStyle))
    // ..add(Radio<int>(
    //   groupValue: groupValue,
    //   value: 7,
    //   onChanged: (value) {
    //     setState(() {
    //       groupValue = value;
    //     });
    //   },
    // ))
    // ..add(Text('跳首页', style: _titleStyle))
    // ..add(Radio<int>(
    //   groupValue: groupValue,
    //   value: 8,
    //   onChanged: (value) {
    //     setState(() {
    //       groupValue = value;
    //     });
    //   },
    // ))
    // ..add(Text('跳客服', style: _titleStyle));
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
      case 9:
        return _buildBookDetailWidget();
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
            _buildInput('书本ID', 'ID', bookIdController),
            _buildInput('书本名称', '名称，非必填', bookNameController),
            _buildInput('第几章', '从1开始', chapterIdxController)
          ],
        ));
  }

  Widget _buildBookDetailWidget() {
    return Container(
        height: 185,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInput('书本ID', 'ID', bookDetailIdController),
          ],
        ));
  }

  Widget _buildUrlWidget() {
    return _buildInput('跳转页面', 'URL', jumpUrlController);
  }

  Widget _buildModuleWidget() {
    return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInput('模块ID', 'ID', moduleIdController),
            _buildInput('模块标题', '标题', moduleTitleController),
          ],
        ));
  }

  Widget _buildInput(
      String title, String hint, TextEditingController controller) {
    return Container(
      width: UIUtils.windowWidth - 332,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: _titleStyle,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration.collapsed(
                    hintText: hint, hintStyle: _hintStyle),
                style: _textStyle,
              ))
        ],
      ),
    );
  }
}