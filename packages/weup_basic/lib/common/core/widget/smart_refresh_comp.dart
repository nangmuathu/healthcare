import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../app/app_config.dart';
import '../../../global.dart';
import '../sys/base_refresh_controller.dart';
import 'loading_comp.dart';

//pull_to_refresh: ^2.0.0
class BaseSmartRefresh extends StatelessWidget {
  final BaseRefreshController? controller;
  final Widget? child;
  final EdgeInsets? padding;
  final Widget? header;
  final Widget? footer;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final bool? isGrid;
  final bool? enablePullDown;
  final bool? enablePullUp;
  final Function? onLoading;
  final Function? onRefresh;
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final ScrollPhysics? physics;
  final int? itemCount;
  final Widget? noData;

  const BaseSmartRefresh({
    this.controller,
    this.child,
    this.padding,
    this.itemBuilder,
    this.header,
    this.footer,
    this.enablePullDown,
    this.enablePullUp,
    this.onLoading,
    this.onRefresh,
    this.physics,
    this.isGrid = false,
    this.itemCount,
    this.noData,
    Key? key,
    this.separatorBuilder,
    this.crossAxisCount,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        itemCount == 0
            ? noData ??
                Center(
                  child: Text(
                    'Chưa có dữ liệu',
                    style: appStyle.textTheme.bodyText1,
                  ),
                )
            : const SizedBox(width: 0, height: 0),
        SmartRefresher(
          controller: controller!.controller,
          child: child ??
              ((isGrid ?? false)
                  ? GridView.builder(
                      padding: padding,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount ?? 0,
                        childAspectRatio: childAspectRatio ?? 1,
                        crossAxisSpacing: crossAxisSpacing ?? 1,
                        mainAxisSpacing: mainAxisSpacing ?? 0,
                      ),
                      itemBuilder:
                          itemBuilder ?? (context, index) => const SizedBox(),
                      itemCount: itemCount ?? 0,
                    )
                  : ListView.separated(
                      padding: padding,
                      itemCount: itemCount ?? 0,
                      itemBuilder:
                          itemBuilder ?? (context, index) => const SizedBox(),
                      separatorBuilder: separatorBuilder ??
                          (BuildContext context, int index) =>
                              const SizedBox.shrink(),
                    )),
          enablePullDown: enablePullDown ?? true,
          enablePullUp:
              controller?.getEndPoint ?? false ? false : enablePullUp ?? true,
          header: header,
          footer: footer ??
              ClassicFooter(
                loadingText: 'Đang tải',
                canLoadingText: '',
                idleText: '',
                noDataText: '',
                idleIcon: const SizedBox(width: 0, height: 0),
                loadingIcon: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator()
                        : CircularProgressIndicator(
                            strokeWidth: 2.0, color: appStyle.primaryColor)),
              ),
          // onRefresh: () async => await controller?.refreshData() ?? onRefresh?.call(),
          onRefresh: () {
            controller?.refreshData.call();
            controller?.refreshed();
          },
          onLoading: () async =>
              await controller?.loadMoreData() ?? onLoading?.call(),
          physics: physics,
        ),
      ],
    );
  }
}

class NoFooter extends ClassicFooter {
  const NoFooter({Key? key})
      : super(
            key: key,
            height: 0,
            loadingText: '',
            loadingIcon: const SizedBox.shrink(),
            canLoadingIcon: const SizedBox.shrink(),
            canLoadingText: '',
            noDataText: '',
            noMoreIcon: const SizedBox.shrink());
}

class CustomWaterDropHeader extends WaterDropHeader {
  CustomWaterDropHeader({Key? key})
      : super(
          key: key,
          complete: const SizedBox.shrink(),
          completeDuration: Duration.zero,
          failed: const SizedBox.shrink(),
          refresh: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const LoadingComp(hasColor: false, width: 25),
                const SizedBox(width: AppConfigs.padding),
                const Text('Đang tải', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          // waterDropColor: Colors.transparent,
        );
}
