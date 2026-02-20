import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_flag_image.dart';
import '../../domain/entities/country.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    required this.country,
    required this.onTap,
    required this.onAddToWishlist,
    required this.isInWishlist,
    super.key,
  });

  final Country country;
  final VoidCallback onTap;
  final VoidCallback onAddToWishlist;
  final bool isInWishlist;

  @override
  Widget build(BuildContext context) {
    final capitalText = country.capital == null || country.capital!.isEmpty
        ? 'Sin capital'
        : country.capital!.join(', ');

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomFlagImage(
                    flagPng: country.flagPng,
                    width: 48,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      country.commonName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: onAddToWishlist,
                    icon: Icon(
                      isInWishlist
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isInWishlist
                          ? Theme.of(context).colorScheme.error
                          : null,
                    ),
                    tooltip: isInWishlist
                        ? 'Ya está en favoritos'
                        : 'Agregar a favoritos',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Capital: $capitalText'),
              Text('Región: ${country.region}'),
              Text('Población: ${country.population}'),
            ],
          ),
        ),
      ),
    );
  }
}
