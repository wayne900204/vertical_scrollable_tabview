import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/// Detect TabBar Status, isOnTap = is to check TabBar is on Tap or not, isOnTapIndex = is on Tap Index
/// 增廁 TabBar 的狀態，isOnTap 是用來判斷是否是被點擊的狀態，isOnTapIndex 是用來儲存 TapBar 的 Index 的。
class VerticalScrollableTabBarStatus {
  static bool isOnTap = false;
  static int isOnTapIndex = 0;

  static void setIndex(int index) {
    VerticalScrollableTabBarStatus.isOnTap = true;
    VerticalScrollableTabBarStatus.isOnTapIndex = index;
  }
}

/// VerticalScrollPosition = is ann Animation style from scroll_to_index plugin's preferPosition,
/// It's show the item position in listView.builder
/// 用來設定動畫狀態的（參考 scroll_to_index 的 preferPosition 屬性）
enum VerticalScrollPosition { begin, middle, end }

class VerticalScrollableTabView extends StatefulWidget {
  /// TabBar Controller to let widget listening TabBar changed
  /// TabBar Controller 用來讓 widget 監聽 TabBar 的 index 是否有更動
  final TabController _tabController;

  /// Required a List<dynamic> Type，you can put your data that you wanna put in item
  /// 要求 List<dynamic> 的結構，List 裡面可以放自己建立的 Object
  final List<dynamic> _listItemData;

  /// A callback that return an Object inside _listItemData and the index of ListView.Builder
  /// A callback 用來回傳一個 _listItemData 裡面的 Object 型態和 ListView.Builder 的 index
  final Widget Function(dynamic aaa, int index) _eachItemChild;

  /// VerticalScrollPosition = is ann Animation style from scroll_to_index,
  /// It's show the item position in listView.builder
  final VerticalScrollPosition _verticalScrollPosition;

  /// TODO Horizontal ScrollDirection
  // final Axis _axisOrientation;

  /// Required SliverAppBar, And TabBar must inside of SliverAppBar, and In the TabBar
  /// onTap: (index) => VerticalScrollableTabBarStatus.setIndex(index);
  final List<Widget> _slivers;

  VerticalScrollableTabView({
    required TabController tabController,
    required List<dynamic> listItemData,

    /// TODO Horizontal ScrollDirection
    // required Axis scrollDirection,
    required Widget Function(dynamic aaa, int index) eachItemChild,
    VerticalScrollPosition verticalScrollPosition =
        VerticalScrollPosition.begin,
    required List<Widget> slivers,
  })  : _tabController = tabController,
        _listItemData = listItemData,

        ///TODO Horizontal ScrollDirection
        // _axisOrientation = scrollDirection,
        _eachItemChild = eachItemChild,
        _verticalScrollPosition = verticalScrollPosition,
        _slivers = slivers;

  @override
  _VerticalScrollableTabViewState createState() =>
      _VerticalScrollableTabViewState();
}

