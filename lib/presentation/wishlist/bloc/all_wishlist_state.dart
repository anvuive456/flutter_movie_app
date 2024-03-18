part of 'all_wishlist_cubit.dart';

class AllWishlistState extends Equatable {
  final List<Movie> wishlist;
  final bool loading;
  final Object? error;

  @override
  List<Object?> get props => [wishlist, loading, error];

//<editor-fold desc="Data Methods">
  const AllWishlistState({
    this.wishlist = const [],
    this.loading = true,
    this.error,
  });

  AllWishlistState copyWith({
    List<Movie>? wishlist,
    bool? loading,
    Object? error,
  }) {
    return AllWishlistState(
      wishlist: wishlist ?? this.wishlist,
      loading: loading ?? this.loading,
      error: error,
    );
  }

//</editor-fold>
}
