import 'package:elderlinkz/classes/notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

late SharedPreferences prefs;
  
late TabController tabController;

late NotificationService notif;

late WebViewController controller;