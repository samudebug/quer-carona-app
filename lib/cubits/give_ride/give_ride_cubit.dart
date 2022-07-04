import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rides_repository/rides_repository.dart';

part 'give_ride_state.dart';

class GiveRideCubit extends Cubit<GiveRideState> {
  final timeController = TextEditingController(text: "12:00");
  GiveRideCubit()
      : super(GiveRideState(
            GeoPoint(latitude: 0, longitude: 0),
            GeoPoint(latitude: 0, longitude: 0),
            "",
            "",
            const TimeOfDay(hour: 0, minute: 0),
            0,
            false,
            false)) {
    timeController.text =
        "${state.start_time.hourOfPeriod.toString().padLeft(2, '0')} : ${state.start_time.minute.toString().padLeft(2, '0')} ${state.start_time.period == DayPeriod.am ? 'AM' : 'PM'}";
  }

  updateStartLocation(value) async {
    emit(state.copyWith(start_location: value));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(value.latitude, value.longitude);
    var first = placemarks[0];
    emit(state.copyWith(
        start_address: "${first.street}, ${first.subThoroughfare}"));
  }

  updateEndLocation(value) async {
    emit(state.copyWith(end_location: value));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(value.latitude, value.longitude);
    var first = placemarks[0];
    print("${first.street}, ${first.subThoroughfare}");
    emit(state.copyWith(
        end_address: "${first.street}, ${first.subThoroughfare}"));
  }

  openTimePicker(context) async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    emit(state.copyWith(start_time: selectedTime));
    if (selectedTime != null) {
      timeController.text =
          "${state.start_time.hourOfPeriod.toString().padLeft(2, '0')} : ${state.start_time.minute.toString().padLeft(2, '0')} ${state.start_time.period == DayPeriod.am ? 'AM' : 'PM'}";
    }
  }

  updateAvailableSpots(value) async {
    emit(state.copyWith(total_spots: int.parse(value)));
  }

  updateTipOption(value) async {
    emit(state.copyWith(accepts_tip: value));
  }

  updateLoading() {
    emit(state.copyWith(loading: !state.loading));
  }

  Ride? mountRide() {
    if (state.valid()) {
      return Ride(
          Position(
              state.start_location.latitude, state.start_location.longitude),
          state.start_address,
          Position(state.end_location.latitude, state.end_location.longitude),
          "a",
          state.start_time,
          state.total_spots,
          state.total_spots,
          state.accepts_tip);
    }
  }
}
