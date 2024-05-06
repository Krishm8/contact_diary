import 'package:contact_diary/controller/povider.dart';
import 'package:contact_diary/view/contactdetail.dart';
import 'package:contact_diary/view/detail.dart';
import 'package:contact_diary/view/homepage.dart';
import 'package:contact_diary/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          initialRoute: "/",
          routes: {
            "/": (context) => LoginPage(),
            "home": (context) => HomePage(),
            "detail": (context) => DetailPage(),
            "contctdetail":(context) => ContactDetailPage(),
          },
        );
      },
    );
  }
}
