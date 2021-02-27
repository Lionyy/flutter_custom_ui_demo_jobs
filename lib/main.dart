import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';
import 'app_options.dart';
import 'app_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.isTestMode = false,
  }) : super(key: key);

  final bool isTestMode;

  @override
  Widget build(BuildContext context) => ModelBinding(
      initialModel: AppOptions(
        themeMode: ThemeMode.system,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            restorationScopeId: 'rootApp',
            title: 'Flutter Test App',
            themeMode: AppOptions.of(context).themeMode,
            theme: AppThemeData.lightThemeData,
            darkTheme: AppThemeData.darkThemeData,
            home: MyHomePage(title: 'Custom UI'),
          );
        },
      ),
    );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  //使用控制Tabbar切换
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final _options = AppOptions.of(context);
    Color _primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.title),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.system_update),text: "组合"),
            Tab(icon: Icon(Icons.pie_chart),text: "自绘")
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            children: <Widget>[
              UpdatedItemWidget(model: UpdatedItemModel(
                  appIcon:"assets/icon.png",
                  appDescription:"Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                  appName: "Google Maps - Transit & Fond",
                  appSize: "137.2",
                  appVersion: "Version 5.19",
                  appDate: "2019年6月5日"
              ), onPressed: () {},
              )
            ],
          ),
          Center(child: Cake())
        ],
      ),
      floatingActionButton: ElevatedButton(
        child: Text(_options.systemBrightness() == Brightness.light ? 'Dark' : 'Light') ,
        style: TextButton.styleFrom(primary: Colors.white, padding: EdgeInsets.all(20), backgroundColor: _primaryColor, shape: CircleBorder()),
        onPressed: () => AppOptions.update( 
          context, 
          _options.copyWith(themeMode: _options.systemBrightness() == Brightness.light ? ThemeMode.dark : ThemeMode.light)
          )),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class UpdatedItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;
  UpdatedItemModel({this.appIcon, this.appName, this.appSize, this.appDate, this.appDescription, this.appVersion});
}

class Cake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(),
    );
  }
}

class WheelPainter extends CustomPainter {
  //设置画笔颜色
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //饼图尺寸
    double wheelSize = min(size.width, size.height)/2;
    double nbElem = 6;
    double radius = (2 * pi) / nbElem;
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    //画圆弧，每次1/6个圆弧
    canvas.drawArc(boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(boundingRect, radius, radius, true, getColoredPaint(Colors.black38));
    canvas.drawArc(boundingRect, radius * 2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(boundingRect, radius * 3, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(boundingRect, radius * 4, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(boundingRect, radius * 5, radius, true, getColoredPaint(Colors.pink));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
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
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onPressed: () { setState(() => _expended = !_expended); },
          ),
          ),
          ));
      
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
}

