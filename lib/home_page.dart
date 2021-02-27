import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_options.dart';
import 'update_apps_widget.dart';
import 'paint_page.dart';
import 'package:date_format/date_format.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  //使用控制Tabbar切换
  TabController _tabController;
  UpdatedItemModel _itemModel;
  Timer _launchTimer;
  String _dateText;

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _itemModel = UpdatedItemModel(
                  appIcon:"assets/icon.png",
                  appDescription:"Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                  appName: "Google Maps - Transit & Fond",
                  appSize: "137.2",
                  appVersion: "Version 5.19",
                  appDate: formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd, '日']),
                  descExpended: false
              );
    _dateText = formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd, '日', HH, ':', nn, ':', ss]);
    _launchTimer = Timer.periodic(
        const Duration(
          seconds: 1,
        ),
        (timer) {
          setState(() => _dateText = formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd, '日', HH, ':', nn, ':', ss]));
        },
      );
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
              UpdatedItemWidget(model: _itemModel, onPressed: () {}),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  _dateText, 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.greenAccent[400], fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              ),
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
    _launchTimer?.cancel();
    _launchTimer = null;
    super.dispose();
  }
}