class _VerticalScrollableTabViewState extends State<VerticalScrollableTabView>
    with SingleTickerProviderStateMixin {
  /// Instantiate scroll_to_index (套件提供的方法)
  late AutoScrollController scrollController;

  /// When the animation is started, need to pause onScrollNotification to calculate Rect
  /// 動畫的時候暫停去運算 Rect
  bool pauseRectGetterIndex = false;

  /// Instantiate RectGetter（套件提供的方法）
  final listViewKey = RectGetter.createGlobalKey();

  /// To save the item's Rect
  /// 用來儲存 items 的 Rect 的 Map
  Map<int, dynamic> itemsKeys = {};

  @override
  void initState() {
    widget._tabController.addListener(() {
      // will call two times, because 底層呼叫 2 次 notifyListeners()
      // https://stackoverflow.com/questions/60252355/tabcontroller-listener-called-multiple-times-how-does-indexischanging-work
      if (VerticalScrollableTabBarStatus.isOnTap) {
        animateAndScrollTo(VerticalScrollableTabBarStatus.isOnTapIndex);
        VerticalScrollableTabBarStatus.isOnTap = false;
      }
    });
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RectGetter(
      key: listViewKey,
      // NotificationListener 是一個由下往上傳遞通知，true 阻止通知、false 傳遞通知，確保指監聽滾動的通知
      // ScrollNotification => https://www.jianshu.com/p/d80545454944
      child: NotificationListener<ScrollNotification>(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [...widget._slivers, buildVerticalSliverList()],
        ),
        onNotification: onScrollNotification,
      ),
    );
  }

  /// TODO()  横向滑動區域
  // Widget buildScrollView() {
  //   return ListView.builder(
  //     controller: widget._scrollController,
  //     itemCount: widget._listItemData.length,
  //     /// TODO Horizontal ScrollDirection
  //     // scrollDirection: widget._axisOrientation,
  //     itemBuilder: (BuildContext context, int index) {
  //       /// Initial Key of itemKeys
  //       /// 初始化 itemKeys 的 key
  //       itemsKeys[index] = RectGetter.createGlobalKey();
  //       return buildItem(index);
  //     },
  //   );
  // }

  SliverList buildVerticalSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(List.generate(
        widget._listItemData.length,
        (index) {
          // 建立 itemKeys 的 Key
          itemsKeys[index] = RectGetter.createGlobalKey();
          return buildItem(index);
        },
      )),
    );
  }

  Widget buildItem(int index) {
    dynamic category = widget._listItemData[index];
    return RectGetter(
      /// when announce GlobalKey，we can use RectGetter.getRectFromKey(key) to get Rect
      /// 宣告 GlobalKey，之後可以 RectGetter.getRectFromKey(key) 的方式獲得 Rect
      key: itemsKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: widget._eachItemChild(category, index),
      ),
    );
  }

  /// Animation Function for tabBarListener
  /// This need to put inside TabBar onTap, but in this case we put inside tabBarListener
  void animateAndScrollTo(int index) async {
    // Scroll 到 index 並使用 begin 的模式，結束後，把 pauseRectGetterIndex 設為 false 暫停執行 ScrollNotification
    pauseRectGetterIndex = true;
    widget._tabController.animateTo(index);
    switch (widget._verticalScrollPosition) {
      case VerticalScrollPosition.begin:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.middle:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.middle)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.end:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.end)
            .then((value) => pauseRectGetterIndex = false);
        break;
    }
  }

  /// onScrollNotification of NotificationListener
  /// true表示消費掉當前通知不再向上一级NotificationListener傳遞通知，false則會再向上一级NotificationListener傳遞通知；
  bool onScrollNotification(ScrollNotification notification) {
    // if (pauseRectGetterIndex) return true;

    // /// get tabBar index
    // /// 取得 tabBar 的長度
    // int lastTabIndex = widget._tabController.length - 1;

    // List<int> visibleItems = getVisibleItemsIndex();

    // /// define what is reachLastTabIndex
    // bool reachLastTabIndex = visibleItems.isNotEmpty &&
    //     visibleItems.length <= 2 &&
    //     visibleItems.last == lastTabIndex;

    // /// if reachLastTabIndex, then scroll to last index
    // /// 如果到達最後一個 index 就跳轉到最後一個 index
    // if (reachLastTabIndex) {
    //   widget._tabController.animateTo(lastTabIndex);
    // } else {
    //   // 取得畫面中的 item 的中間值。例：2,3,4 中間的就是 3
    //   // 求一個數字列表的乘積
    //   int sumIndex = visibleItems.reduce((value, element) => value + element);
    //   // 5 ~/ 2 = 2  => Result is an int 取整數
    //   int middleIndex = sumIndex ~/ visibleItems.length;
    //   if (widget._tabController.index != middleIndex) {
    //     widget._tabController.animateTo(middleIndex);
    //   }
    // }
    List<int> visibleItems = getVisibleItemsIndex();
    widget._tabController.animateTo(visibleItems[0]);
    return false;
  }

  /// getVisibleItemsIndex on Screen
  /// 取得現在畫面上可以看得到的 Items Index
  List<int> getVisibleItemsIndex() {
    // get ListView Rect
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;

    /// TODO Horizontal ScrollDirection
    // bool isHoriontalScroll = widget._axisOrientation == Axis.horizontal;
    bool isHoriontalScroll = false;
    itemsKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      // y 軸座越大，代表越下面
      // 如果 item 上方的座標 比 listView 的下方的座標 的位置的大 代表不在畫面中。
      // bottom meaning => The offset of the bottom edge of this widget from the y axis.
      // top meaning => The offset of the top edge of this widget from the y axis.
      //Change offset based on AxisOrientation [horizontal] [vertical]
      switch (isHoriontalScroll) {
        case true:
          if (itemRect.left > rect.right) return;
          // 如果 item 下方的座標 比 listView 的上方的座標 的位置的小 代表不在畫面中。
          if (itemRect.right < rect.left) return;
          break;
        default:
          if (itemRect.top > rect.bottom) return;
          // 如果 item 下方的座標 比 listView 的上方的座標 的位置的小 代表不在畫面中。
          if (itemRect.bottom <
              rect.top +
                  MediaQuery.of(context).viewPadding.top +
                  kToolbarHeight +
                  56) return;
      }

      items.add(index);
    });
    return items;
  }
}
