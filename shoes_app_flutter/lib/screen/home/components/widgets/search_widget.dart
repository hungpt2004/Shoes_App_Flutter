import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/theme/style_text.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            if(value!.isEmpty || value == null){
              return "Please enter search word";
            } else {
              return null;
            }
          },
          controller: _searchController,
          decoration: InputDecoration(
            focusColor: Colors.blueAccent,
            filled: true,
            fillColor: Colors.white,
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
           prefixIcon: TextButton(onPressed: (){
             if(_formKey.currentState!.validate()){
               print("KHONG CO LOI");
               //Logic action
             }
           }, child: Image.asset("assets/images/icons/search.png",width: 25,height: 25,)),
           hintText: 'Looking for shoes',
           hintStyle: StyleText.styleAirbnb(14, FontWeight.w400, Colors.grey.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}
