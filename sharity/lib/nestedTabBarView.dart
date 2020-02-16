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
              width: 150,
              child: Tab(
                child: Text(
                  'Hello',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                ),
              )
            ),
            Container(
                width: 150,
                child: Tab(
                  child: Text(
                    'Hello2',
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueAccent,
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
