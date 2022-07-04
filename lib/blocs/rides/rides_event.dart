part of 'rides_bloc.dart';

@immutable
abstract class RidesEvent extends Equatable {
  @override
  List<Object?> get props => [];
  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

class LoadRidesEvent implements RidesEvent {
  const LoadRidesEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

class RidesReceived implements RidesEvent {
  final List<Ride> rides;
  RidesReceived(this.rides);

  @override
  // TODO: implement props
  List<Object?> get props => [rides];

  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

class AddRideEvent implements RidesEvent {
  final Ride ride;
  const AddRideEvent(this.ride);
  @override
  // TODO: implement props
  List<Object?> get props => [ride];
  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

class AcceptRide implements RidesEvent {
  final Ride ride;
  const AcceptRide(this.ride);

  @override
  // TODO: implement props
  List<Object?> get props => [ride];
  @override
  // TODO: implement stringify
  bool? get stringify => false;
}
