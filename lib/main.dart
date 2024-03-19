import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _MyAppState extends State<MyAppWidget> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Bottom Navigation Demo'),
        ),
      bottomNavigationBar: buildNavigationBar(),
      body: <Widget>[
        /// Home page
        buildCard(theme),

        /// Notifications page
        buildPadding(),

        /// Messages page
        buildListView(theme),

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
            label: Text('2'),
            child: Icon(Icons.details),
          ),
          label: 'Details',
        ),
      ],
    );
  }



  ListView buildListView(ThemeData theme) {
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
               entries[index],
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
          );
  }

  Padding buildPadding() {
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





  Card buildCard(ThemeData theme) {
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
                        child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                    );
                  },
                );
              }).toList(),
            )
          ),
        ),
      );

  }

  Linkify buildLinkify() {
    return Linkify(
      onOpen: (link) async {
        print("Link is:");
        print(link.url);
        print(":");
        if (!await launchUrl(Uri.parse(link.url))) {
          throw Exception('Could not launch ${link.url}');
        }
      },
      text: "For more information, visit https://www.example.com",
    );
  }
}

