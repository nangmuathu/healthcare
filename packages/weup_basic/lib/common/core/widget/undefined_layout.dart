import 'package:flutter/material.dart';
import 'package:weup_basic/common/extension/app_extension.dart';

import 'button/button_base_comp.dart';

class UndefinedLayout extends StatelessWidget {
  final String? name;

  const UndefinedLayout({this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('No page define for route: ${name ?? ''}'),
            const SizedBox(height: 15),
            ButtonBaseComp(
              onPressed: () => context.pop(),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black45,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Trở lại',
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ],
        ),
      ),
    );
  }
}
