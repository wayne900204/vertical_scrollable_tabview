import 'package:flutter/material.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'category_section.dart';
import 'example_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vertical Scrollable TabView Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Vertical Scrollable TabView Plugin'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Category> data = ExampleData.data;

  // TabController More Information => https://api.flutter.dev/flutter/material/TabController-class.html
  late TabController tabController;

  // Instantiate scroll_to_index (套件提供的方法)
  late AutoScrollController autoScrollController;

  @override
  void initState() {
    tabController = TabController(length: data.length, vsync: this);
    autoScrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VerticalScrollableTabView(
        autoScrollController: autoScrollController,
        scrollbarIsAlwaysShown: false,
        tabController: tabController,
        listItemData: data,
        verticalScrollPosition: VerticalScrollPosition.begin,
        eachItemChild: (object, index) =>
            CategorySection(category: object as Category),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("SliverAppBar"),
              titlePadding: EdgeInsets.only(bottom: 50),
              collapseMode: CollapseMode.pin,
              background: FlutterLogo(),
            ),
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              indicatorColor: Colors.cyan,
              labelColor: Colors.cyan,
              unselectedLabelColor: Colors.white,
              indicatorWeight: 3.0,
              tabs: data.map((e) {
                return Tab(text: e.title);
              }).toList(),
              onTap: (index) {
                VerticalScrollableTabBarStatus.setIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
