import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:our_library/Firebase/storage.dart';
import 'package:our_library/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Firebase/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Storage())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
