import 'dart:convert';

class NavModuleParam {
  NavPageParam page;
  String route;
  String web;
  NavBookParam book;
  NavActivityParam activity;

  NavModuleParam({this.page, this.route, this.web, this.book, this.activity});

  bool isValid() {
    if (route?.isNotEmpty == true) {
      return true;
    }

    if (page != null) {
      if (page.tabs?.isNotEmpty == true) {
        return true;
      } else if ((page.module ?? 0) > 0) {
        return true;
      }
    }

    if (web?.isNotEmpty == true) {
      return true;
    }

    if (book?.bookId?.isNotEmpty == true) {
      return true;
    }

    if (activity?.id?.isNotEmpty == true) {
      return true;
    }

    return false;
  }

  NavModuleParam.fromJson(Map<String, dynamic> json) {
    page =
        json['page'] != null ? new NavPageParam.fromJson(json['page']) : null;
    route = json['route'];
    web = json['web'];
    book = json['book'] != null ? NavBookParam.fromJson(json['book']) : null;
    activity = json['activity'] != null ? NavActivityParam.fromJson(json['activity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    if (route?.isNotEmpty == true) {
      data['route'] = this.route;
    }
    if (web?.isNotEmpty == true) {
      data['web'] = this.web;
    }
    if (book != null) {
      data['book'] = book.toJson();
    }
    if (activity != null) {
      data['activity'] = activity.toJson();
    }
    return data;
  }

  String toRawJson() => json.encode(toJson());

  NavModuleParam.fromRawJson(String jsonStr) {
    final jsonMap = json.decode(jsonStr);

    page = jsonMap['page'] != null
        ? new NavPageParam.fromJson(jsonMap['page'])
        : null;
    route = jsonMap['route'];
    web = jsonMap['web'];
    book =
        jsonMap['book'] != null ? NavBookParam.fromJson(jsonMap['book']) : null;
    activity = jsonMap['activity'] != null ? NavActivityParam.fromJson(jsonMap['activity']) : null;
  }
}

class NavPageParam {
  String title;
  String key;
  int module;
  List<Tab> tabs;

  NavPageParam({this.title, this.key, this.module, this.tabs});

  NavPageParam.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    key = json['key'];
    module = json['module'];
    if (json['tab'] != null) {
      tabs = new List<Tab>();
      json['tab'].forEach((v) {
        tabs.add(new Tab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['key'] = this.key;
    data['module'] = this.module;
    if (this.tabs != null) {
      data['tab'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tab {
  String title;
  int module;

  Tab({this.title, this.module});

  Tab.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['module'] = this.module;
    return data;
  }
}

class NavBookParam {
  String bookId;
  String bookName;
  int jumpReader;

  NavBookParam({this.bookId, this.bookName, this.jumpReader});

  factory NavBookParam.fromJson(Map<String, dynamic> json) => NavBookParam(
        bookId: json['bookId'],
        bookName: json['bookName'],
        jumpReader: json['jumpReader'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'bookName': bookName,
        'jumpReader': jumpReader,
      };
}

class NavActivityParam {
  String id;
  String name;

  NavActivityParam({
    this.id,
    this.name,
  });

  factory NavActivityParam.fromJson(Map<String, dynamic> json) =>
      NavActivityParam(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class StonerCommand {
  NavModuleParam stoner;

  StonerCommand({this.stoner});

  StonerCommand.fromJson(Map<String, dynamic> json) {
    stoner = json['stoner'] != null
        ? new NavModuleParam.fromJson(json['stoner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stoner != null) {
      data['stoner'] = this.stoner.toJson();
    }
    return data;
  }
}
