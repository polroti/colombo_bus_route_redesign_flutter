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
    List<String> places = [];

    this.data.forEach((element) {
      if (element['routeNumber'] == widget.routeNumber) {
        if (element['places'].length > 1) {
          element['places'].forEach((element) {
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
                  options: new MapOptions(
                center: latLng.LatLng(51.5, -0.09),
                zoom: 13.0,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
