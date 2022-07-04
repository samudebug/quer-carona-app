import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meta/meta.dart';
import 'package:rides_repository/rides_repository.dart';

part 'rides_event.dart';
part 'rides_state.dart';

class RidesBloc extends Bloc<RidesEvent, RidesState> {
  final RidesRepository repository;

  RidesBloc(this.repository) : super(RidesInitial()) {
    on<LoadRidesEvent>((event, emit) {
      repository.getRides().then((value) => add(RidesReceived(value)));
      emit(RidesLoading());
    });
    on<RidesReceived>((event, emit) {
      emit(RidesLoaded(event.rides));
    });
    on<AddRideEvent>((event, emit) {
      repository.addRide(event.ride);
      emit(state);
    });
    on<AcceptRide>((event, emit) {
      repository.acceptRide(event.ride).then((_) {
        add(LoadRidesEvent());
      });
    });
  }
}
