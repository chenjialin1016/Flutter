import 'package:flutter/material.dart';
import 'package:wechatapp1/page/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<DiscoverPage> {
  Color _themColor = Color.fromRGBO(220, 220, 220, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _themColor,
        appBar: AppBar(
          backgroundColor: _themColor,
          //以下三个是专门为安卓使用的属性
          centerTitle: true,
          title: Text('发现'),
          //底部边栏
          elevation: 0.0,
        ),
        body: ListView(
          children: <Widget>[
            DiscoverCell(
              title: '朋友圈',
              imageName: 'images/朋友圈.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '扫一扫',
              imageName: 'images/扫一扫.png',
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                )
              ],
            ),
            DiscoverCell(
              title: '摇一摇',
              imageName: 'images/摇一摇.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '看一看',
              imageName: 'images/看一看icon.png',
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                )
              ],
            ),
            DiscoverCell(
              title: '搜一搜',
              imageName: 'images/搜一搜.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '附近的人',
              imageName: 'images/附近的人icon.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '购物',
              imageName: 'images/购物.png',
              subTitle: '618限时特价',
              subImageName: 'images/badge.png',
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                )
              ],
            ),
            DiscoverCell(
              title: '游戏',
              imageName: 'images/游戏.png',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              title: '小程序',
              imageName: 'images/小程序.png',
            ),
          ],
        ));
  }
}
