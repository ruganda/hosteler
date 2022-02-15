import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/models/content.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late final MapController mapController = MapController();

  double lat = 0.3427;
  double long = 32.5613;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            child: const BackButton(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.near_me,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng.LatLng(lat, long),
          zoom: 17.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/okellomarvin/ckwrra30v1wtw15r2qimca1km/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2tlbGxvbWFydmluIiwiYSI6ImNrd3JxZDZuYzB6MmkydWxjbDhhZ2UzM2EifQ.Wh7_NqLOx3vIdjY8D7BwHw",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoib2tlbGxvbWFydmluIiwiYSI6ImNrd3JxZDZuYzB6MmkydWxjbDhhZ2UzM2EifQ.Wh7_NqLOx3vIdjY8D7BwHw',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng.LatLng(lat, long),
                builder: (ctx) => Container(
                  child: const Icon(Icons.gps_fixed_rounded),
                ),
              ),
            ],
          ),
        ],
      ),
      //  ValueListenableBuilder(
      //     valueListenable: Hive.box<Content>('hostelsBox').listenable(),
      //     builder: (context, Box<Content> box, _) {
      //       if (box.values.isEmpty) {
      //         return const Center(
      //           child: Text("Empty Hostel content"),
      //         );
      //       } else {
      //         return ListView.builder(
      //             itemCount: box.values.length,
      //             itemBuilder: (context, index) {
      //               Content? currentContent = box.getAt(index);
      //               // var loc = currentContent!.locPicker;
      //               // print((currentContent.locPicker));
      //               return
      //             });
      //       }
      //     }),
    );
  }
}
