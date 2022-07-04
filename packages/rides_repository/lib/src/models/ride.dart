import 'package:flutter/material.dart';

class Ride {
  String? id;
  Position start_position;
  String start_address;
  Position end_position;
  String user_id;
  TimeOfDay start_time;
  int total_spots;
  int available_spots;
  bool accept_tip;

  Ride(this.start_position, this.start_address, this.end_position, this.user_id,
      this.start_time, this.total_spots, this.available_spots, this.accept_tip);

  Ride.fromJson(this.id, Map<String, dynamic> json)
      : start_position = Position.fromJson(json['start_position']),
        start_address = json['start_address'] ?? "",
        end_position = Position.fromJson(json['end_position']),
        user_id = json['user_id'],
        start_time = TimeOfDay(
            hour: int.parse(json['start_time'].split(":")[0]),
            minute: int.parse(json['start_time'].split(":")[1])),
        total_spots = json['total_spots'],
        available_spots = json['available_spots'],
        accept_tip = json['accept_tip'];

  Map<String, dynamic> toJson() => {
        'start_position': start_position.toJson(),
        'start_address': start_address,
        'end_position': end_position.toJson(),
        'user_id': user_id,
        'start_time': "${start_time.hour}:${start_time.minute}",
        'total_spots': total_spots,
        'available_spots': available_spots,
        'accept_tip': accept_tip
      };
}

class Position {
  double latitude;
  double longitude;

  Position(this.latitude, this.longitude);

  Position.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];
  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}
