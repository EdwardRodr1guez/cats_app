import 'package:flutter/material.dart';

class CatCircles extends StatelessWidget {
  final int number;

  const CatCircles({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CatIcon(filled: number >= 1),
        CatIcon(filled: number >= 2),
        CatIcon(filled: number >= 3),
        CatIcon(filled: number >= 4),
        CatIcon(filled: number >= 5),
      ],
    );
  }
}

class CatIcon extends StatelessWidget {
  final bool filled;

  const CatIcon({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0),
      child: Opacity(
        opacity: filled ? 1 : 0.3,
        child: Image.asset(
          filled
              ? "assets/cat_indicator.png" // URL de imagen de gato lleno
              : "assets/cat_indicator.png", // URL de imagen de gato vacío

          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
