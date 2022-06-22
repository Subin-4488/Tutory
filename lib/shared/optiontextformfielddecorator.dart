import 'package:flutter/material.dart';

class OptionsDecorator {
  final Color color;
  final String label;

  OptionsDecorator({required this.color, required this.label});

  InputDecoration getOptionsDecorator() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color,width: 2.5), 
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color,width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      labelText: label,
    );
  }
}
