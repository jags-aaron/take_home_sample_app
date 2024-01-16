import 'package:go_router/go_router.dart';

extension GorouteExternsion on GoRouter {
  void popUntil(String path) {
    while (canPop() && routerDelegate.currentConfiguration.matches.last.matchedLocation != path) {
      pop();
    }
  }
}