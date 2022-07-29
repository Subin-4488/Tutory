import 'dart:io';

class AdHelper {

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9832399058054749/2412581087";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}