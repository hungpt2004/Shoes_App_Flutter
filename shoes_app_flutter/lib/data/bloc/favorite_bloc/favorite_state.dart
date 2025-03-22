abstract class FavoriteState {}

final class FavoriteInitial extends FavoriteState {
  List<Map<String, dynamic>> favoriteProducts = [];

  FavoriteInitial({required this.favoriteProducts});
}

final class FavoriteSuccess extends FavoriteState {
  List<Map<String, dynamic>> favoriteProducts;

  FavoriteSuccess({required this.favoriteProducts});
}

final class FavoriteFailure extends FavoriteState {
  List<Map<String, dynamic>> favoriteProducts;

  FavoriteFailure({required this.favoriteProducts});
}

final class FavoriteLoading extends FavoriteState {
  bool isLoading;

  FavoriteLoading({required this.isLoading});
}


