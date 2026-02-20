part of 'wishlist_bloc.dart';

@freezed
class WishlistEvent with _$WishlistEvent {
  const factory WishlistEvent.loadRequested() = _LoadRequested;

  const factory WishlistEvent.addRequested({
    required Country country,
  }) = _AddRequested;

  const factory WishlistEvent.removeRequested({
    required String countryCode,
  }) = _RemoveRequested;
}
