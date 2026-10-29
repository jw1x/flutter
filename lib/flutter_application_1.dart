import 'package:flutter/material.dart';

import 'app/app.dart';

class FlutterApplication1 extends StatelessWidget {
  const FlutterApplication1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Каталог автомобилей',
      theme: AppTheme.lightTheme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}