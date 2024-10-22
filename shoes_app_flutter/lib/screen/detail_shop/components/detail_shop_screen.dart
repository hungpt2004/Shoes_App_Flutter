import 'package:flutter/material.dart';
import 'package:flutter_shoes_shop/data/sql_helper.dart';

import '../../../models/product.dart';
import '../../../models/product_color.dart';
import '../../../models/product_size.dart';
import '../../../theme/style_color.dart';
import '../../../theme/style_text.dart';

class DetailShopScreen extends StatefulWidget {
  final int productId;
  const DetailShopScreen({super.key, required this.productId});

  @override
  State<DetailShopScreen> createState() => _DetailShopScreenState();
}

class _DetailShopScreenState extends State<DetailShopScreen> {

  int imageIndexCurrent = 0;
  int sizeIndexCurrent = 0;
  int quantity  = 1;
  bool favourite = false;


  Product? product;
   List<ProductColor> productColors = [];
   List<ProductSize> productSizes = [];
   List<String> sizes = [];
   bool load = true;

  @override
  void initState(){
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    Product? fetchedProduct = await DBHelper.getProductById(widget.productId);
    List<ProductColor> fetchProductColors = await DBHelper.getProductColorsByProductId(widget.productId);
    List<ProductSize> fetchProductSizes = await DBHelper.getProductSizesByColorId(fetchProductColors.elementAt(imageIndexCurrent).id);
    List<String> fetchListSize = await DBHelper.getSizesByProductColorId(fetchProductColors.elementAt(imageIndexCurrent).id);
    setState(() {
      product = fetchedProduct;
      productColors = fetchProductColors;
      sizes = fetchListSize;
      productSizes = fetchProductSizes;
      load = false;
      for(ProductSize productSize in productSizes){
        if(productSize.amount == 0){
          sizeIndexCurrent++;
        }else{
          return;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: StyleColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: StyleColor.backgroundColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    "assets/images/icons/apps-circle.png",
                    width: double.infinity,
                  ),
                ),
              ),
              Text(
                  "H&N Shoes",
                style: StyleText.styleAirbnb(18, FontWeight.w500, StyleColor.darkBlueColor),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            favourite = !favourite;
                          });
                        },
                        child: favourite
                            ? Image.asset(
                          "assets/images/icons/Icon_Red.png",
                          width: double.infinity,
                        )
                            : Image.asset(
                          "assets/images/icons/Icon.png",
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset(
                        "assets/images/icons/my_cart.png",
                        width: double.infinity,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),

      body:
      load
      ? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                  "assets/images/nike/${productColors.elementAt(imageIndexCurrent).urlImage}",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "BEST SELLER",
                      style: StyleText.styleAirbnb(18, FontWeight.w400, StyleColor.lightBlueColor),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "${product?.name}",
                      style: StyleText.styleAirbnb(28, FontWeight.w500, StyleColor.darkBlueColor),
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.28,
                      child: Text(
                        "${product?.description} ",
                        maxLines: 4,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: StyleColor.blueGreyColor,
                          fontFamily: "Airbnb",
                          ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Gallery",
                      style: StyleText.styleAirbnb(22, FontWeight.w500, StyleColor.darkBlueColor),
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productColors.length,
                        itemBuilder: (context, index) {

                          return GestureDetector(
                            onTap: ()  async{
                              imageIndexCurrent =  index;
                              List<String> fetchListSize = await DBHelper.getSizesByProductColorId(productColors.elementAt(imageIndexCurrent).id);
                              List<ProductSize> fetchProductSizes = await DBHelper.getProductSizesByColorId(productColors.elementAt(imageIndexCurrent).id);
                              setState(() {
                                sizes = fetchListSize;
                                productSizes = fetchProductSizes;
                                quantity = 1;
                                sizeIndexCurrent = 0;
                                for(ProductSize productSize in productSizes){
                                  if(productSize.amount == 0){
                                    sizeIndexCurrent++;
                                  }else{
                                    return;
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: (imageIndexCurrent == index)
                                          ? StyleColor.lightBlueColor
                                          : StyleColor.backgroundColor,
                                      width: 2,
                                    ),
                                    color: StyleColor.backgroundColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Transform.rotate(
                                      angle: -30 * 3.14 / 180,
                                      child: Image.asset(
                                        "assets/images/nike/${productColors.elementAt(index).urlImage}",
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Size",
                          style: StyleText.styleAirbnb(22, FontWeight.w500, StyleColor.darkBlueColor),
                        ),
                        Row(
                          children: [
                            Text(
                                "EU",
                              style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                                "US",
                              style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.blueGreyColor),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              "UK",
                              style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.blueGreyColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizes.length,
                        itemBuilder: (context, index){
                          if(productSizes.elementAt(index).amount != 0) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  sizeIndexCurrent = index;
                                  quantity = 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: (sizeIndexCurrent == index)
                                        ? StyleColor.lightBlueColor
                                        : StyleColor.backgroundColor,
                                  ),
                                  child: Center(
                                      child: Text(
                                        sizes.elementAt(index),
                                        style: (sizeIndexCurrent == index)
                                            ? StyleText.styleAirbnb(
                                            16, FontWeight.w400, Colors.white)
                                            : StyleText.styleAirbnb(
                                            16, FontWeight.w400,
                                            StyleColor.blueGreyColor),
                                      )),
                                ),
                              ),
                            );
                          }else{
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: const Color(0xFFF8F9FA),
                                ),
                                child: Center(
                                    child: Text(
                                      sizes.elementAt(index),
                                      style:  StyleText.styleAirbnb(
                                          16, FontWeight.w400,
                                         const Color(0xFFDBDEDF)),
                                    )),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Price:",
                              style: StyleText.styleAirbnb(22, FontWeight.w500, StyleColor.darkBlueColor),
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              "\$${productSizes.elementAt(sizeIndexCurrent).price}",
                              style: StyleText.styleAirbnb(22, FontWeight.w500, StyleColor.blueGreyColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Amount:",
                              style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.darkBlueColor),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              "${productSizes.elementAt(sizeIndexCurrent).amount}",
                              style: StyleText.styleAirbnb(16, FontWeight.w500, StyleColor.blueGreyColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: StyleColor.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if(quantity >= 2){
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                iconSize: 18,
                                icon: const Icon(
                                  Icons.remove,
                                  color: StyleColor.darkBlueColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              "$quantity",
                              style: StyleText.styleAirbnb(24, FontWeight.w500, StyleColor.darkBlueColor),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: StyleColor.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(quantity < productSizes.elementAt(sizeIndexCurrent).amount){
                                      quantity++;
                                    }
                                  });
                                },
                                iconSize: 18,
                                icon: const Icon(
                                    Icons.add,
                                    color: StyleColor.darkBlueColor
                                ),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: StyleColor.lightBlueColor,
                            ),
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              child: Center(
                                child: Text(
                                  "Add To Cart",
                                  style: StyleText.styleAirbnb(18, FontWeight.w500, Colors.white),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
