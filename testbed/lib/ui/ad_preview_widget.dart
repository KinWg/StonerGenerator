import 'package:flutter/material.dart';
import 'package:testbed/utils/ui_utils.dart';

/// Created by Kin on 2020/9/29

class AdPreviewWidget extends StatefulWidget {
  final List ads;
  final Function(int index) deleteCallback;

  AdPreviewWidget(this.ads, this.deleteCallback);

  @override
  State createState() => _AdPreviewState();
}

class _AdPreviewState extends State<AdPreviewWidget> {
  List ads;

  @override
  void initState() {
    super.initState();
    ads = widget.ads;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: (UIUtils.windowHeight / 2).floorToDouble(),
      height: 300,
      color: Colors.white,
      child: ListView.builder(itemBuilder: (context, index) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(ads[index].toString(),
                style: TextStyle(fontSize: 14.0, color: Colors.black87),)),
              IconButton(icon: Container(padding: EdgeInsets.all(5.0),
                child: Icon(Icons.close),), onPressed: () {
                setState(() {
                  ads.removeAt(index);
                });
                widget.deleteCallback?.call(index);
              }),
            ],
          ),
        );
      }, itemCount: ads.length,),
    );
  }
}