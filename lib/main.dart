import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/di/injector.dart';
import 'src/features/countries/presentation/bloc/country_list/country_list_bloc.dart';
import 'src/features/countries/presentation/pages/countries_page.dart';
import 'src/features/wishlist/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'src/features/wishlist/presentation/pages/wishlist_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const FlutterInterviewApp());
}

class FlutterInterviewApp extends StatelessWidget {
  const FlutterInterviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CountryListBloc>()
            ..add(const CountryListEvent.fetchRequested()),
        ),
        BlocProvider(
          create: (_) => getIt<WishlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Interview',
        theme: ThemeData(useMaterial3: true),
        home: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [
      CountriesPage(),
      WishlistPage(),
    ];

    final titles = const [
      'Países de Europa',
      'Lista de deseos',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'Countries',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
