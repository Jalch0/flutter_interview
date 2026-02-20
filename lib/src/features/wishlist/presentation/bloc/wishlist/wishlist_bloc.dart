import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../../countries/domain/entities/country.dart';
import '../../../domain/usecases/get_wishlist.dart';
import '../../../domain/usecases/remove_from_wishlist.dart';
import '../../../domain/usecases/save_to_wishlist.dart';
import 'wishlist_isolate.dart';

part 'wishlist_bloc.freezed.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

typedef WishlistHeavySimulation = Future<void> Function({
  required String countryCode,
  required String countryName,
});

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({
    required GetWishlist getWishlist,
    required SaveToWishlist saveToWishlist,
    required RemoveFromWishlist removeFromWishlist,
    WishlistHeavySimulation? heavySimulation,
  })  : _getWishlist = getWishlist,
        _saveToWishlist = saveToWishlist,
        _removeFromWishlist = removeFromWishlist,
        _heavySimulation = heavySimulation ?? runWishlistHeavySimulation,
        super(const WishlistState.initial()) {
    on<_LoadRequested>(_onLoadRequested);
    on<_AddRequested>(_onAddRequested);
    on<_RemoveRequested>(_onRemoveRequested);
  }

  final GetWishlist _getWishlist;
  final SaveToWishlist _saveToWishlist;
  final RemoveFromWishlist _removeFromWishlist;
  final WishlistHeavySimulation _heavySimulation;

  Future<void> _onLoadRequested(
    _LoadRequested event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistState.loading());
    await _loadWishlistAndEmit(emit);
  }

  Future<void> _onAddRequested(
    _AddRequested event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistState.loading());

    await _heavySimulation(
      countryCode: event.country.cca2,
      countryName: event.country.commonName,
    );

    final saveResult = await _saveToWishlist(
      SaveToWishlistParams(country: event.country),
    );

    final hasError = saveResult.fold(
      (failure) {
        emit(WishlistState.error(message: failure.message));
        return true;
      },
      (_) => false,
    );

    if (hasError) {
      return;
    }

    await _loadWishlistAndEmitSaved(emit);
  }

  Future<void> _onRemoveRequested(
    _RemoveRequested event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistState.loading());

    final removeResult = await _removeFromWishlist(
      RemoveFromWishlistParams(countryCode: event.countryCode),
    );

    final hasError = removeResult.fold(
      (failure) {
        emit(WishlistState.error(message: failure.message));
        return true;
      },
      (_) => false,
    );

    if (hasError) {
      return;
    }

    await _loadWishlistAndEmit(emit);
  }

  Future<void> _loadWishlistAndEmit(
    Emitter<WishlistState> emit,
  ) async {
    final result = await _getWishlist(const NoParams());

    result.fold(
      (failure) => emit(WishlistState.error(message: failure.message)),
      (countries) => emit(WishlistState.loaded(countries: countries)),
    );
  }

  Future<void> _loadWishlistAndEmitSaved(
    Emitter<WishlistState> emit,
  ) async {
    final result = await _getWishlist(const NoParams());

    result.fold(
      (failure) => emit(WishlistState.error(message: failure.message)),
      (countries) => emit(WishlistState.saved(countries: countries)),
    );
  }
}
