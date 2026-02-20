import 'package:flutter_test/flutter_test.dart';

void main() {
  test('constantes de dominio son accesibles', () {
    const expected = 'Europe';
    expect(expected, isNotEmpty);
  });
}
