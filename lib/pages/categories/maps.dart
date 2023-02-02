import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wanted_umbrella/models/selection_model.dart';

import '../../routes.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  // given camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(12.9165757, 77.61011630000007),
    zoom: 12,
  );

// created empty list of markers
  final List<Marker> _markers = <Marker>[];



  List<SelectionModel> names = [
    SelectionModel(text: 'Therpup - The Dog Cafe\nRestaurant', text2: 'Restaurant', image: 'Therpup Dog Cafe, Kaithota Road, Whitefield road, Nagondanahalli, Bengaluru, Karnataka 560066'),
    SelectionModel(text: 'Sussy dog food store', text2: 'FoodStore', image: 'XJ75+899, Muniswamy Garden, Neelasandra, Bengaluru, Karnataka 560025'),
    SelectionModel(text: "Dr Revathi's Pet Clinic", text2: 'VetClinic', image: 'Shantiniketan, 668 Shantiniketan main road, BTM 2nd Stage, 6th stage, Bengaluru, Karnataka 560076'),
    SelectionModel(text: "Bozo Wags Veterinary Hospital & Pet Services", text2: 'VetClinic', image: 'No. 16/1, Akshaya Complex, 5th Cross, Main Road, Yelenahalli, Akshayanagar, Bengaluru, Karnataka 560068'),
    SelectionModel(text: "My Pets Choice Pet Spa", text2: 'Spa', image: '3rd, 195/2, Sector, 22nd Cross Rd, Sector 3, HSR Layout, Bengaluru, Karnataka 560102/1, Akshaya Complex, 5th Cross, Main Road, Yelenahalli, Akshayanagar, Bengaluru, Karnataka 560068'),
    SelectionModel(text: "ST Bed Dog Park", text2: 'Park', image: 'WJJM+X99, 8th Cross Rd, 4th Block, Nirguna Mandir Layout, S T Bed Layout, Ejipura, Bengaluru, Karnataka 560095'),
    SelectionModel(text: "PawSpace", text2: 'DayCare', image: 'No. 07/3, 15/1, 185/2, 185/A, 2nd floor, Kokarya, Business Synergy center Nagananda commercial complex, 18th Main Rd, Jayanagara 9th Block, Bengaluru, Karnataka 560041'),
    SelectionModel(text: "Doggiliciouus", text2: 'FoodStore', image: 'no 4, ground floor, Dog wellness centre, Plot, 27/2/4, Haralur Main Rd, Ambalipura, Bengaluru, Karnataka 560102'),

  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // created method for displaying custom markers according to index
  loadData() async{
    for(int i=0 ;i<names.length; i++){
      // makers added according to index
      _markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(i.toString()),
            // given marker icon
            // icon: BitmapDescriptor.fromBytes(markIcons),
            // given position
            position: LatLng(
              _kGoogle.target.latitude + sin(i * pi / 6.0) / 20.0,
              _kGoogle.target.longitude + cos(i * pi / 6.0) / 20.0,
            ),
            onTap: (){
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                animType: AnimType.scale,
                dismissOnTouchOutside: false,
                title: names[i].text2,
                desc: "${names[i].text}\n\n${names[i].image}",
                btnCancel: null,
                btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.maps)),
              ).show();
            },
            infoWindow: InfoWindow(
              // given title for marker
              title: names[i].text2,
            ),
          )
      );
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGoogle,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
          markers: Set<Marker>.of(_markers)
      ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
    );
  }
}
