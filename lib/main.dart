import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


String url = 'https://jsonplaceholder.typicode.com/posts';
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(
    PlatformApp(
        debugShowCheckedModeBanner: true,
        home: Item()),
  );
}

abstract class PlatformWidget <C extends Widget, M extends Widget> extends StatelessWidget
{
   PlatformWidget({Key key}) : super(key: key);

   C buildCupertinoWidget(BuildContext context);
   M buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupertinoWidget(context);
    }else
      {
        return buildMaterialWidget(context);
  }
}
}