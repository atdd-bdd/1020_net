import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyAppWidget(),
    );
  }
}


class MyAppWidget extends StatefulWidget {
  const MyAppWidget({super.key});

  @override
  State<MyAppWidget> createState() => _MyAppState();
}

var entries = ["a","b","c"];
var events = [MyEvent(title:"First"), MyEvent(title:"Second"),
  MyEvent(title:"Third")];
class _MyAppState extends State<MyAppWidget> {
  int currentPageIndex = 0;
  //  Try out the geo code
  String address = "Durham, NC";


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String url = "https://geocode.maps.co/search?q=" +
        address+ "&api_key=65edd11b7f07a815035540vhz5b8f4e";
    // https://geocode.maps.co/search?q=%22621%20Broad%20St%20Durham,%20NC%22%20&api_key=65edd11b7f07a815035540vhz5b8f4e
    // // print(value);
    // [{"place_id":307652039,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"node","osm_id":266814250,"boundingbox":["36.0070492","36.0071492","-78.9206063","-78.9205063"],"lat":"36.0070992","lon":"-78.9205563","display_name":"Whole Foods Market, 621, Broad Street, Old West Durham, Durham, Durham County, North Carolina, 27705, United States","class":"shop","type":"supermarket","importance":0.4200099999999999}]
  // [] if not found
    return Scaffold(
        appBar: AppBar(
          title: Text('Bottom Navigation Demo'),
        ),
      bottomNavigationBar: buildNavigationBar(),
      body: <Widget>[

        buildSearch(theme),

        buildResults(theme),

        /// Messages page
        buildDetailList(theme),

      ][currentPageIndex],
    );
  }

  NavigationBar buildNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      indicatorColor: Colors.amber,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.search_rounded),
          icon: Icon(Icons.home_outlined),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.list)),
          label: 'Matches',
        ),
        NavigationDestination(
          icon: Badge(

            child: Icon(Icons.details),
          ),
          label: 'Details',
        ),
      ],
    );
  }



  ListView buildDetail(ThemeData theme) {
    return ListView.builder(
        reverse: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index ==2) {return buildLinkify();}
            return buildListEntry(theme, index);
        },
      );
  }

  Align buildAlignNotNeeded(ThemeData theme) {
    return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Hi!',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        );
  }

  Align buildListEntry(ThemeData theme, int index) {
    return Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
               //events[index].title,
                entries[index],
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
          );
  }

  Padding buildResults(ThemeData theme) {
    return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Help me '),
                subtitle: Text('This is a notification'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 2'),
                subtitle: Text('This is a notification'),
              ),
            ),
          ],
        ),
      );
  }





  Card buildSearch(ThemeData theme) {
    return Card(
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Center(
            child: CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child:
                       buildDetailList(theme)
                       // Text('text $i', style: TextStyle(fontSize: 16.0),)

                    );
                  },
                );
              }).toList(),
            )
          ),
        ),
      );

  }

  ListView buildDetailList(ThemeData theme){
    return ListView (
      children: const <Widget> [
        Row ( children: <Widget>[
        Text("Hello"),
        Text("Another Hello")
        ]
    ),
    Row ( children: <Widget>[
    Text("Hello2"),
    Text("Another Hello3"),
  //     FilledButton(onPressed: (link) async {
  //
  //   if (!await launchUrl(Uri.parse(link.url))) {
  //   throw Exception('Could not launch ${link.url}');
  // },)
    ]
    )
    ]
    );
  }

  Linkify buildLinkify() {
    return Linkify(
      onOpen: (link) async {

        if (!await launchUrl(Uri.parse(link.url))) {
          throw Exception('Could not launch ${link.url}');
        }
      },
      text: "For more information, visit https://www.example.com",
    );
  }
}

class MyEvent {
  var uuid = UUID();
  var id = "000000001";
  var title ="";
  var startDate = MyDateTime.now();
  var endDate = MyDateTime.now();
  var location = "1 Apple Lane, Somewhere, VT";
  var geoLocation = MyGeoLocation(0.0,0.0);
  var description = "Something";
  var tags ="#tag";
  var linkString = "https://1020.net";
  var imageString = "https://1020.net";
  var thumbnailString = "https://1020.net";
  MyEvent({id= "Default ID", title="Default Title",
    MyDateTime? startDateIn, MyDateTime? endDateIn,
    location ="",
    MyGeoLocation? geoLocationIn,
    description ="", tags =""}):
        startDate  = startDateIn ?? MyDateTime.now(),
        endDate = endDateIn ?? MyDateTime.now(),
        geoLocation = geoLocationIn ?? MyGeoLocation.here(),
        id = id,
        title = title,
        tags = tags,
        description = description
  {
  }
}
class MyDateTime {
  var dateTime = DateTime(2024);

  MyDateTime(DateTime dt) {
    this.dateTime = dt;
  }
  static now()
  {
    return MyDateTime(DateTime.now());
  }

}

class MyGeoLocation {
  double latitude = 0.0; // Latitude, in degrees
  double longitude = 0.0; // Longitude, in degrees
  MyGeoLocation(this.latitude, this.longitude);
  static here()
  {
    return MyGeoLocation(0.0,0.0);
  }
}

class UUID {
  var value = ByteData(16);
}
