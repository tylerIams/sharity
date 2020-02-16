import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';



class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
  with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController = new TabController(length: 2,
        vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String url = 'https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&center=-122.3966%2C%2037.7876&width=300&height=400&view=Unified&zoom=12&key=yirJiURqW2kiZQ1hNQJ1UIcS2IC7MfPm';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Container(
              width: screenWidth * .30,
              child: Tab(
                child: Text(
                  'Map',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                ),
              )
            ),
            Container(
                width: screenWidth * .30,
                child: Tab(
                  child: Text(
                    'Food List',
                    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                  ),
                )
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              //Image.network(
              //  'https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&center=-122.3966%2C%2037.7876&width=256&height=256&view=Unified&zoom=12&key=yirJiURqW2kiZQ1hNQJ1UIcS2IC7MfPm',
              //),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueAccent,
                ),
                child: Image.network(
                  url,
                ),
              ),
              Container(
                child: FoodList(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FoodState extends State<FoodList> {
  final _suggestions = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    Food f1 = Food("Rallys", "Burger", "1", "2.50");
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        Future<String> the_data = getFood();
        the_data.then(())

        _suggestions.addAll(["hello"]); /*4*/
      }
      return _buildRow(_suggestions[index]);
      });
  }
  Widget _buildRow(String pair) {
    return ListTile(
      title: Text(
        //pair.restaurant + " " + pair.name + " " + pair.price,
        pair,
        style: _biggerFont,
        ),
      );
    }
  }


class FoodList extends StatefulWidget {
  @override
    FoodState createState() => FoodState();
}

class Food {
  String restaurant;
  String name;
  String id;
  String price;

  Food(this.restaurant, this.name, this.id, this.price);
}


Future<String> getFood() async {
  String the_data = "";
  String url = "http://03a1bde2.ngrok.io/get_all_food/";
  Uri apiUrl = Uri.parse(url);

  HttpClientRequest request = await new HttpClient().getUrl(apiUrl);
  HttpClientResponse response = await request.close();

  Stream resStream = response.transform(Utf8Decoder());

  await for (var data in resStream) {
    the_data = data;
  }

  return the_data.then(d){
    print(d);
  };
}

