// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:Sharity/nestedTabBarView.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: SharityHomePage(title: 'Sharity')
    );
  }
}


class SharityHomePage extends StatefulWidget {
  final String title;

  SharityHomePage({Key key, this.title}) : super(key: key);

  @override
  _SharityHomePageState createState() => _SharityHomePageState();
}

class _SharityHomePageState extends State<SharityHomePage>
    with TickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: Material(
        color: Colors.blueGrey,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.email),
            ),
            Tab(
              icon: Icon(Icons.settings),
            ),
          ]
        )
      ),
      body: TabBarView(
        children: <Widget>[
          NestedTabBar(),
          Center(
            child: Text("Email"),
          ),
          Center(
            child: Text("Settings"),
          )
        ],
        controller: _tabController,
      ),
    );
  }
}

