import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps_example/drawer.dart';

enum DialogResult { YES, NO }

class MapMarkersPage extends StatefulWidget {
  static const String route = 'map_markers';

  @override
  State<StatefulWidget> createState() => _MapMarkersPageState();
}

class _MapMarkersPageState extends State<MapMarkersPage> {
  Completer<HereMapsController> _controller = Completer();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setMapMarker(Coordinate coordinate) async {
    final map = await _controller.future;
    await map
        .setMapObject(MapObject()
          ..uniqueId = "Marker"
          ..marker = (MapMarker()
            ..coordinate = coordinate
            ..image = "assets/pin.png"))
        .then((value) => map.setCenter(MapCenter()
          ..coordinate = coordinate
          ..zoomLevel = (FloatValue()..value = 14.0)));
  }

  final latController = TextEditingController();
  final lngController = TextEditingController();

  Future<Coordinate> _showLocationsDialog() async {
    switch (await showDialog<DialogResult>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialog(
              title: Text("Set lat and lng"),
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: "lat"),
                  controller: latController,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: "lng"),
                  controller: lngController,
                ),
                SimpleDialogOption(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, DialogResult.YES),
                ),
                SimpleDialogOption(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, DialogResult.NO),
                )
              ],
            ),
          );
        })) {
      case DialogResult.YES:
        return Coordinate()
          ..lat = 32.086905
          ..lng = 34.789741;
        break;
      case DialogResult.NO:
        return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: buildDrawer(context, MapMarkersPage.route),
        appBar: AppBar(
          title: const Text('Map Markers'),
        ),
        body: MapView(
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showLocationsDialog()
              .then((coordinate) => setMapMarker(coordinate)),
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}
