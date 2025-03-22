import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoes_shop/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_shoes_shop/data/sql_helper.dart';
import 'package:flutter_shoes_shop/models/product.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  List<Map<String, dynamic>> favProducts = [];

  FavoriteBloc() : super(FavoriteInitial(favoriteProducts: [])) {
    on<AddFavoriteProduct>(_onAddFavoriteProduct);
    // on<RemoveFavoriteProduct>(_onRemoveFavoriteProduct);
    // on<ClearAllFavorite>(_onClearAll);
  }

  Future<void> _onAddFavoriteProduct(AddFavoriteProduct event, Emitter<FavoriteState> emit) async {
      emit(FavoriteLoading(isLoading: true));
    List<Map<String,dynamic>> productRelationshiop  = await DBHelper.instance.getFavoriteProductByAccountID(event.accountId);
    final product = productRelationshiop.first;
    if(product.isNotEmpty){
      emit(FavoriteLoading(isLoading: false));
    } else {
      await DBHelper.instance.createFavoriteProduct(product);
      emit(FavoriteLoading(isLoading: false));
      favProducts.add(product);
      emit(FavoriteSuccess(favoriteProducts: favProducts));
    }
  }

  static void addFavorite(BuildContext context, int accountId, int productId){
    return context.read<FavoriteBloc>().add(AddFavoriteProduct(accountId: accountId, productId: productId));
  }


}
