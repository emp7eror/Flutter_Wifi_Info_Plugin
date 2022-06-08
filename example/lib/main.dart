import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WifiInfoWrapper? wifiObject;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
     WifiInfoWrapper? tempWifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      tempWifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;
    if (tempWifiObject != null) {
      setState(() {
        wifiObject = tempWifiObject;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String ipAddress =
        wifiObject != null ? wifiObject!.ipAddress.toString() : "ip";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on:' + ipAddress),
        ),
      ),
    );
  }
}
