import 'package:flutter/material.dart';

class TextFormFieldDecorator {
  InputDecoration getDecorator(String hint) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black)
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple)
      ),
      labelText: hint,
    );
  }
}
