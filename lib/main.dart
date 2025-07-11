
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_deliver/firebase_options.dart';
import 'package:quick_deliver/router.dart';
import 'package:quick_deliver/services.dart/notification_service.dart';
import 'package:quick_deliver/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
   await NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      routerConfig: router,
      
    );
  }
}



