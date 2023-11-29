import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class SocialQrCode {
  final String title;
  final String qrCode;
  final String? icon;
  final String? color;

  const SocialQrCode(
      {required this.title, required this.qrCode, this.icon, this.color});

  factory SocialQrCode.fromMap(Map<String, dynamic> data) => SocialQrCode(
        title: data['title'] as String,
        qrCode: data['qr_code'] as String,
        icon: data['icon'] as String?,
        color: data['color'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'qr_code': qrCode,
        'icon': icon,
        'color': color,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SocialQrCode].
  factory SocialQrCode.fromJson(String data) {
    return SocialQrCode.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SocialQrCode] to a JSON string.
  String toJson() => json.encode(toMap());
}
