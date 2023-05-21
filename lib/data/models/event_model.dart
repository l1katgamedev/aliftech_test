const tableEvents = 'events';

class DayEventFields {
  static final List<String> values = [
    id,
    name,
    description,
    location,
    colorValue,
    dateTime,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String description = 'description';
  static const String location = 'location';
  static const String colorValue = 'colorValue';
  static const String dateTime = 'dateTime';
}

class DayEvent {
  int? id;
  String name;
  String description;
  String location;
  int colorValue;
  DateTime dateTime;

  DayEvent({
    this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.colorValue,
    required this.dateTime,
  });

  DayEvent copy({
    int? id,
    String? name,
    String? description,
    String? location,
    int? colorValue,
    DateTime? dateTime,
  }) =>
      DayEvent(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        colorValue: colorValue ?? this.colorValue,
        dateTime: dateTime ?? this.dateTime,
      );

  static DayEvent fromJson(Map<String, Object?> json) => DayEvent(
        id: json[DayEventFields.id] as int,
        name: json[DayEventFields.name] as String,
        description: json[DayEventFields.description] as String,
        location: json[DayEventFields.location] as String,
        colorValue: json[DayEventFields.colorValue] as int,
        dateTime: DateTime.parse(json[DayEventFields.dateTime] as String),
      );

  Map<String, Object?> toJson() => {
        DayEventFields.id: id,
        DayEventFields.name: name,
        DayEventFields.description: description,
        DayEventFields.location: location,
        DayEventFields.colorValue: colorValue,
        DayEventFields.dateTime: dateTime.toIso8601String(),
      };
}
