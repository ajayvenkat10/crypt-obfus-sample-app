import 'package:flutter/foundation.dart';

class Api {
  static String get getCreditCard {
    if (kReleaseMode) {
      return 'http://federal-creditcard.gonuclei.com/api/credit-card/dashboard/cardDetails';
    } else {
      return 'http://federal-creditcard.gonuclei.com/api/credit-card/dashboard/cardDetails';
    }
  }
}
