import '../../../models/account.dart';
import '../../../models/product.dart';

abstract class FavoriteEvent {}

class AddFavoriteProduct extends FavoriteEvent {
  final int accountId;
  final int productId;

  AddFavoriteProduct({required this.accountId, required this.productId});
}

class RemoveFavoriteProduct extends FavoriteEvent {
  final int accountId;
  final int productId;

  RemoveFavoriteProduct({required this.accountId, required this.productId});
}

class ClearAllFavorite extends FavoriteEvent {}
