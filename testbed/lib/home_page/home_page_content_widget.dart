import 'package:flutter/material.dart';
import 'package:testbed/home_page/home_page_model.dart';
import 'package:testbed/ui/about_page.dart';
import 'package:testbed/ui/appsflyer_page.dart';
import 'package:testbed/ui/facebook_page.dart';
import 'package:testbed/ui/google_page.dart';
import 'package:testbed/ui/home_dialog_ad_page.dart';
import 'package:testbed/ui/home_float_ad_page.dart';
import 'package:testbed/ui/launch_ad_page.dart';
import 'package:testbed/ui/reader_ad_page.dart';
import 'package:testbed/ui/shelf_ad_page.dart';
import 'package:testbed/ui/stoner_nav_page.dart';
import 'package:testbed/utils/ui_utils.dart';

/// Created by Kin on 2020/9/28

class HomePageContentWidget extends StatefulWidget {
  final HomePageModel _model;

  HomePageContentWidget(this._model);

  @override
  State createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContentWidget> {
  var _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    widget._model.event.listen((event) {
      if (event.index != _currentIndex && mounted) {
        setState(() {
          _currentIndex = event.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Container(
        width: (UIUtils.windowWidth ?? 300) - 300,
        height: UIUtils.windowHeight,
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    switch (_currentIndex) {
      case 0: return HomeDialogAdPage();
      case 1: return HomeFloatAdPage();
      case 2: return LaunchAdPage();
      case 3: return ReaderAdPage();
      case 4: return ShelfAdPage();
      case 5: return AppsflyerPage();
      case 6: return FacebookPage();
      case 7: return GoogleS2sPage();
      case 8: return StonerNavPage();
      case 9: return AboutPage();
      default: return Container();
    }
  }
}