import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/repository/base/i_wishlist_repository.dart';
import 'package:movie_app/domain/model/movie.dart';

part 'check_wishlist_state.dart';

///This cubit is for checking and add/remove movie from wishlist
@injectable
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(
    @factoryParam this.id,
    this.repository,
  ) : super(const WishlistState());

  final String id;
  final IWishlistRepository repository;

  @PostConstruct()
  void checkSaved() async {
    final saved = await repository.checkSavedToWishlist(id);
    emit(state.copyWith(isSaved: saved));
  }

  Future<void> saveToWishList(Movie movie) async {
    final saved = await repository.saveToWishlist(movie);
    emit(state.copyWith(isSaved: saved, init: false));
  }

  Future<void> removeFromWishList() async {
    final removed = await repository.deleteFromWishList(id);
    emit(state.copyWith(isSaved: !removed, init: false));
  }
}
