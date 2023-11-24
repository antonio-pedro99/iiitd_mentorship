import 'package:flutter/widgets.dart';

enum AlertType {
  success,
  error,
  warning,
  info,
}

class Alert {
  final AlertType? type;
  final String? message;
  final String? title;
  final IconData? icon;

  Alert({this.type, this.message, this.title, this.icon});
}
