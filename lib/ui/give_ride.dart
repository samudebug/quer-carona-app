import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:quer_carona/blocs/rides/rides_bloc.dart';
import 'package:quer_carona/cubits/give_ride/give_ride_cubit.dart';
import 'package:quer_carona/ui/select_position.dart';
import 'package:rides_repository/rides_repository.dart';

class GiveRidePage extends StatelessWidget {
  const GiveRidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => GiveRideCubit(),
            child: BlocBuilder<GiveRideCubit, GiveRideState>(
              builder: (context, state) {
                return Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 24,
                        ),
                        const FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              "Dar Carona",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Ponto de Encontro"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          GeoPoint? location = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SelectPositionPage()));
                          if (location != null) {
                            context
                                .read<GiveRideCubit>()
                                .updateStartLocation(location);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Marcar no mapa",
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15),
                            ),
                            Icon(
                              Icons.pin_drop,
                              color: Colors.yellowAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        state.start_address,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Ponto Final"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          GeoPoint? location = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SelectPositionPage()));
                          if (location != null) {
                            context
                                .read<GiveRideCubit>()
                                .updateEndLocation(location);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Marcar no mapa",
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15),
                            ),
                            Icon(
                              Icons.pin_drop,
                              color: Colors.yellowAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        state.end_address,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              context
                                  .read<GiveRideCubit>()
                                  .openTimePicker(context);
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Horário de Inicio",
                                    textAlign: TextAlign.start,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        label: Text("Toqur aqui")),
                                    controller: context
                                        .read<GiveRideCubit>()
                                        .timeController,
                                  )
                                ]),
                          )),
                          Expanded(
                            child: TextFormField(
                                onChanged: context
                                    .read<GiveRideCubit>()
                                    .updateAvailableSpots,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Ex:2, 4",
                                  label: Text(
                                    "Vagas disponíveis",
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Receber ajuda de custo?"),
                          Switch(
                              value: state.accepts_tip,
                              onChanged: (value) {
                                print(value.runtimeType);
                                context
                                    .read<GiveRideCubit>()
                                    .updateTipOption(value);
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Ride? ride =
                              context.read<GiveRideCubit>().mountRide();
                          if (ride != null) {
                            context.read<RidesBloc>().add(AddRideEvent(ride));
                            const snackBar = SnackBar(
                              content: Text('Carona adicionada!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context).pop();
                          }
                        },
                        child: state.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text("Oferecer Carona"),
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                      ),
                    )
                  ],
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
