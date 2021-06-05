import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField(this.label, this.type, this.controller);
  final String label;
  final controller;
  final type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          validator: (str) {
            if (str!.isEmpty) {
              return "Required";
            }
            return null;
          },
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
