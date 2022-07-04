import 'package:flutter/material.dart';
import 'package:rides_repository/rides_repository.dart';

class RideDescription extends StatelessWidget {
  final Ride ride;
  final Function() acceptRide;
  const RideDescription(this.ride, this.acceptRide, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                child: Text(
                  "Ponto de Encontro",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(8),
              ),
              Padding(
                child: Text(ride.start_address, style: TextStyle(fontSize: 18)),
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                child: Text(
                  "Ponto de Destino",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(8),
              ),
              Padding(
                child: Text("Endereço", style: TextStyle(fontSize: 18)),
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    child: Text(
                      "Horário de Saída",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  Padding(
                    child: Text(ride.start_time.format(context),
                        style: TextStyle(fontSize: 18)),
                    padding: EdgeInsets.all(8),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    child: Text(
                      "Vagas Disponiveis",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  Padding(
                    child: Text(ride.available_spots.toString(),
                        style: TextStyle(fontSize: 18)),
                    padding: EdgeInsets.all(8),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                child: Text(
                  "Aceita Gorjeta",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(8),
              ),
              Padding(
                child: Text(
                  ride.accept_tip ? "Sim" : "Não",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
          ElevatedButton(onPressed: acceptRide, child: Text("Aceitar"))
        ],
      ),
    );
  }
}
