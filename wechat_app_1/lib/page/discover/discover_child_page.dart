import 'package:flutter/material.dart';
import 'package:wechatapp1/const.dart';

//class DiscoverChildPage extends StatelessWidget {
//
//  final String title;
//
//  DiscoverChildPage({
//    this.title,
//});
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('$title'),
//      ),
//      body: Center(
//        child: Text('$title'),
//      ),
//    );
//  }
//}

class DiscoverChildPage extends StatefulWidget {

  final String title;

  DiscoverChildPage({
    Key key,
    this.title
  }) : super(key: key);//接收从cell传过来的值

  @override
  _DiscoverChildPageState createState() => _DiscoverChildPageState();
}

class _DiscoverChildPageState extends State<DiscoverChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
