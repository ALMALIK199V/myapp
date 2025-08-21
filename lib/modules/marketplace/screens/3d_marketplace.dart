import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class ThreeDMarketplace extends StatelessWidget {
  const ThreeDMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicTheme.cosmicBackground,
      body: TransformableListView(
        children: [
          _buildProductCard('شاشة iPhone 13 Pro', 299.0, 'assets/images/screen.jpg'),
          _buildProductCard('بطارية Samsung', 89.0, 'assets/images/battery.jpg'),
          _buildProductCard('كاميرا متطورة', 150.0, 'assets/images/camera.jpg'),
          _buildProductCard('لوحة أم', 199.0, 'assets/images/motherboard.jpg'),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, double price, String image) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CosmicTheme.cosmicSurface,
            CosmicTheme.cosmicSurface.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: CosmicTheme.cosmicPrimary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // صورة المنتج
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          // تأثير زجاجي
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // معلومات المنتج
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      color: CosmicTheme.cosmicAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // زر الإضافة للسلة
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CosmicTheme.cosmicPrimary,
                boxShadow: [
                  BoxShadow(color: CosmicTheme.cosmicPrimary.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .scale(
      duration: 600.ms,
      curve: Curves.elasticOut,
    )
    .shimmer(
      duration: 2000.ms,
      delay: 1000.ms,
      color: CosmicTheme.cosmicAccent.withOpacity(0.3),
    );
  }
}