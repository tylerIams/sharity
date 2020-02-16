import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> with TickerProviderStateMixin {
  TabController _nestedTabController;
  Future<Food> futureFood;

  @override
  void initState() {
    print("Calling super");
    super.initState();
    print("Called Super");
    _nestedTabController = new TabController(length: 2,
        vsync: this);
    print("Calling Get Food");
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    futureFood = getFood();
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
                child: FutureBuilder<Food>(
                  future: futureFood,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                          "Restaurant: " + snapshot.data.restaurant + "\n" + "Food Item: " + snapshot.data.item_name + " Price: " + snapshot.data.price,
                          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                      );
                      //print("Has data");
                      //print(snapshot.data);
                      //print(snapshot.data.item_name);
                      //print(snapshot.data.restaurant);
                      //return Text();
                    } else if (snapshot.hasError) {
                      return Text("ERROR WITH DATA");
                    }
                    return CircularProgressIndicator();
                  }
                ),
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
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        _suggestions.addAll(["hello", "world"]); /*4*/
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


class Product {
  final List<Food> foods;

  Product({this.foods});
}

Future<Food> getFood() async {
  //final response = await http.get('http://www.google.com');
  final response = await http.get('http://f5a3f93a.ngrok.io/get_all_food/');

  print("response: " + response.body);

  if (response.statusCode == 200) {
    return Food.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load food!!!');
  }

}


class Food {
  final int inventory_id;
  final String restaurant;
  final String item_name;
  final String price;
  final int quantity;

  Food({this.inventory_id, this.restaurant, this.item_name, this.price, this.quantity});

  factory Food.fromJson(Map<String, dynamic> json) {

    return Food(
      inventory_id: json['inventory_id'],
      restaurant: json['restaurant'],
      item_name: json['item_name'],
      price: json['price'],
      quantity: json['quantity'],
    );

  }
}
