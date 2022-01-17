# vertical_scrollable_tabview

A Flutter widget which synchronize a ScrollView and a custom tab view.

The main idea is to create a custom tab view synchronizing with inner ScrollView. The scroll activity will trigger custom tab view at the top to follow the index of the inner scroll view widget.


![Demo](https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/demo.gif)

## Installation
Add dependency for package on your pubspec.yaml:

    dependencies:
	    vertical_scrollable_tabview: <latest>

## Usage
To use this widget we must first define how our tabs will look like.
### VerticalScrollableTabView
|Parameter| Definition |
|--|--|
| `tabController` |Trailing widget for a tab, typically an TabController.|
| `listItemData`| It must be List< dynamic > Type|
| `eachItemChild`| A item child that in ListView.Builder, First parameter is an object that you put in listItemData, Second parameter is the index in ListView.Builder |
| `verticalScrollPosition`| A Item Position |
| `TabBar` | A TabBar, That required in slivers[SliverAppbar(bottom:TabBar())] |

## Example

    import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
    
    VerticalScrollableTabView(
        tabController: tabController,                           <- Required TabBarController
        listItemData: data,<- Required List<dynamic>
        verticalScrollPosition: VerticalScrollPosition.begin,
        eachItemChild: (object, index) =>
            CategorySection(category: object as Category),       <- Object and index
        slivers: [                                               <- Required slivers 
          SliverAppBar(                                          <- Required SliverAppBar 
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
                VerticalScrollableTabBarStatus.setIndex(index);  <- Required
              },
            ),
          ),
        ],
      ),


## Contribution
Contributions are accepted via pull requests. For more information about how to contribute to this package, please check the [contribution guide](https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/CONTRIBUTION.md).

## License
This project is licensed under the MIT license, additional knowledge about the license can be found [here](https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/LICENSE).

