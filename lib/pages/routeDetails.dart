import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

// ignore: must_be_immutable

class RouteDetailPage extends StatefulWidget {
  RouteDetailPage({Key key, this.routeNumber}) : super(key: key);
  final String routeNumber;
  @override
  _RouteDetailPageState createState() => _RouteDetailPageState();
}

class _RouteDetailPageState extends State<RouteDetailPage> {
  List<Marker> markers = [];
  List data = [
    {
      "routeNumber": "100",
      "routeName": "Fort - Panadura",
      "places": [
        "Fort",
        "Galle Face",
        "Kollupitiya",
        "Bambalapitiya",
        "Wellawatte",
        "Dehiwala",
        "Mount-Lavinia",
        "Ratmalana",
        "Angulana",
        "Katubedda",
        "Rawatawatta",
        "Moratuwa",
        "Horethuduwa",
        "Gorakana",
        "Keselwatta",
        "Panadura"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "101",
      "routeName": "Fort - Moratuwa",
      "places": [
        "Fort",
        "Slave Island",
        "Gangaramaya",
        "Kollupitiya",
        "Bambalapitiya",
        "Wellawatte",
        "Dehiwala",
        "Mount-Lavinia",
        "Ratmalana",
        "Angulana",
        "Katubedda",
        "Rawatawatta",
        "Moratuwa"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "177",
      "routeName": "Kollupitiya - Kaduwela",
      "places": [
        "Kollupitiya",
        "Library",
        "Nelum Pokuna",
        "Horton Place",
        "Borella",
        "Rajagiriya",
        "Battaramulla",
        "Thalahena",
        "Koswatta",
        "Malabe",
        "Pittugala",
        "SLIIT",
        "Kotalawala",
        "Highway Entrance",
        "Kaduwela"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "100",
      "routeName": "Fort - Moratuwa",
      "places": [
        "Fort",
        "Galle Face",
        "Kollupitiya",
        "Bambalapitiya",
        "Wellawatte",
        "Dehiwala",
        "Mount-Lavinia",
        "Ratmalana",
        "Angulana",
        "Katubedda",
        "Rawatawatta",
        "Moratuwa"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "102",
      "routeName": "Kotahena - Angulana",
      "places": [
        "Kotahena",
        "Kochchikade",
        "Fort",
        "Galle Face",
        "Kollupitiya",
        "Bambalapitiya",
        "Wellawatte",
        "Dehiwala",
        "Mount-Lavinia",
        "Ratmalana",
        "Angulana"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "103",
      "routeName": "Fort - Park Avenue",
      "places": [
        "Fort",
        "Pettah",
        "Technical College Junction",
        "Maradana",
        "Punchi Borella",
        "Borella",
        "Kanatta Junction",
        "Narahenpita",
        "Park Avenue"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "104",
      "routeName": "Bambalapitiya - Ja-Ela",
      "places": [
        "Bambalapitiya",
        "Thummulla",
        "Bauddhaloka Mawatha",
        "Kanatta Junction",
        "Borella",
        "Dematagoda",
        "Orugodawatta",
        "New Kelani Bridge",
        "Peliyagoda",
        "Wattala",
        "Ja-Ela"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "112",
      "routeName": "Maharagama - Kotahena",
      "places": [
        "Kotahena",
        "Kochchikade",
        "Fort",
        "Galle Face",
        "Kollupitiya",
        "Bambalapitiya",
        "Dickmans Road",
        "Havelock Town",
        "Kirillapone",
        "Nugegoda",
        "Delkanda",
        "Navinna",
        "Maharagama"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "113",
      "routeName": "Fort - Udahamulla",
      "places": [
        "Fort",
        "Lake House",
        "D.R. Wijewardhana Road",
        "Gamini Hall Junction",
        "Darley Road",
        "Ibbanwala Junction",
        "Town Hall",
        "Cinnamon Gardens",
        "Independence Square",
        "Torrington Avenue",
        "Thimbirigasyaya",
        "Havelock Town",
        "Kirillapone",
        "Mirihana",
        "Embuldeniya Junction",
        "Udahamulla"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    },
    {
      "routeNumber": "154",
      "routeName": "Angulana - Kiribathgoda",
      "places": [
        "Kiribathgoda",
        "Kelaniya",
        "Peliyagoda",
        "Orugodawatta",
        "Dematagoda",
        "Borella",
        "Kanatta Junction",
        "Bauddhaloka Mawatha",
        "BMICH",
        "Jawatta Road",
        "Thummulla",
        "Bambalapitiya",
        "Wellawatte",
        "Dehiwala",
        "Mount-Lavinia",
        "Ratmalana",
        "Angulana"
      ],
      "imageUrl": "../../assets/images/177/177_bus.jpg"
    }
  ];
  final latLngData = [
    {'name': "Angulana", 'lat': 6.8173567, 'lng': 79.9045282},
    {'name': "Athurugiriya", 'lat': 6.8734427, 'lng': 79.9893857},
    {'name': "BMICH", 'lat': 6.9015603, 'lng': 79.8707128},
    {'name': "Fort", 'lat': 6.925833, 'lng': 79.841667},
    {'name': "Kollupitiya", 'lat': 6.900556, 'lng': 79.853333},
    {'name': "Bambalapitiya", 'lat': 6.888889, 'lng': 79.856667},
    {'name': "Wellawatte", 'lat': 6.874657, 'lng': 79.860483},
    {'name': "Dehiwala", 'lat': 6.856387, 'lng': 79.865156},
    {'name': "Mount-Lavinia", 'lat': 6.838864, 'lng': 79.863141},
    {'name': "Moratuwa", 'lat': 6.7733, 'lng': 79.8825},
    {'name': "Panadura", 'lat': 6.7133, 'lng': 79.9042},
    {'name': "Battaramulla", 'lat': 6.9001015, 'lng': 79.9029844},
    {'name': "Batuwatta", 'lat': 7.0553894, 'lng': 79.9207519},
    {'name': "Bauddhaloka Mawatha", 'lat': 6.9972593, 'lng': 79.8630344},
    {'name': "Bloemendhal", 'lat': 6.9512446, 'lng': 79.8604365},
    {'name': "Boralesgamuwa", 'lat': 6.8365151, 'lng': 79.8714963},
    {'name': "Borella", 'lat': 6.9124745, 'lng': 79.8614361},
    {'name': "Cinnamon Gardens", 'lat': 6.9061463, 'lng': 79.8488393},
    {'name': "D.R. Wijewardhana Road", 'lat': 6.9315196, 'lng': 79.8523319},
    {'name': "Dalugama", 'lat': 6.9735104, 'lng': 79.9120395},
    {'name': "Darley Road", 'lat': 6.9228745, 'lng': 79.8599001},
    {'name': "Delkanda", 'lat': 6.8618352, 'lng': 79.8985203},
    {'name': "Dematagoda", 'lat': 6.9357891, 'lng': 79.8771957},
    {'name': "Dickmans Road", 'lat': 6.8871986, 'lng': 79.8590032},
    {'name': "Embuldeniya Junction", 'lat': 6.8681302, 'lng': 79.9068474},
    {'name': "Galle Face", 'lat': 6.9261046, 'lng': 79.8420486},
    {'name': "Gamini Hall Junction", 'lat': 6.9268455, 'lng': 79.8596285},
    {'name': "Grandpass", 'lat': 6.9511256, 'lng': 79.8679175},
    {'name': "Havelock Town", 'lat': 6.8861913, 'lng': 79.8544967},
    {'name': "Hokandara", 'lat': 6.8775388, 'lng': 79.9444236},
    {'name': "Hulftsdorp", 'lat': 6.9375606, 'lng': 79.8586274},
    {'name': "Ibbanwala Junction", 'lat': 6.9181163, 'lng': 79.860341},
    {'name': "Independence Square", 'lat': 6.9035436, 'lng': 79.8659211},
    {'name': "Ja-Ela", 'lat': 7.0766391, 'lng': 79.8772411},
    {'name': "Jawatta Road", 'lat': 6.8950005, 'lng': 79.8661706},
    {'name': "Kadawatha", 'lat': 7.0096207, 'lng': 79.9250157},
    {'name': "Kaduwela", 'lat': 6.9300185, 'lng': 79.9645933},
    {'name': "Kahathuduwa", 'lat': 6.7837184, 'lng': 79.9798054},
    {'name': "Kalubowila", 'lat': 6.8607468, 'lng': 79.8616943},
    {'name': "Kanatta Junction", 'lat': 6.9084997, 'lng': 79.8747736},
    {'name': "Kandana", 'lat': 7.0462179, 'lng': 79.8552412},
    {'name': "Katubedda", 'lat': 6.8013583, 'lng': 79.8878292},
    {'name': "Kelaniya", 'lat': 6.9565575, 'lng': 79.9029339},
    {'name': "Kiribathgoda", 'lat': 6.9780619, 'lng': 79.9183037}
  ];

  // Future<String> loadJsonData() async {
  //   var jsonText = await rootBundle.loadString('lib/data/routeDetails.json');
  //   data = json.decode(jsonText);
  //   return 'success';
  // }

  // calljson() {
  //   loadJsonData();
  // }

  // @override
  // void initState() {
  //   this.calljson();
  //   super.initState();
  // }

  List<Widget> buildList() {
    List<Widget> widgetList = [];
    //  List<String> places = [];

    this.data.forEach((element) {
      if (element['routeNumber'] == widget.routeNumber) {
        if (element['places'].length > 1) {
          element['places'].forEach((element) {
            //map tiles
            this.latLngData.forEach((locElements) {
              if (element == locElements['name']) {
                this.markers.add(
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new latLng.LatLng(
                            locElements['lat'], locElements['lng']),
                        builder: (ctx) => new Container(
                          child: Icon(Icons.location_on),
                        ),
                      ),
                    );
              }
            });

            widgetList.add(ListTile(
              leading: Icon(
                Icons.transfer_within_a_station_outlined,
              ),
              title: Text(element),
            ));
          });
        }
      }
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "ROUTE",
                  ),
                  Tab(
                    text: "MAP",
                  )
                ],
              ),
              title: Text('Route Details - ' + widget.routeNumber)),
          body: TabBarView(
            children: [
              ListView(
                children: buildList(),
              ),
              new FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(6.8667833, 79.8632827),
                  zoom: 13.0,
                ),
                layers: <LayerOptions>[
                  TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/polroti/ckujy9m0o7xq018rzkjfisozt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicG9scm90aSIsImEiOiJja3VqeTRvd28xN3B5MnFteXBvMTVoZnNpIn0.ZwbUrs2uEa91VCkwBjqjLw",
                    // additionalOptions: {
                    //   'accessToken':
                    //       'pk.eyJ1IjoicG9scm90aSIsImEiOiJja3VqeTRvd28xN3B5MnFteXBvMTVoZnNpIn0.ZwbUrs2uEa91VCkwBjqjLw',
                    //   'id': 'mapbox.streets',
                    // },
                  ),
                  MarkerLayerOptions(markers: this.markers)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
