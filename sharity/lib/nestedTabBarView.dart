import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';



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
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        _suggestions.addAll(["Hello", "World", "Fuck"]); /*4*/
      }
      return _buildRow(_suggestions[index]);
      });
  }
  Widget _buildRow(String pair) {
    return ListTile(
      title: Text(
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

