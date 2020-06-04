import 'package:flutter/material.dart';
import 'package:wechatapp1/const.dart';
import 'package:wechatapp1/page/discover/discover_cell.dart';
import 'package:wechatapp1/page/discover/discover_child_page.dart';

class MinePage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<MinePage> {
  Widget _cameraWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
                  title: '相机',
                )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 40, right: 10),
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image(
              image: AssetImage('images/相机.png'),
            ),
          ],
        ),
      ), //相机,
    );
  }

  Widget _separateWidget() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _lineWidget() {
//    return Container(
//      height: 0.5,
//      margin: EdgeInsets.only(left: 50),
//      width: ScreenWidth(context)-50,
//      color: Colors.grey,
//    );
    return Row(
      children: <Widget>[
        Container(
          height: 0.5,
          width: 50,
          color: Colors.white,
        ),
        Container(
          height: 0.5,
        ),
      ],
    );
  }

  Widget _headerWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
                  title: '个人信息',
                )));
      },
      child: Container(
        color: Colors.white,
        height: 200,
        child: Container(
          margin: EdgeInsets.only(top: 80, bottom: 20),
          child: Row(
            children: <Widget>[
              //头像
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('images/Hank.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
                width: ScreenWidth(context) - 115,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Hank',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ), //昵称
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '微信号：123446',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18.0,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage('images/二维码.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Image(
                                image: AssetImage('images/icon_right.png'),
                                width: 15,
                              )
                            ],
                          ),
                        ],
                      ),
                    ), //微信号+箭头等
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeChatThemeColor,
      body: Stack(
        children: <Widget>[
          //列表
          Container(
            color: WeChatThemeColor,
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                //使用Column，就不会有上面空出来的空格，listView就有
                child: ListView(
                  children: <Widget>[
                    //头部
                    _headerWidget(),

                    _separateWidget(),
                    //cell
                    DiscoverCell(
                      title: '支付',
                      imageName: 'images/微信 支付.png',
                    ),
                    _separateWidget(),
                    DiscoverCell(
                      title: '收藏',
                      imageName: 'images/微信收藏.png',
                    ),
                    _lineWidget(),
                    DiscoverCell(
                      title: '相册',
                      imageName: 'images/微信相册.png',
                    ),
                    _lineWidget(),
                    DiscoverCell(
                      title: '卡包',
                      imageName: 'images/微信卡包.png',
                    ),
                    _lineWidget(),
                    DiscoverCell(
                      title: '表情',
                      imageName: 'images/微信表情.png',
                    ),
                    _separateWidget(),
                    DiscoverCell(
                      title: '设置',
                      imageName: 'images/微信设置.png',
                    ),
                  ],
                )),
          ),
          _cameraWidget(),
        ],
      ),
    );
  }
}
