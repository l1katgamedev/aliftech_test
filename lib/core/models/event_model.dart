import 'package:flutter/material.dart';

class EventModel {
  final int id;
  final String name;
  final String description;
  final String location;
  final Color color;
  final DateTime datetime;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.color,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'color': color.value,
      'datetime': datetime.toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      location: map['location'],
      color: Color(map['color']),
      datetime: DateTime.parse(map['datetime']),
    );
  }
}
