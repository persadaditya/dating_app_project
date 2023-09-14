import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntExt on int?{
  String get toCommaSeparated{
    if(this==null) return '';
    var f = NumberFormat("###,###", "en_US");

    return f.format(this);
  }

}

LinearGradient cardGradient = const LinearGradient(
    colors: [
      Colors.black87,
      Colors.black54,
      Colors.black54,
      Colors.black54,
      Colors.black38,
      Colors.black26,
      Colors.black12,
      Colors.black12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
      Colors.white12,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.center
);