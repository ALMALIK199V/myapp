import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class CosmicParticles extends StatelessWidget {
  const CosmicParticles({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularParticle(
      awayRadius: 100,
      numberOfParticles: 300,
      speedOfParticles: 0.5,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      onTapAnimation: true,
      particleColor: Colors.white.withOpacity(0.5),
      awayAnimationDuration: const Duration(milliseconds: 800),
      maxParticleSize: 8,
      isRandSize: true,
      isRandomColor: true,
      randColorList: [
        CosmicTheme.cosmicPrimary,
        CosmicTheme.cosmicSecondary,
        CosmicTheme.cosmicAccent,
      ],
      awayAnimationCurve: Curves.easeInOutBack,
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 100,
    );
  }
}