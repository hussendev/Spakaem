import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:sapakem/cubit/home/home_states.dart';
import 'package:sapakem/cubit/home/merchant/merchant_cubit.dart';
import 'package:sapakem/cubit/home/merchant/merchant_states.dart';
import 'package:sapakem/widgets/app_text.dart';

import '../../../widgets/merchant/merchant_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<MerchantCubit,MerchantStates>(
      builder: (context, state) {
        if(state is LoadingMerchantState){
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }else if(state is SuccessLoadedMerchantState){
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height:  MediaQuery.of(context).size.height,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.merchants.length,


                    itemBuilder:  (context, index) => MerchantWidget(merchant: state.merchants[index],)

                )
              ),
            )
          );
        }else {
          state as FavoriteMerchantEmptyState;
          return  Scaffold(body: Center(child: AppText(text: state.message.toString(), fontSize: 20.sp,color: Colors.black, ),));
        }
      },
      bloc: context.read<MerchantCubit>()..getMerchantsFavorite(),
      buildWhen: (previous, current) => current is SuccessLoadedMerchantState || current is LoadingMerchantState || current is FavoriteMerchantEmptyState || current is FavoriteMerchantEmptyState,

    );
  }
}