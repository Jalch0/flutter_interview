import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/widgets/custom_flag_image.dart';
import '../bloc/country_detail/country_detail_bloc.dart';

class CountryDetailPage extends StatelessWidget {
  const CountryDetailPage({
    required this.countryName,
    super.key,
  });

  final String countryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CountryDetailBloc>()
        ..add(
          CountryDetailEvent.fetchRequested(countryName: countryName),
        ),
      child: Scaffold(
        appBar: AppBar(title: Text(countryName)),
        body: BlocListener<CountryDetailBloc, CountryDetailState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
          child: BlocBuilder<CountryDetailBloc, CountryDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (message) => Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
                loaded: (countryDetail) {
                  final capitalText = countryDetail.capital == null ||
                          countryDetail.capital!.isEmpty
                      ? 'Sin capital'
                      : countryDetail.capital!.join(', ');

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (countryDetail.flagPng.isNotEmpty)
                        Center(
                          child: CustomFlagImage(
                            flagPng: countryDetail.flagPng,
                            width: 160,
                            height: 100,
                            borderRadius: 8,
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        countryDetail.commonName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Nombre oficial: ${countryDetail.officialName}',
                      ),
                      Text('Capital: $capitalText'),
                      Text('Población: ${countryDetail.population}'),
                      Text('Región: ${countryDetail.region}'),
                      Text('Subregión: ${countryDetail.subregion}'),
                      Text(
                        'Idiomas: ${countryDetail.languages.join(', ')}',
                      ),
                      Text(
                        'Monedas: ${countryDetail.currencies.join(', ')}',
                      ),
                      Text(
                        'Husos horarios: '
                        '${countryDetail.timezones.join(', ')}',
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
