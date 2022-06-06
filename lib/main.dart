import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_library/Firebase/storage.dart';
import 'package:my_library/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Firebase/auth.dart';

/* App logo : <a target="_blank" href="https://icons8.com/icon/SrXPdnV21D1k/bookshelf">Bookshelf</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Storage())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const SplashScreen(),
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (BuildContext context) => Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const SplashScreen(),
      ),
    );
  }*/
}
