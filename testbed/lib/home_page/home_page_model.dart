import 'dart:async';

/// Created by Kin on 2020/9/28

class HomePageModel {
  final _controller = StreamController<HomePageIndexEvent>.broadcast();

  Stream<HomePageIndexEvent> get event => _controller.stream;

  void changeIndex(int index) {
    _controller.add(HomePageIndexEvent(index));
  }
}

class HomePageIndexEvent {
  final int index;

  HomePageIndexEvent(this.index);
}