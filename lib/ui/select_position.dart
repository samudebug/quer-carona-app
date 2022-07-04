import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class SelectPositionPage extends StatelessWidget implements OSMMixinObserver {
  SelectPositionPage({Key? key}) : super(key: key);
  MapController controller = MapController(
    initMapWithUserPosition: true,
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  @override
  Widget build(BuildContext context) {
    controller.addObserver(this);
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Column(
          children: [
            Flexible(
              child: OSMFlutter(
                controller: controller,
                trackMyPosition: false,
                initZoom: 12,
                minZoomLevel: 2,
                roadConfiguration: RoadConfiguration(
                  startIcon: const MarkerIcon(
                    icon: Icon(
                      Icons.person,
                      size: 64,
                      color: Colors.brown,
                    ),
                  ),
                  roadColor: Colors.yellowAccent,
                ),
              ),
              flex: 8,
            ),
            Flexible(
                child: ElevatedButton(
              child: Text("Select"),
              onPressed: () async {
                GeoPoint p =
                    await controller.getCurrentPositionAdvancedPositionPicker();
                Navigator.of(context).pop(p);
              },
            ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(25)),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              iconSize: 24,
            ),
          ),
        ),
      ]),
    ));
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    await controller.advancedPositionPicker();
  }

  @override
  Future<void> mapRestored() async {
    print("restored");
  }
}
