import 'package:flutter/material.dart';

class MenuOption {
  final String router;
  final IconData icon;
  final String name;
  final VoidCallback? onPressed;

  MenuOption(
      {required this.router,
      required this.icon,
      required this.name,
      this.onPressed});
}
