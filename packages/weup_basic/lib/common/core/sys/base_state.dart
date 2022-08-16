import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../global.dart';
import '../../helper/view_utils.dart';
import 'base_function.dart';
import 'base_view_model.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> {
  VM? _viewModel;

  VM get viewModel => _viewModel!;

  double get width => ViewUtils.width;

  double get height => ViewUtils.height;

  VM get init => context.read<VM>();

  bool hasPopUp([bool val = true]) => val;

  @override
  void initState() {
    _viewModel = init;
    _viewModel?.setBuildContext(context);
    _viewModel?.init();

    Future.delayed(Duration.zero, () => _viewModel?.onViewCreated());

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      showLogState('$VM was installed ${DateTime.now()}');

      _viewModel?.setRouteSetting(ModalRoute.of(context)?.settings);
      Future.delayed(
          const Duration(milliseconds: 100), () => _viewModel?.initialData());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appStyle = Theme.of(context);
  }

  @override
  void dispose() {
    _viewModel?.onDispose();
    _viewModel = null;
    showLogState('$VM was closed');
    super.dispose();
  }
}
