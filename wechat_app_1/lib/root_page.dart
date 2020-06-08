import 'package:flutter/material.dart';
import 'package:wechatapp1/page/chat/chat_page.dart';
import 'package:wechatapp1/page/discover/discover_page.dart';
import 'package:wechatapp1/page/friends/friends_page.dart';
import 'package:wechatapp1/page/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _currentIndex = 0;

  List<Widget> _pages = [ChatPage(), FrinedsPage(), DiscoverPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        selectedFontSize: 12.0,
        currentIndex: _currentIndex,
        fixedColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            title: Text('微信'),
            icon: Image.asset(
              'images/tabbar_chat.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_chat_hl.png',
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('通讯录'),
            icon: Image.asset(
              'images/tabbar_friends.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_friends_hl.png',
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('发现'),
            icon: Image.asset(
              'images/tabbar_discover.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_discover_hl.png',
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('我'),
            icon: Image.asset(
              'images/tabbar_mine.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_mine_hl.png',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

