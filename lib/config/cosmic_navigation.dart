import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:page_transition/page_transition.dart';

class CosmicNavigation {
  static PageTransition cosmicRoute(Widget page) {
    return PageTransition(
      child: page,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  static Widget cosmicDrawer(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      menuScreen: _buildMenuScreen(context),
      mainScreen: _buildMainScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }

  static Widget _buildMenuScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CosmicTheme.cosmicBackground,
            CosmicTheme.cosmicSurface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... عناصر القائمة
        ],
      ),
    );
  }
}