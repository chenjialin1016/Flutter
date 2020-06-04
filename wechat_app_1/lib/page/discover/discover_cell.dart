import 'package:flutter/material.dart';
import 'package:wechatapp1/page/discover/discover_child_page.dart';

//class DiscoverCell extends StatelessWidget {
//  final String title;
//  final String subTitle;
//  final String imageName;
//  final String subImageName;
//
//  DiscoverCell({
//    this.title,
//    this.subTitle,
//    this.imageName,
//    this.subImageName,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        Navigator.of(context).push(MaterialPageRoute(
//            builder: (BuildContext context) => DiscoverChildPage(
//                  title: '$title',
//                )));
//      },
//      child: Container(
//        color: Colors.white,
//        height: 54,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            //左
//            Container(
//              padding: EdgeInsets.all(10),
//              child: Row(
//                children: <Widget>[
//                  Image(
//                    image: AssetImage(imageName),
//                    width: 20,
//                  ),
//                  SizedBox(
//                    width: 15,
//                  ),
//                  Text(title),
//                ],
//              ),
//            ),
//            //右
//            Container(
//              padding: EdgeInsets.all(10),
//              child: Row(
//                children: <Widget>[
//                  subTitle != null ? Text(subTitle) : Text(''),
//                  subImageName != null
//                      ? Image(
//                          image: AssetImage(subImageName),
//                          width: 12,
//                        )
//                      : Container(),
//                  Image(
//                    image: AssetImage('images/icon_right.png'),
//                    width: 15,
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class DiscoverCell extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  const DiscoverCell({
    Key key,
    @required this.title,
    this.subTitle,
    @required this.imageName,
    this.subImageName,
  })  : assert(title != null, 'title 不能为空'),
        assert(imageName != null, 'imageName 不能为空');

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  final TextStyle _titleTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
                  title: widget.title,
                )));
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        color: _currentColor,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //左
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.title,
                    style: _titleTextStyle,
                  ),
                ],
              ),
            ),
            //右
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  widget.subTitle != null ? Text(widget.subTitle) : Text(''),
                  widget.subImageName != null
                      ? Image(
                          image: AssetImage(widget.subImageName),
                          width: 12,
                        )
                      : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
