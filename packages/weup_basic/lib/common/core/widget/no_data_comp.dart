import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataComp extends StatelessWidget {
  final Widget? icon;
  final dynamic msg;
  final Color? color;
  const NoDataComp({Key? key, this.icon, this.msg, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null) ...[
            icon!,
            const SizedBox(height: 10),
          ],
          msg is Widget ? msg : Text(msg ?? 'Không có dữ liệu'),
        ],
      ),
    );
  }
}
