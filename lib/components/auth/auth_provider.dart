import 'package:flutter/material.dart';
import 'package:vivid/components/auth/auth_services.dart';

class Provider extends InheritedWidget {
  final AuthService auth;
  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWiddget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}