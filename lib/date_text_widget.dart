import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class DateText extends StatefulWidget {
  @override
  _DateTextState createState() => _DateTextState();
}

class _DateTextState extends State<DateText> {
  Timer _displayTimer;
  String _dateText;

  @override
  void initState() { 
    super.initState();
    _dateText = formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd, '日', HH, ':', nn, ':', ss]);
    _displayTimer = Timer.periodic(
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
    final _colorScheme = Theme.of(context).colorScheme;
    return Text(
      _dateText, 
      textAlign: TextAlign.center,
      style: TextStyle(color: _colorScheme.primaryVariant, fontSize: 20, fontWeight: FontWeight.bold),
      );
  }

  @override
  void dispose() {
    _displayTimer?.cancel();
    _displayTimer = null;
    super.dispose();
  }
}