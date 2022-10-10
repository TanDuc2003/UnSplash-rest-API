import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:image/utils/my_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    final pageState = Provider.of<PageState>(context);
    return FlashyTabBar(
      selectedIndex: pageState.currentPage,
      showElevation: true,
      onItemSelected: (value) {
        pageState.changePage(value);
        pageController.jumpToPage(value);
      },
      items: [
        FlashyTabBarItem(
          activeColor: Colors.pink,
          inactiveColor: Colors.black,
          icon: const Icon(
            Icons.home_outlined,
            size: 23,
          ),
          title: const Text('Trang chủ', style: TextStyle(fontSize: 16)),
        ),
        FlashyTabBarItem(
          activeColor: Colors.pink,
          inactiveColor: Colors.black,
          icon: const Icon(
            Icons.collections,
            size: 21,
          ),
          title: const Text('Thể loại', style: TextStyle(fontSize: 16)),
        ),
        FlashyTabBarItem(
          activeColor: Colors.pink,
          inactiveColor: Colors.black,
          icon: const Icon(
            Icons.favorite,
            size: 23,
          ),
          title: const Text('Yêu thích', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
