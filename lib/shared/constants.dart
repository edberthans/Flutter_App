import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white30,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.greenAccent,
      width: 1,
    ),
  ),
);

const formInputDecoration = InputDecoration(
  fillColor: Colors.white30,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.amberAccent,
      width: 0.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.greenAccent,
      width: 0.5,
    ),
  ),
  labelStyle: TextStyle(
    color: Colors.deepOrange,
    letterSpacing: 2,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),

);
