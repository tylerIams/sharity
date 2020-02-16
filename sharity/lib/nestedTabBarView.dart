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
