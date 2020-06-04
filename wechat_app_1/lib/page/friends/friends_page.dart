import 'package:flutter/material.dart';
import 'package:wechatapp1/const.dart';
import 'package:wechatapp1/page/discover/discover_child_page.dart';
import 'package:wechatapp1/page/friends/friends.dart';
import 'package:wechatapp1/page/friends/index_bar.dart';

class FrinedsPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<FrinedsPage> {

  ScrollController _scrollController;
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  final List<Friends> _listDatas = [];

  final List<Friends> _headerDatas = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  Widget _cellForRow(BuildContext context, int index){
    if (index < _headerDatas.length) {
      return _FriendsCell(
        imageAssets: _headerDatas[index].imageUrl,
        name: _headerDatas[index].name,
      );
    }

    bool _hiddenIndex = (index-4 > 0 && _listDatas[index-4].indexLetter == _listDatas[index-5].indexLetter);

    return _FriendsCell(
      imageUrl: _listDatas[index-4].imageUrl,
      name: _listDatas[index-4].name,
      groupTitle:  _hiddenIndex ? null : _listDatas[index-4].indexLetter,
    );
  }

  @override
  void initState() {

    _listDatas..addAll(friendsDatas)..addAll(friendsDatas);

    _listDatas.sort((Friends a, Friends b) => a.indexLetter.compareTo(b.indexLetter));

    var _groupOffset = 54.5 * 4;

    for(int i = 0; i < _listDatas.length; i++){
      if (i < 1){
        //第一个cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84.5;
      }else if (_listDatas[i].indexLetter == _listDatas[i-1].indexLetter){
        //剩余的cell
        _groupOffset += 54.5;
      }else{
        //下一个带头的cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84.5;
      }
    }

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text('通讯录'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverChildPage(
                        title: '添加朋友',
                      )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _headerDatas.length + _listDatas.length,
              itemBuilder: _cellForRow,
            ),
          ),
          IndexBar(
            indexBarCallback: (String str){
              if (_groupOffsetMap[str] != null){
                _scrollController.animateTo(_groupOffsetMap[str], duration: Duration(milliseconds: 1), curve: Curves.easeIn);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FriendsCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  _FriendsCell({
    this.imageUrl,
    this.name,
    this.groupTitle,
    this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //cell头
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: Color.fromRGBO(1, 1, 1, 0.1),
          child: groupTitle != null ? Text(
            groupTitle,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ) : null,
        ),

        //cell
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              //图片
              Container(
                height: 34,
                width: 34,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    image: imageUrl != null ? NetworkImage(imageUrl) : AssetImage(imageAssets)
                  ),
                ),
              ),
              //名称
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize:  17.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        //分割线
        Container(
          margin: EdgeInsets.only(left: 50),
          width: ScreenWidth(context)-50,
          height: 0.5,
          color: Colors.grey,
        ),
      ],
    );
  }
}
