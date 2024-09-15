import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
    this.navigationShell, {
    super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: navigationShell.currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.circle),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.table),
            label: 'Tables',
          ),
        ],
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
      tabBuilder: (_, __) {
        return navigationShell;
      },
    );
  }
}
