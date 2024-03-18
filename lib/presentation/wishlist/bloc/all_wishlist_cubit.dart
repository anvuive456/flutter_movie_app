import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/repository/base/i_wishlist_repository.dart';
import 'package:movie_app/data/repository/impl/wishlist_repository.dart';

import '../../../domain/model/movie.dart';

part 'all_wishlist_state.dart';

@injectable
class AllWishlistCubit extends Cubit<AllWishlistState> {
  AllWishlistCubit(this.repository) : super(const AllWishlistState());
  final IWishlistRepository repository;

  @PostConstruct()
  void getWishlist() async {
    try {
      final movies = await repository.fetchMovies();
      emit(state.copyWith(wishlist: movies));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
