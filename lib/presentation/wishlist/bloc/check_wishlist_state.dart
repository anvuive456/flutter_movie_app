part of 'check_wishlist_cubit.dart';

class WishlistState extends Equatable {
  final bool isSaved;

  ///Check if is this state is on init
  final bool init;
  final bool loading;
  final Object? error;

//<editor-fold desc="Data Methods">
  const WishlistState({
    this.isSaved = false,
    this.loading = true,
    this.init = true,
    this.error,
  });

  WishlistState copyWith({
    bool? isSaved,
    bool? loading,
    bool? init,
    Object? error,
  }) {
    return WishlistState(
      init: init ?? this.init,
      isSaved: isSaved ?? this.isSaved,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isSaved, loading, error];

//</editor-fold>
}
