import 'package:firebase/feature/home_screen/view/widget/payment_history_item.dart';
import 'package:firebase/feature/home_screen/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentTransactionBody extends StatelessWidget {
  const RecentTransactionBody({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit().get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            cubit.transactions.length == 0
                ? const Center(
                    child: Text(
                      'No Transactions Found',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                :
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.transactions.length,
              itemBuilder: (context, index) {
                return PaymentHistoryItem(index: index);
              },)
          ],
        );
      },
    );
  }
}
