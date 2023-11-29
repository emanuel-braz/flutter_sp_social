import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sp_social/data/event_model.dart';

class EventStore extends ValueNotifier<EventModel?> {
  EventStore() : super(null);

  Future<void> loadEventData() async {
    final id = getEventId();
    final data = await loadJsonFromAssets(id);
    final model = EventModel.fromMap(data);
    value = model;
  }

  String getEventId() {
    final eventId =
        Uri.base.pathSegments.isEmpty ? 'default' : Uri.base.pathSegments.first;
    return eventId;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String file) async {
    String data;
    try {
      data = await rootBundle.loadString('assets/data/$file.json');
    } catch (_) {
      data = await rootBundle.loadString('assets/data/default.json');
    }

    return jsonDecode(data);
  }
}
