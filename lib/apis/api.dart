import 'package:flutter/foundation.dart';

class Api {
  static String get getCreditCard {
    if (kReleaseMode) {
      return 'http://federal-creditcard.gonuclei.com/api';
    } else {
      return 'http://federal-creditcard.gonuclei.com/api';
    }
  }

  static String get getPath{
    if (kReleaseMode) {
      return '/credit-card/dashboard/cardDetails';
    } else {
      return '/credit-card/dashboard/cardDetails';
    }
  }
}
