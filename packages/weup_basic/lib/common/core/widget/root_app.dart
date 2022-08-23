import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  final Widget child;
  const RootApp({Key? key, required this.child}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();

  static reload(BuildContext context) {
    context.findAncestorStateOfType<_RootAppState>()!.restartApp();
  }
}

class _RootAppState extends State<RootApp> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
