import 'package:flutter/material.dart';
import 'package:testbed/utils/ui_utils.dart';

/// Created by Kin on 2020/9/11

mixin CommonWidgetBuilderMixin<T extends StatefulWidget> on State<T> {
  @protected
  final idController = TextEditingController();
  @protected
  final urlController = TextEditingController();
  @protected
  final weightController = TextEditingController(text: '0');
  @protected
  final payCountController = TextEditingController(text: '0');
  @protected
  var startTime = DateTime.now();
  @protected
  var endTime = DateTime.now();
  @protected
  var loginValue = 0;

  final titleStyle = TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold);
  final hintStyle = TextStyle(color: Colors.grey, fontSize: 16.0);
  final textStyle = TextStyle(color: Colors.indigo.shade400, fontSize: 18.0);

  @protected
  Widget buildIdInput() {
    return buildInput(
        '广告ID',
        '须唯一，建议使用年月日序号来构造，如2020091101',
        idController);
  }

  @protected
  Widget buildImageUrlInput() {
    return buildInput(
        '图片URL',
        '广告图片的URL，须带上https://前缀',
        urlController);
  }

  @protected
  Widget buildStartTime() {
    return Container(
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '开始时间',
              style: titleStyle
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              startTime.toIso8601String(),
              style: textStyle
            ),
            SizedBox(
              width: 16,
            ),
            MaterialButton(
              onPressed: () async {
                final timeNow = DateTime.now();
                final datePicked = await showDatePicker(
                    context: context,
                    initialDate: timeNow,
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030));
                final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(timeNow));
                if (picked != null && datePicked != null) {
                  setState(() {
                    startTime = DateTime(datePicked.year, datePicked.month,
                        datePicked.day, picked.hour, picked.minute);
                  });
                }
              },
              child: Text(
                '选择',
                style: hintStyle,
              ),
            ),
          ]),
    );
  }

  @protected
  Widget buildEndTime() {
    return Container(
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '结束时间',
              style: titleStyle,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              endTime.toIso8601String(),
              style: textStyle,
            ),
            SizedBox(
              width: 16,
            ),
            MaterialButton(
              onPressed: () async {
                final timeNow = DateTime.now();
                final datePicked = await showDatePicker(
                    context: context,
                    initialDate: timeNow,
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030));
                final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(timeNow));
                if (picked != null && datePicked != null) {
                  setState(() {
                    endTime = DateTime(datePicked.year, datePicked.month,
                        datePicked.day, picked.hour, picked.minute);
                  });
                }
              },
              child: Text(
                '选择',
                style: hintStyle,
              ),
            ),
          ]),
    );
  }

  @protected
  Widget buildLoginInput() {
    return Container(
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '登录后显示',
              style: titleStyle,
            ),
            SizedBox(
              width: 16,
            ),
            Radio<int>(
              groupValue: loginValue,
              value: 0,
              onChanged: (value) {
                setState(() {
                  loginValue = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '是',
              style: titleStyle,
            ),
            SizedBox(
              width: 20,
            ),
            Radio<int>(
              groupValue: loginValue,
              value: 1,
              onChanged: (value) {
                setState(() {
                  loginValue = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '否',
              style: titleStyle,
            ),
          ]),
    );
  }

  Widget buildWeightInput() {
    return buildInput('优先级', '数字越大优先级越高', weightController);
  }

  Widget buildPayCountInput() {
    return buildInput('充值次数', '大于等于此次数才会显示', payCountController);
  }

  Widget buildInput(
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
            style: titleStyle,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: TextField(
            controller: controller,
            decoration: InputDecoration.collapsed(
                hintText: hint, hintStyle: hintStyle),
            style: textStyle,
          ))
        ],
      ),
    );
  }

  void clearCommonData() {
    idController.clear();
    urlController.clear();
    weightController.clear();
    payCountController.clear();
  }

  Widget buildLine() {
    return Container(
      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
      color: Colors.indigo.shade50,
      height: 2.0,
    );
  }
}
