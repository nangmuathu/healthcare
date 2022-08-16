import 'dart:async';
import 'package:weup_basic/common/helper/time_ago/time_ago_utils.dart';
import 'package:flutter/material.dart';

class TimeAgoComp extends StatefulWidget {
  final DateTime dateTime;
  final bool hasShort;
  final bool isFull;
  final int maxLine;
  final TextStyle? style;

  const TimeAgoComp(this.dateTime,
      {Key? key,
      this.hasShort = false,
      this.maxLine = 2,
      this.style,
      this.isFull = false})
      : super(key: key);

  @override
  State<TimeAgoComp> createState() => _TimeAgoCompState();
}

class _TimeAgoCompState extends State<TimeAgoComp> {
  late Timer timer;
  final Duration _oneSec = const Duration(seconds: 1);
  Locale get _locale => Localizations.localeOf(context);

  @override
  void initState() {
    timer = Timer.periodic(_oneSec, (timer) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _time = TimeAgoUtils.instance.ago(widget.dateTime,
        locale: '${_locale.languageCode}${widget.hasShort ? '_short' : ''}',
        hasShort: widget.isFull);
    return Text(_time, maxLines: widget.maxLine, style: widget.style);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
