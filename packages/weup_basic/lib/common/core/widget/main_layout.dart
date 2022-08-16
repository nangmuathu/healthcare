import 'package:weup_basic/common/core/app_core.dart';
import 'package:weup_basic/common/core/sys/base_view_model.dart';
import 'package:weup_basic/common/core/widget/loading_comp.dart';
import 'package:weup_basic/common/extension/app_extension.dart';
import 'package:weup_basic/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout<T extends BaseViewModel> extends StatelessWidget {
  const MainLayout(
      {this.appBar,
      this.mustSafeView = true,
      required this.child,
      this.onClick,
      this.backgroundColor,
      Key? key})
      : super(key: key);
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Function? onClick;
  final bool? mustSafeView;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBackgroundPress(context),
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBody: true,
        appBar: appBar,
        body: mustSafeView == true
            ? SafeArea(child: _BodyLayout<T>(child: child))
            : _BodyLayout<T>(child: child),
      ),
    );
  }

  void _onBackgroundPress(BuildContext context) {
    FocusScope.of(context).unfocus();
    onClick?.call();
  }
}

class _BodyLayout<T extends BaseViewModel> extends StatelessWidget {
  const _BodyLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<T>(
          builder: (context, value, child) {
            if (value.status == Status.errorInit) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Có lỗi xảy ra',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ScaleAniButtonComp(
                          onPressed: () => context.pop(), title: 'Trở về'),
                    )
                  ],
                ),
                alignment: Alignment.center,
              );
            }
            return Visibility(
              visible: value.status == Status.loading ||
                  value.status == Status.waiting,
              // child: IndicatorComp(status: value.status),
              child: LoadingComp(status: value.status),
            );
          },
        ),
      ],
    );
  }
}
