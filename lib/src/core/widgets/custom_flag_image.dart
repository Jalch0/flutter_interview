import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomFlagImage extends StatelessWidget {
  const CustomFlagImage({
    required this.flagPng,
    required this.width,
    required this.height,
    this.borderRadius = 4,
    super.key,
  });

  final String flagPng;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    if (flagPng.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: flagPng,
        width: width,
        height: height,
        fit: BoxFit.cover,
        memCacheWidth: (width * 2).toInt(),
        memCacheHeight: (height * 2).toInt(),
        placeholder: (_, __) => SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (_, __, ___) => SizedBox(
          width: width,
          height: height,
          child: const Icon(Icons.flag, size: 24),
        ),
      ),
    );
  }
}
