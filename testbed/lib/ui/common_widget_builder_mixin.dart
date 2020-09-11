import 'package:flutter/material.dart';

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

  @protected
  Widget buildIdInput() {
    return TextField(
      controller: idController,
      decoration: InputDecoration(
        hintText: '须唯一，建议使用年月日序号来构造，如2020091101',
        labelText: '广告ID',
      ),
    );
  }

  @protected
  Widget buildImageUrlInput() {
    return TextField(
      controller: urlController,
      decoration: InputDecoration(
        hintText: '广告图片的URL，须带上https://前缀',
        labelText: '图片URL',
      ),
    );
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
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              startTime.toIso8601String(),
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 10,
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
                style: TextStyle(fontSize: 12),
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
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              endTime.toIso8601String(),
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 10,
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
                style: TextStyle(fontSize: 12),
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
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 10,
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
              style: TextStyle(fontSize: 12),
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
              style: TextStyle(fontSize: 12),
            ),
          ]),
    );
  }

  Widget buildWeightInput() {
    return TextField(
      controller: weightController,
      decoration: InputDecoration(
        hintText: '数字越大优先级越高',
        labelText: '优先级',
      ),
    );
  }

  Widget buildPayCountInput() {
    return TextField(
      controller: payCountController,
      decoration: InputDecoration(
        hintText: '大于等于此次数才会显示',
        labelText: '充值次数',
      ),
    );
  }

  void clearCommonData() {
    idController.clear();
    urlController.clear();
    weightController.clear();
    payCountController.clear();
  }
}
