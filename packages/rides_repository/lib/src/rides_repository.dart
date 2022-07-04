import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/ride.dart';

class RidesRepository {
  final FirebaseFirestore firestore;
  late CollectionReference ridesCollection;
  RidesRepository(this.firestore) {
    ridesCollection = firestore.collection('rides');
  }

  Future<List<Ride>> getRides() async {
    return (await ridesCollection
            .where('available_spots', isGreaterThan: 0)
            .get())
        .docs
        .map((e) => Ride.fromJson(e.id, e.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> addRide(Ride ride) async {
    await ridesCollection.add(ride.toJson());
  }

  Future<void> acceptRide(Ride ride) async {
    if (ride.available_spots <= 0) {
      return;
    }
    await ridesCollection
        .doc(ride.id)
        .update({'available_spots': ride.available_spots - 1});
  }
}
