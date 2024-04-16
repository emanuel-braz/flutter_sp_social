import 'dart:convert';

import 'package:flutter/material.dart';

import 'social_qr_code.dart';

@immutable
class EventModel {
  final String eventName;
  final String eventDate;
  final String? color;
  final List<SocialQrCode> socialQrCodes;
  final bool isCarouselView;

  const EventModel({
    required this.eventName,
    required this.eventDate,
    this.color,
    this.socialQrCodes = const [],
    this.isCarouselView = false,
  });

  factory EventModel.fromMap(Map<String, dynamic> data) => EventModel(
        eventName: data['eventName'] as String,
        eventDate: data['eventDate'] as String,
        color: data['color'] as String?,
        socialQrCodes: (data['social_qr_codes'] as List<dynamic>?)
                ?.map((e) => SocialQrCode.fromMap(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
        'eventName': eventName,
        'eventDate': eventDate,
        'color': color,
        'social_qr_codes': socialQrCodes.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EventModel].
  factory EventModel.fromJson(String data) {
    return EventModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EventModel] to a JSON string.
  String toJson() => json.encode(toMap());

  EventModel copyWith({
    String? eventName,
    String? eventDate,
    String? color,
    List<SocialQrCode>? socialQrCodes,
    bool? isCarouselView,
  }) {
    return EventModel(
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      color: color ?? this.color,
      socialQrCodes: socialQrCodes ?? this.socialQrCodes,
      isCarouselView: isCarouselView ?? this.isCarouselView,
    );
  }
}
