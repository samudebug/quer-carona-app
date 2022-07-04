import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rides_repository/rides_repository.dart';

part 'see_ride_state.dart';

class SeeRideCubit extends Cubit<SeeRideState> {
  SeeRideCubit() : super(SeeRideInitial());

  seeRide(Ride ride) {
    emit(RideShown(ride));
  }

  removeRide() {
    emit(SeeRideInitial());
  }
}
