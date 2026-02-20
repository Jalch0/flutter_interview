import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_flag_image.dart';
import '../../../countries/domain/entities/country.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({
    required this.country,
    required this.onRemove,
    super.key,
  });

  final Country country;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final capitalText = country.capital == null || country.capital!.isEmpty
        ? 'Sin capital'
        : country.capital!.join(', ');

    return Card(
      child: ListTile(
        leading: CustomFlagImage(
          flagPng: country.flagPng,
          width: 48,
          height: 32,
        ),
        title: Text(country.commonName),
        subtitle: Text('Capital: $capitalText'),
        trailing: IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Eliminar de favoritos',
        ),
      ),
    );
  }
}
