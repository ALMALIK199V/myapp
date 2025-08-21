import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;

  const CustomLoadingIndicator({
    super.key,
    this.message,
    this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
            strokeWidth: 3,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 1000.ms),

        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}