part of 'give_ride_cubit.dart';

class GiveRideState extends Equatable {
  final GeoPoint start_location;
  final GeoPoint end_location;
  final String start_address;
  final String end_address;
  final TimeOfDay start_time;
  final int total_spots;
  final bool accepts_tip;
  final bool loading;

  const GiveRideState(
      this.start_location,
      this.end_location,
      this.start_address,
      this.end_address,
      this.start_time,
      this.total_spots,
      this.accepts_tip,
      this.loading);

  GiveRideState copyWith(
      {GeoPoint? start_location,
      GeoPoint? end_location,
      String? start_address,
      String? end_address,
      TimeOfDay? start_time,
      int? total_spots,
      bool? accepts_tip,
      bool? loading}) {
    return GiveRideState(
        start_location ?? this.start_location,
        end_location ?? this.end_location,
        start_address ?? this.start_address,
        end_address ?? this.end_address,
        start_time ?? this.start_time,
        total_spots ?? this.total_spots,
        accepts_tip != null ? accepts_tip : this.accepts_tip,
        loading != null ? loading : this.loading);
  }

  bool valid() {
    return start_location.latitude != 0 &&
        start_location.longitude != 0 &&
        end_location.latitude != 0 &&
        end_location.longitude != 0;
  }

  @override
  List<Object> get props => [
        start_location,
        end_location,
        start_address,
        end_address,
        start_time,
        total_spots,
        accepts_tip,
        loading
      ];
}
