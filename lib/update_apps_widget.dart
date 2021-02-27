import 'dart:ui';
import 'package:flutter/material.dart';

class UpdatedItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;
  UpdatedItemModel({this.appIcon, this.appName, this.appSize, this.appDate, this.appDescription, this.appVersion});
}

class UpdatedItemWidget extends StatefulWidget {
  final UpdatedItemModel model;
  final VoidCallback onPressed;

  UpdatedItemWidget({Key key,this.model,this.onPressed}) : super(key: key);

  @override
  _UpdatedItemWidgetState createState() => _UpdatedItemWidgetState();
}

class _UpdatedItemWidgetState extends State<UpdatedItemWidget> {
  GlobalKey _topKey = GlobalKey();
  GlobalKey _expendKey = GlobalKey();
  num _topWidgetHeight = 100;
  num _expendHeight = 0;
  num _maxDisplayHeight = 136;
  bool _expended = false;

//创建上半部分
  Widget buildTopRow(BuildContext context) {
    return Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(widget.model.appIcon, width: 80,height:80)
              )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.model.appName,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),),
                Text("${widget.model.appDate}",maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0,0,10,0),
            child: TextButton(
              child: Text("OPEN", style: TextStyle(color:Color(0xFF007AFE),fontWeight: FontWeight.bold),),
              style: TextButton.styleFrom(primary: Colors.blue[700], backgroundColor: Color(0xFFF1F0F7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
              onPressed: widget.onPressed,
            ),
          )
        ]);
  }

  //创建下半部分
  Widget buildBottomRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15,0,15,0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.model.appDescription),
              Padding(
                padding: EdgeInsets.fromLTRB(0,10,0,0),
                child: Text("${widget.model.appVersion} • ${widget.model.appSize} MB")
              )
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _accentColor = Theme.of(context).canvasColor;
    List _widgetList = <Widget>[
        Container(height: _expended ? (_topWidgetHeight + _expendHeight).toDouble() : _maxDisplayHeight.toDouble(), color: _accentColor),
        Positioned(key:_topKey, left:0, top:0, right: 0, child:buildTopRow(context)),
        Positioned(key:_expendKey, left:0, top:_topWidgetHeight.toDouble(), right: 0, child: buildBottomRow(context)),
      ];

    List _morewidgetList = List<Widget>.from(_widgetList);
    _morewidgetList.add(
      Positioned(
        bottom:-5, 
        right: 5,
        child: Align(
          alignment: FractionalOffset.bottomRight,
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.blue[700], padding: EdgeInsets.fromLTRB(0, 0, 5, 1), alignment: Alignment.bottomRight),
            child: Container(
              width: 50,
              height: 18,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_accentColor.withAlpha(220), _accentColor.withAlpha(250), _accentColor],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  ),
                ),
              child: Text(
                'more',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue)
                ),
            ),
            onPressed: () { setState(() => _expended = !_expended); },
            ),
          ),
        )
    ); // List Add
    return Stack(children: _expended ? _widgetList : _morewidgetList);
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_getContainerHeight);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(UpdatedItemWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback(_getContainerHeight);
    super.didUpdateWidget(oldWidget);
  }
  
  _getContainerHeight(_){
    _topWidgetHeight = _topKey.currentContext.size.height;
    _expendHeight = _expendKey.currentContext.size.height;
    _expended = _expendHeight < 50;
    
    print("_topWidgetHeight >>>> $_topWidgetHeight");
    print("_expendHeight >>>> $_expendHeight");
  }
}
