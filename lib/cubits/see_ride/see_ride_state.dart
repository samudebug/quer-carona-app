part of 'see_ride_cubit.dart';

abstract class SeeRideState extends Equatable {
  const SeeRideState();

  @override
  List<Object> get props => [];
}

class SeeRideInitial extends SeeRideState {}

class RideShown extends SeeRideState {
  final Ride ride;
  const RideShown(this.ride);

  @override
  // TODO: implement props
  List<Object> get props => [ride];
}
