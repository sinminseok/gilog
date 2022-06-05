import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class Event {
  String? eid;
  final String? title;
  final String? description;
  final DateTime? from;
  final DateTime? to;
  final Color? backgroundColor;
  final bool? isAllDay;

  Event({
    this.eid,
    this.title,
    this.description,
    this.from,
    this.to,
    this.backgroundColor,
    this.isAllDay = false,
  });

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return new Event(eid: parsedJson['eid'] ?? '', title: parsedJson['title'] ?? '', description: parsedJson['description'] ?? '', from: parsedJson['from'].toDate(), to: parsedJson['to'].toDate(), backgroundColor: HexColor.fromHex(parsedJson['backgroundColor']) ?? Colors.red, isAllDay: parsedJson['isAllDay'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'eid': this.eid,
      'title': this.title,
      'description': this.description,
      'from': this.from,
      'to': this.to,
      'backgroundColor': this.backgroundColor?.toHex(),
      'isAllDay': this.isAllDay,
    };
  }
}

