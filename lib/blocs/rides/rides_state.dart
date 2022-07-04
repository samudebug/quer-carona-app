part of 'rides_bloc.dart';

@immutable
abstract class RidesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

class RidesInitial extends RidesState {}

class RidesLoading extends RidesState {}

class RidesLoaded extends RidesState {
  final List<Ride> rides;
  RidesLoaded(this.rides);
}
