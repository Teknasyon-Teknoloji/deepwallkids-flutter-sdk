import 'dart:async';
import 'package:flutter/material.dart';
import 'package:deepwallkids_flutter_plugin/deepwallkids_flutter_plugin.dart';
import 'package:deepwallkids_flutter_plugin/enums/environments.dart';
import 'package:deepwallkids_flutter_plugin/enums/events.dart';
// import 'package:deepwallkids_flutter_plugin/enums/environmentstyles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    late StreamSubscription streamSubscriber;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      streamSubscriber = DeepWallKidsFlutterPlugin.eventBus
          .on<DeepWallKidsFlutterEvent>()
          .listen((event) {
        print(event.event.value);
        print(event.data);
      });

      DeepWallKidsFlutterPlugin.initialize(
          'API_KEY', Environment.SANDBOX.value);

      DeepWallKidsFlutterPlugin.setUserProperties(
        'unique-device-id-here-001',
        'fr',
        'en-en',
      );

      // Future.delayed(Duration(milliseconds: 5000), () {
      //   DeepWallFlutterPlugin.closePaywall();
      // });
    } on Exception {
      print('Failed to connect deepwall.');
      streamSubscriber.cancel();
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DeepWallKids example app'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Open Paywall'),
            onPressed: () {
              DeepWallKidsFlutterPlugin.requestPaywall('AppLaunch', null);
            },
          ),
        ),
      ),
    );
  }
}
