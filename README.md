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
| `scrollDirection`| Your preferred scrollDirection |

## Example

    import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
    
    // Required it
    TabBar(
        onTap: (index) {
            VerticalScrollableTabBarStatus.setIndex(index); <- Required 
        },
    )
    
    and

    VerticalScrollableTabView(
        tabController: tabController,                             <- Required TabBarController
        listItemData: data,                                       <- Required List<dynamic>
        scrollDirection: Axis.horizontal or Axis.vertical,        <- Required Axis
        eachItemChild: (object,index){
            return CategorySection(category: object as Category); <- Object and index
        },
        verticalScrollPosition: VerticalScrollPosition.begin,
    ),



## Contribution
Contributions are accepted via pull requests. For more information about how to contribute to this package, please check the [contribution guide](https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/CONTRIBUTION.md).

## License
This project is licensed under the MIT license, additional knowledge about the license can be found [here](https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/LICENSE).

