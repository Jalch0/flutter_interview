part of 'wishlist_bloc.dart';

@freezed
class WishlistState with _$WishlistState {
  const factory WishlistState.initial() = _Initial;

  const factory WishlistState.loading() = _Loading;

  const factory WishlistState.loaded({
    required List<Country> countries,
  }) = _Loaded;


  /// Solo se emite después de una solicitud exitosa de [WishlistEvent.addRequested].
  /// Permite que la interfaz de usuario distinga entre un "guardado" y una "carga" normal.
  const factory WishlistState.saved({
    required List<Country> countries,
  }) = _Saved;

  const factory WishlistState.error({
    required String message,
  }) = _Error;
}
