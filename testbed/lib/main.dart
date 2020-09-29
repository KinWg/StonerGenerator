// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:menubar/menubar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testbed/home_page/new_home_page.dart';
import 'package:testbed/utils/ui_utils.dart';
import 'package:window_size/window_size.dart' as window_size;

// The shared_preferences key for the testbed's color.
const _prefKeyColor = 'color';

void main() {
  // Try to resize and reposition the window to be half the width and height
  // of its screen, centered horizontally and shifted up from center.
  WidgetsFlutterBinding.ensureInitialized();
  window_size.getWindowInfo().then((window) {
    if (window.screen != null) {
      final screenFrame = window.screen.visibleFrame;
      final width = math.max((screenFrame.width / 3 * 2).roundToDouble(), 1200.0);
      final height = math.max((screenFrame.width / 3).roundToDouble(), 800.0);
      final left = ((screenFrame.width - width) / 2).roundToDouble();
      final top = ((screenFrame.height - height) / 3).roundToDouble();
      final frame = Rect.fromLTWH(left, top, width, height);
      window_size.setWindowFrame(frame);
      window_size
          .setWindowTitle('运营Json生成器');

      UIUtils.windowWidth = width;
      UIUtils.windowHeight = height;

      if (Platform.isMacOS) {
        window_size.setWindowMinSize(Size(800, 600));
        window_size.setWindowMaxSize(Size(1600, 1000));
      }
    }
  });

  runApp(new MyApp());
}

/// Top level widget for the application.
class MyApp extends StatefulWidget {
  /// Constructs a new app with the given [key].
  const MyApp({Key key}) : super(key: key);

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<MyApp> {
  _AppState() {
    if (Platform.isMacOS || Platform.isLinux) {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.containsKey(_prefKeyColor)) {
          setPrimaryColor(Color(prefs.getInt(_prefKeyColor)));
        }
      });
    }
  }

  Color _primaryColor = Colors.blueGrey.shade400;
  int _counter = 0;

  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>();

  /// Sets the primary color of the app.
  void setPrimaryColor(Color color) {
    setState(() {
      _primaryColor = color;
    });
    _saveColor();
  }

  void _saveColor() async {
    if (Platform.isMacOS || Platform.isLinux) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_prefKeyColor, _primaryColor.value);
    }
  }

  void incrementCounter() {
    _setCounter(_counter + 1);
  }

  void _decrementCounter() {
    _setCounter(_counter - 1);
  }

  void _setCounter(int value) {
    setState(() {
      _counter = value;
    });
  }

  /// Rebuilds the native menu bar based on the current state.
  void updateMenubar() {
    // Currently, the menubar plugin is only implemented on macOS and linux.
    if (!Platform.isMacOS && !Platform.isLinux) {
      return;
    }
    setApplicationMenu([
      Submenu(label: 'Color', children: [
        MenuItem(
            label: 'Reset',
            enabled: _primaryColor != Colors.blue,
            shortcut: LogicalKeySet(
                LogicalKeyboardKey.meta, LogicalKeyboardKey.backspace),
            onClicked: () {
              setPrimaryColor(Colors.blue);
            }),
        MenuDivider(),
        Submenu(label: 'Presets', children: [
          MenuItem(
              label: 'Red',
              enabled: _primaryColor != Colors.red,
              shortcut: LogicalKeySet(LogicalKeyboardKey.meta,
                  LogicalKeyboardKey.shift, LogicalKeyboardKey.keyR),
              onClicked: () {
                setPrimaryColor(Colors.red);
              }),
          MenuItem(
              label: 'Green',
              enabled: _primaryColor != Colors.green,
              shortcut: LogicalKeySet(LogicalKeyboardKey.meta,
                  LogicalKeyboardKey.alt, LogicalKeyboardKey.keyG),
              onClicked: () {
                setPrimaryColor(Colors.green);
              }),
          MenuItem(
              label: 'Purple',
              enabled: _primaryColor != Colors.deepPurple,
              shortcut: LogicalKeySet(LogicalKeyboardKey.meta,
                  LogicalKeyboardKey.control, LogicalKeyboardKey.keyP),
              onClicked: () {
                setPrimaryColor(Colors.deepPurple);
              }),
        ])
      ]),
      Submenu(label: 'Counter', children: [
        MenuItem(
            label: 'Reset',
            enabled: _counter != 0,
            shortcut: LogicalKeySet(
                LogicalKeyboardKey.meta, LogicalKeyboardKey.digit0),
            onClicked: () {
              _setCounter(0);
            }),
        MenuDivider(),
        MenuItem(
            label: 'Increment',
            shortcut: LogicalKeySet(LogicalKeyboardKey.f2),
            onClicked: incrementCounter),
        MenuItem(
            label: 'Decrement',
            enabled: _counter > 0,
            shortcut: LogicalKeySet(LogicalKeyboardKey.f1),
            onClicked: _decrementCounter),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '运营JSON生成器',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo.shade300,
        accentColor: Colors.indigo.shade100,
        // Specify a font to reduce potential issues with the
        // application behaving differently on different platforms.
        fontFamily: 'Roboto',
        toggleableActiveColor: Colors.indigo.shade300
      ),
      darkTheme: ThemeData.dark(),
      home: HomePage2(),
      locale: Locale('zh', 'CN'),
    );
  }
}