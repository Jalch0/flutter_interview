import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wishlist/presentation/bloc/wishlist/wishlist_bloc.dart';
import '../bloc/country_list/country_list_bloc.dart';
import '../widgets/country_card.dart';
import 'country_detail_page.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CountryListBloc, CountryListState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
        ),
        BlocListener<WishlistBloc, WishlistState>(
          listenWhen: (_, current) => current.maybeWhen(
            saved: (_) => true,
            error: (_) => true,
            orElse: () => false,
          ),
          listener: (context, state) {
            state.whenOrNull(
              saved: (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('País guardado en favoritos.'),
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
        ),
      ],
      child: BlocBuilder<CountryListBloc, CountryListState>(
        builder: (context, countriesState) {
          return countriesState.when(
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
            loaded: (countries) {
              if (countries.isEmpty) {
                return const Center(
                  child: Text('No se encontraron países en Europa.'),
                );
              }

              return BlocBuilder<WishlistBloc, WishlistState>(
                buildWhen: (_, current) => current.maybeWhen(
                  loaded: (_) => true,
                  saved: (_) => true,
                  initial: () => true,
                  orElse: () => false,
                ),
                builder: (context, wishlistState) {
                  final wishlistCodes = wishlistState.maybeWhen(
                    loaded: (wl) => wl.map((c) => c.cca2).toSet(),
                    saved: (wl) => wl.map((c) => c.cca2).toSet(),
                    orElse: () => <String>{},
                  );

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CountryListBloc>().add(
                            const CountryListEvent.fetchRequested(),
                          );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];

                        return CountryCard(
                          country: country,
                          isInWishlist: wishlistCodes.contains(country.cca2),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => CountryDetailPage(
                                  countryName: country.commonName,
                                ),
                              ),
                            );
                          },
                          onAddToWishlist: () {
                            context.read<WishlistBloc>().add(
                                  WishlistEvent.addRequested(country: country),
                                );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
