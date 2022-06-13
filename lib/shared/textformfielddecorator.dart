import 'package:flutter/material.dart';

class TextFormFieldDecorator {
  InputDecoration getDecorator(String hint) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green)
      ),
      hintText: hint,
    );
  }
}
