import 'package:timeago/timeago.dart' as time_ago;

import 'custom_message_ago.dart';

class TimeAgoUtils {
  TimeAgoUtils._internal();

  static TimeAgoUtils get instance => TimeAgoUtils._internal();

  String ago(DateTime date,
      {String? locale,
      DateTime? clock,
      bool? allowFromNow,
      bool hasShort = true}) {
    time_ago.setLocaleMessages('de', time_ago.DeMessages());
    time_ago.setLocaleMessages('dv', time_ago.DvMessages());
    time_ago.setLocaleMessages('dv_short', time_ago.DvShortMessages());
    time_ago.setLocaleMessages('fr', time_ago.FrMessages());
    time_ago.setLocaleMessages('fr_short', time_ago.FrShortMessages());
    time_ago.setLocaleMessages('ca', time_ago.CaMessages());
    time_ago.setLocaleMessages('ca_short', time_ago.CaShortMessages());
    time_ago.setLocaleMessages('ja', time_ago.JaMessages());
    time_ago.setLocaleMessages('km', time_ago.KmMessages());
    time_ago.setLocaleMessages('km_short', time_ago.KmShortMessages());
    time_ago.setLocaleMessages('id', time_ago.IdMessages());
    time_ago.setLocaleMessages('pt_BR', time_ago.PtBrMessages());
    time_ago.setLocaleMessages('pt_BR_short', time_ago.PtBrShortMessages());
    time_ago.setLocaleMessages('zh_CN', time_ago.ZhCnMessages());
    time_ago.setLocaleMessages('zh', time_ago.ZhMessages());
    time_ago.setLocaleMessages('it', time_ago.ItMessages());
    time_ago.setLocaleMessages('it_short', time_ago.ItShortMessages());
    time_ago.setLocaleMessages('fa', time_ago.FaMessages());
    time_ago.setLocaleMessages('ru', time_ago.RuMessages());
    time_ago.setLocaleMessages('tr', time_ago.TrMessages());
    time_ago.setLocaleMessages('pl', time_ago.PlMessages());
    time_ago.setLocaleMessages('th', time_ago.ThMessages());
    time_ago.setLocaleMessages('th_short', time_ago.ThShortMessages());
    time_ago.setLocaleMessages('nb_NO', time_ago.NbNoMessages());
    time_ago.setLocaleMessages('nb_NO_short', time_ago.NbNoShortMessages());
    time_ago.setLocaleMessages('nn_NO', time_ago.NnNoMessages());
    time_ago.setLocaleMessages('nn_NO_short', time_ago.NnNoShortMessages());
    time_ago.setLocaleMessages('ku', time_ago.KuMessages());
    time_ago.setLocaleMessages('ku_short', time_ago.KuShortMessages());
    time_ago.setLocaleMessages('ar', time_ago.ArMessages());
    time_ago.setLocaleMessages('ar_short', time_ago.ArShortMessages());
    time_ago.setLocaleMessages('ko', time_ago.KoMessages());
    time_ago.setLocaleMessages('vi', CustomViMessages(hasShort));
    time_ago.setLocaleMessages('vi_short', CustomViShortMessages());
    time_ago.setLocaleMessages('ta', time_ago.TaMessages());
    time_ago.setLocaleMessages('ro', time_ago.RoMessages());
    time_ago.setLocaleMessages('ro_short', time_ago.RoShortMessages());
    time_ago.setLocaleMessages('sv', time_ago.SvMessages());
    time_ago.setLocaleMessages('sv_short', time_ago.SvShortMessages());
    return time_ago.format(date,
        locale: locale, clock: clock, allowFromNow: allowFromNow ?? false);
  }
}
