import 'package:flutter/material.dart';
import 'package:wechatapp1/const.dart';

class IndexBar extends StatefulWidget {

  final void Function(String str) indexBarCallback;

  IndexBar({
    this.indexBarCallback,
});

  @override
  _IndexBarState createState() => _IndexBarState();
}


int getIndex(BuildContext context, Offset globalPosition){
  //拿到Box
  RenderBox box = context.findRenderObject();
  //拿到y值
  double y = box.globalToLocal(globalPosition).dy;
  //算出字符高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  //算出第几个item，并且给出范围，防止越界
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length-1);

  return index;
}

class _IndexBarState extends State<IndexBar> {

  Color _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  Color _selectColor = Color.fromRGBO(1, 1, 1, 0.0);

  int _selectIndex = 0;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {

    List<Widget> words = [];
    for(int i = 0; i < INDEX_WORDS.length; i++){
      words.add(Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _selectIndex == i ? _selectColor : null,
              ),
            ),
            Text(
              INDEX_WORDS[i],
              style: TextStyle(
                fontSize: 10.0,
                color: _textColor,
              ),
            ),
          ],
        ),
      ));
    }

    return Positioned(
      right: 0.0,
      height: ScreenHeight(context) / 2,
      top: ScreenWidth(context) / 8,
      width: 120,
      child: Row(
        children: <Widget>[
          //气泡
          Container(
            alignment: Alignment(0,_indicatorY),
            width: 100,
            child: _indicatorHidden ? null : Stack(
              alignment: Alignment(-0.2,0.0),
              children: <Widget>[
                Image(image: AssetImage('images/气泡.png'), width: 60,),
                Text(
                  _indicatorText,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          //索引条
          GestureDetector(
            child: Container(
              width: 20,
              color: _bkColor,
              child: Column(
                children: words,
              ),
            ),
            onVerticalDragUpdate: (DragUpdateDetails details){
              int index = getIndex(context, details.globalPosition);

              setState(() {
                _indicatorY = 2.2 / 28 * index -1.1;
                _indicatorText = INDEX_WORDS[index];
                _indicatorHidden = false;

                _selectIndex = index;
              });

              widget.indexBarCallback(INDEX_WORDS[index]);
            },
            onVerticalDragDown: (DragDownDetails details){

              int index = getIndex(context, details.globalPosition);

              setState(() {
                _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.white;

                _indicatorText = INDEX_WORDS[index];
                _indicatorY = 2.2 / 28 * index -1.1;
                _indicatorHidden = false;

                _selectColor = Colors.green;

                _selectIndex = index;
              });

              widget.indexBarCallback(INDEX_WORDS[index]);
            },
            onVerticalDragEnd: (DragEndDetails details){
              setState(() {
                _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
                _textColor = Colors.black;

                _selectColor = Color.fromRGBO(1, 1, 1, 0.0);

                _indicatorHidden = true;

              });
            },
          ),
        ],
      ),
    );
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
