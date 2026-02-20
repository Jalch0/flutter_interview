import 'dart:isolate';

Future<void> runWishlistHeavySimulation({
  required String countryCode,
  required String countryName,
}) async {
  await Isolate.run(() {
    final seed = '$countryCode:$countryName';
    var accumulator = 0;

    for (var i = 0; i < 4000000; i++) {
      accumulator = (accumulator * 31 +
              seed.codeUnitAt(i % seed.length) +
              i) &
          0x7fffffff;
    }

    return accumulator;
  });
}
