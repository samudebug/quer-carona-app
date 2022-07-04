import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:quer_carona/blocs/rides/rides_bloc.dart';
import 'package:quer_carona/cubits/see_ride/see_ride_cubit.dart';
import 'package:quer_carona/ui/widgets/ride_description.dart';
import 'package:quer_carona/ui/widgets/ride_item.dart';

class SeeRides extends StatelessWidget {
  SeeRides({Key? key}) : super(key: key);

  MapController controller = MapController(
    initMapWithUserPosition: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<RidesBloc, RidesState>(
        builder: (context, state) {
          if (state is RidesInitial) {
            context.read<RidesBloc>().add(LoadRidesEvent());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RidesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RidesLoaded) {
            return BlocProvider(
              create: (context) => SeeRideCubit(),
              child: BlocBuilder<SeeRideCubit, SeeRideState>(
                builder: (context, seeRideState) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Flexible(
                            child: OSMFlutter(
                              controller: controller,
                              trackMyPosition: true,
                              initZoom: 12,
                              minZoomLevel: 2,
                              onMapIsReady: (mapIsReady) {
                                state.rides.forEach((element) {
                                  controller.addMarker(
                                    GeoPoint(
                                        latitude:
                                            element.start_position.latitude,
                                        longitude:
                                            element.start_position.longitude),
                                  );
                                });
                              },
                            ),
                            flex: 1,
                          ),
                          Flexible(child: Builder(builder: (context) {
                            if (seeRideState is SeeRideInitial) {
                              return ListView.builder(
                                  itemCount: state.rides.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        (await controller.geopoints)
                                            .forEach((element) {
                                          controller.removeMarker(element);
                                        });
                                        await controller.drawRoad(
                                          GeoPoint(
                                              latitude: state.rides[index]
                                                  .start_position.latitude,
                                              longitude: state.rides[index]
                                                  .start_position.longitude),
                                          GeoPoint(
                                              latitude: state.rides[index]
                                                  .end_position.latitude,
                                              longitude: state.rides[index]
                                                  .end_position.longitude),
                                          roadType: RoadType.car,
                                          roadOption: RoadOption(
                                            roadWidth: 10,
                                            zoomInto: true,
                                            showMarkerOfPOI: true,
                                          ),
                                        );
                                        context
                                            .read<SeeRideCubit>()
                                            .seeRide(state.rides[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RideItem(state.rides[index]),
                                      ),
                                    );
                                  });
                            }
                            if (seeRideState is RideShown) {
                              return RideDescription(seeRideState.ride,
                                  () async {
                                await controller.removeLastRoad();
                                state.rides.forEach((element) async {
                                  await controller.addMarker(
                                    GeoPoint(
                                        latitude:
                                            element.start_position.latitude,
                                        longitude:
                                            element.start_position.longitude),
                                  );
                                });
                                context.read<SeeRideCubit>().removeRide();
                                const snackBar = SnackBar(
                                  content: Text('Carona Aceita!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                context
                                    .read<RidesBloc>()
                                    .add(AcceptRide(seeRideState.ride));
                              });
                            }
                            return Container();
                          }))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25)),
                          child: IconButton(
                            onPressed: () async {
                              if (seeRideState is RideShown) {
                                await controller.removeLastRoad();
                                state.rides.forEach((element) async {
                                  await controller.addMarker(
                                    GeoPoint(
                                        latitude:
                                            element.start_position.latitude,
                                        longitude:
                                            element.start_position.longitude),
                                  );
                                });
                                context.read<SeeRideCubit>().removeRide();
                                return;
                              }
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            iconSize: 24,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    ));
  }
}
