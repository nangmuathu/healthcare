import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weup_basic/common/core/widget/will_pop_exit_comp.dart';

import '../../resource/lottie_resource.dart';

class MaintenanceComp extends StatelessWidget {
  final String? message;

  const MaintenanceComp({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopExitComp(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Lottie.asset(LottieResource.maintenance,
                        width: MediaQuery.of(context).size.width / 1.5)),
                const SizedBox(height: 25),
                Text(message ?? 'Hệ thống đang nâng cấp',
                    style: const TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
