// To parse this JSON data, do
//
//     final latestEarthquake = latestEarthquakeFromJson(jsonString);

import 'dart:convert';

class LatestEarthquake {
  final String? place;
  final double? magnitude;
  final DateTime time;
  final double? depth;
  final double? longitude;
  final double? latitude;

  LatestEarthquake({
    required this.place,
    required this.magnitude,
    required this.time,
    required this.depth,
    required this.longitude,
    required this.latitude,
  });

  LatestEarthquake copyWith({
    String? place,
    double? magnitude,
    DateTime? time,
    double? depth,
    double? longitude,
    double? latitude,
  }) =>
      LatestEarthquake(
        place: place ?? this.place,
        magnitude: magnitude ?? this.magnitude,
        time: time ?? this.time,
        depth: depth ?? this.depth,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  factory LatestEarthquake.fromRawJson(String str) =>
      LatestEarthquake.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LatestEarthquake.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }

    return LatestEarthquake(
      place: json["place"],
      magnitude: json["magnitude"].toDouble(),
      time: DateTime.parse(json["time"]),
      depth: json["depth"].toDouble(),
      longitude: json["longitude"].toDouble(),
      latitude: json["latitude"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "place": place,
        "magnitude": magnitude,
        "time": time.toIso8601String(),
        "depth": depth,
        "longitude": longitude,
        "latitude": latitude,
      };
}
