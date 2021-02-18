import 'package:flutter/material.dart';
import 'package:vivid/components/auth/auth_services.dart';

class ProviderAuth extends InheritedWidget {
  final AuthService auth;
  ProviderAuth({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWiddget) {
    return true;
  }

  static ProviderAuth of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ProviderAuth>());
}