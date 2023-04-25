import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapakem/model/home/product.dart';
import 'package:sapakem/screens/app/merchant/product_details.dart';

import '../app_text.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));

        // AppDialog.productOrder(
        //   context,
        //   'assets/logo_app_bar.svg',
        //   (numberOfItems) {
        //     print(numberOfItems);
        //   },
        // );
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 5.w),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(10.r))),
        height: 141.h,
        width: 113.w,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.mainImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                width: double.infinity,
                // color: Colors.blue,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: product.description!.length > 10 ? '${product.name!.substring(0, 10)}...' : product.name!,
                          fontSize: 13.sp,
                          color: Colors.black,
                        ),
                        AppText(
                          text: product.description!.length > 10 ? '${product.description!.substring(0, 10)}...' : product.description!,
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: AppText(
                          text: product.price.toString(),
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
