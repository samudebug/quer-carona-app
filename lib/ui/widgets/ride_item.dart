import 'package:flutter/material.dart';
import 'package:rides_repository/rides_repository.dart';

class RideItem extends StatelessWidget {
  final Ride ride;

  const RideItem(this.ride, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellowAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Destino"),
                Text(
                  ride.start_address,
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Column(
              children: [
                Text("Saída"),
                Text(
                  ride.start_time.format(context),
                  style: TextStyle(fontSize: 25),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
