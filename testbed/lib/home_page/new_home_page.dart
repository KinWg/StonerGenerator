import 'package:flutter/material.dart';
import 'package:testbed/home_page/home_page_content_widget.dart';
import 'package:testbed/home_page/home_page_list_widget.dart';
import 'package:testbed/home_page/home_page_model.dart';
import 'package:testbed/utils/ui_utils.dart';

/// Created by Kin on 2020/9/28

class HomePage2 extends StatefulWidget {
  @override
  State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final _model = HomePageModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: UIUtils.windowWidth,
        height: UIUtils.windowHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageListWidget(_model),
            SizedBox(width: 8.0,),
            Expanded(child: HomePageContentWidget(_model))
          ],
        ),
      ),
    );
  }
}
