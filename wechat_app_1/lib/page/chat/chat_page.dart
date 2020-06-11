import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechatapp1/const.dart';
import 'package:wechatapp1/page/chat/chat.dart';
import 'package:wechatapp1/page/discover/discover_child_page.dart';
import 'package:wechatapp1/tools/dio_manager.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Chat> _datas = [];
  bool _cancelConnect = false;

  ScrollController _scrollController = ScrollController();

  //popmenuitem
  Widget _buildPopupMenuItem(String imageAss, String title) {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(imageAss),
          width: 20,
          height: 20,
        ),
        Container(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

//  滚动视图的监听
  void _scrollListen() {
    _scrollController.addListener(() {
//      滚动的最大范围
      var maxScrollExtent = _scrollController.position.maxScrollExtent;
//      获取当前位置的像素值
      var pixels = _scrollController.position.pixels;
//      判断是否滑动到底部
      if (maxScrollExtent == pixels) {
        print('上拉加载更多');
        _pullRefresh();
      }
    });
  }

  void dioRequest(){
    DioManager.get(
      'http://rap2.taobao.org:38080/app/mock/256982/api/chat/list',
      success: (data){
        print('dio 数据请求成功');
        setState(() {
          List<dynamic> array = data['chat_list'];
          array.forEach((element) {
            _datas.add(Chat.fromJson(element));
          });
        });
      },
      failure: (error){
        print('error = $error');
      }
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollListen();

    dioRequest();

//    getDatas()
//        .then((List<Chat> datas) {
//          if (!_cancelConnect) {
//            _datas = datas;
//          }
//        })
//        .catchError((e) {
//          print('错误$e');
//        })
//        .whenComplete(() {
//          print('完毕!');
//        })
//        .timeout(Duration(seconds: 6))
//        .catchError((timeout) {
//          _cancelConnect = true;
//          print('超时输出:$timeout');
//        });
  }

  Future<List<Chat>> getDatas() async {
    _cancelConnect = false;
    final response = await http
        .get('http://rap2.taobao.org:38080/app/mock/256982/api/chat/list');
//    print('statecode: ${response.statusCode}');
//  获取相应数据，并将数据转换成map
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      //  转模型数组
      List<Chat> chatList = responseBody['chat_list']
          .map<Chat>((item) => Chat.fromJson(item))
          .toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  Widget _cellForRow(BuildContext context, int index) {
    return ListTile(
      title: Text(_datas[index].name),
      subtitle: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 10),
        child: Text(
          _datas[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(image: NetworkImage(_datas[index].imageUrl)),
        ),
      ),
    );
  }

//  必须使用async，不然会报错
  Future _pullRefresh() async {
    print('下拉刷新');
    _datas.clear();

    dioRequest();
//    getDatas()
//        .then((List<Chat> datas) {
//          if (!_cancelConnect) {
//            //需要在setState中刷新数据，否则数据不会刷新
//            setState(() {
//              _datas.addAll(datas);
//            });
//          }
//        })
//        .catchError((e) {
//          print('错误$e');
//        })
//        .whenComplete(() {
//          print('完毕!');
//        })
//        .timeout(Duration(seconds: 6))
//        .catchError((timeout) {
//          _cancelConnect = true;
//          print('超时输出:$timeout');
//        });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text('微信'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              onSelected: (String value) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DiscoverChildPage(
                          title: value,
                        )));
              },
              offset: Offset(0.0, 60),
              child: Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊'),
                    value: '发起群聊',
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友'),
                    value: '添加朋友',
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫'),
                    value: '扫一扫',
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/收付款.png', '收付款'),
                    value: '收付款',
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: _datas.length == 0
            ? Center(
                child: Text('Loading...'),
              )
            : RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _datas.length,
                  itemBuilder: _cellForRow,
                ),
              ),
      ),
    );
  }
}
