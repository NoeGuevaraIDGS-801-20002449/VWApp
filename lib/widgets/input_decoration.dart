import 'package:flutter/material.dart';
import 'package:vwapp/tema/tema.dart';

class InputDecorations {
  static InputDecoration inputDecoration(
      {required String hintext,
      required String labeltext,
      required Icon icon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.prim),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.prim, width: 2),
        ),
        hintText: hintext,
        hintStyle: const TextStyle(color: AppTheme.cua),
        labelText: labeltext,
        labelStyle: const TextStyle(color: AppTheme.cua),
        prefixIcon: icon);
  }
}
