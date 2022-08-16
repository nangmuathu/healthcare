// import 'package:flutter/cupertino.dart';
// import 'package:weup_basic/common/core/page_manager/push_page_builder.dart';
// import 'package:weup_basic/common/core/page_manager/route_path.dart';

// import '../sys/base_function.dart';
// import '../widget/undefined_layout.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   Widget page;
//   String? routeName = settings.name?.split('?').first;

//   switch (routeName) {
//     case RoutePath.INITIAL:
//       page = const SizedBox();
//       break;
//     default:
//       page = UndefinedLayout(
//         name: settings.name,
//       );
//       break;
//   }
//   showLogState('Page: $page | RoutePath: ${settings.name} ');

//   return PushPageBuilder.pushCupertinoPageBuilder(settings, page);
// }
