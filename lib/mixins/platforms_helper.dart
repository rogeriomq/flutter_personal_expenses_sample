import 'dart:io';

mixin PlatformsHelper {
  bool isApplePlatform() {
    return (Platform.isIOS || Platform.isMacOS);
  }
}
