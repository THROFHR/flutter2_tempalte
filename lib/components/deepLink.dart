import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import '../router/app_pages.dart';

class DeepLink extends StatefulWidget {
  final Widget child;
  const DeepLink({Key? key, required this.child}) : super(key: key);

  @override
  State<DeepLink> createState() => _DeepLinkState();
}

class _DeepLinkState extends State<DeepLink> {
  bool isInitialUriIsHandled = false;
  StreamSubscription? uriSub;

  @override
  void initState() {
    super.initState();
    handleInitialUri();
  }

  Future<void> handleInitialUri() async {
    // 第一次打开
    if (!isInitialUriIsHandled) {
      isInitialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        print("isInitialUriIsHandled=======");
        if (uri != null) AppPages.navigationTo(uri.path, uri.queryParameters);
      } on PlatformException {
        print('falied to get initial uri');
      } on FormatException catch (err) {
        print('malformed initial uri, ' + err.toString());
      }
    }

    if (!kIsWeb) {
      uriSub = uriLinkStream.listen((Uri? uri) {
        print("uriSub=======");
        if (uri != null) AppPages.navigationTo(uri.path, uri.queryParameters);
      }, onError: (Object err) {
        print('got err: $err');
      });
    }
  }
  @override
  void dispose() {
    uriSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
