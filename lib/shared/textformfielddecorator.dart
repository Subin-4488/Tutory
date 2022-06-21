import 'package:flutter/material.dart';

class TextFormFieldDecorator {
  InputDecoration getDecorator(String hint) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple)
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green)
      ),
      labelText: hint,
    );
  }
}
