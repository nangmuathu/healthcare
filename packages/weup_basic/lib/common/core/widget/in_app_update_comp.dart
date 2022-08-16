import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/widget/dialog/alert_comp.dart';

class InAppUpdate extends StatelessWidget {
  const InAppUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: AlertComp(
            isClose: false,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cập nhật ứng dụng',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18))),
                SizedBox(height: 15),
                Text(
                    'Hãy cập nhật phiên bản mới để trải nghiệm thêm nhiều tính năng hấp dẫn',
                    textAlign: TextAlign.left),
                SizedBox(height: 20),
              ],
            ),
            actions: [
              Expanded(
                child: AlertButtonComp(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  onTap: () {},
                  // color: ColorResource.bodyColor,
                  border: Border.all(color: Colors.transparent),
                  title: const Text('Cập nhật',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
