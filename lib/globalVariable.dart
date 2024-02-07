import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  // static final GlobalKey<NavigatorState> navState1 = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKeyDrawer = GlobalKey<ScaffoldState>();
}