import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../countries/domain/entities/country.dart';
import '../bloc/wishlist/wishlist_bloc.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistContent extends StatelessWidget {
  const _WishlistContent({required this.countries});

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    if (countries.isEmpty) {
      return const Center(
        child: Text('No hay países en favoritos aún.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];

        return WishlistItemCard(
          country: country,
          onRemove: () {
            context.read<WishlistBloc>().add(
                  WishlistEvent.removeRequested(
                    countryCode: country.cca2,
                  ),
                );
          },
        );
      },
    );
  }
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(
          const WishlistEvent.loadRequested(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistBloc, WishlistState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      child: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (message) => Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            loaded: (countries) => _WishlistContent(countries: countries),
            saved: (countries) => _WishlistContent(countries: countries),
          );
        },
      ),
    );
  }
}
