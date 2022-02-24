import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:store_launcher/store_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            launchApp();
          },
          child: Text("Tap"),
        ),
      ),
    );
  }

  Future<void> launchApp() async {
    // android
    // https://play.google.com/store/apps/details?id=org.geometerplus.zlibrary.ui.android
    // ios
    // https://apps.apple.com/us/developer/ebooks-com-limited/id663571548
    // url
    // http://moraribapuapp.com/ebook/android_english/android_english1591871263.epub
    // http://moraribapuapp.com/ebook/android_english/android_english/1591871263.epub
    // http://moraribapuapp.com/ebook/android_english/1591871263.epub

    print("ebookTap");
    String url =
        "https://moraribapuapp.com/ebook/android_english/android_english1591871263.epub";
    print(url);
    if (url.contains(".epub")) {
      print("1");
      if (Platform.isIOS) {
        print("2");
        try {
          print("3");
          var isInstalled =
              await AppAvailability.checkAvailability('id663571548');
          print(isInstalled);
          _launchURL(url);
        } catch (e) {
          print("4");
          print(e);
          openWithStore("id663571548");
        }
      } else {
        print("5");
        try {
          print("6");
          var isInstalled = await AppAvailability.checkAvailability(
              "org.geometerplus.zlibrary.ui.android");
          print(isInstalled);
          _launchURL(url);
        } catch (e) {
          print("7");
          print(e);
          _launchURL(
              "https://play.google.com/store/apps/details?id=org.geometerplus.zlibrary.ui.android");
        }
      }
    } else {
      print("8");
      _launchURL(url);
    }
  }

  void _launchURL(String url) async {
    print("_launchURL");
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Future<void> openWithStore(String appId) async {
    print("openWithStore");
    print('app id: $appId');
    try {
      StoreLauncher.openWithStore(appId).catchError((e) {
        print('ERROR> $e');
      });
    } on Exception catch (e) {
      print('$e');
    }
  }
}
