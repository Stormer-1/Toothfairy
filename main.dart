import 'dart:ui';

import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initErrorHandler();
  runApp(const MyApp());
}

void initErrorHandler() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);

    print(
      "$details",
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    print(
      "Error $error \n Stack $stack",
    );
    return true;
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
