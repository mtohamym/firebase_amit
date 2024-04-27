import 'package:flutter/material.dart';

import '../../view_model/home_cubit.dart';

class PaymentHistoryItem extends StatelessWidget {
  const PaymentHistoryItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit().get(context);

    return ListTile(
      onLongPress: ()=> cubit.deleteTransaction(
      cubit.transactions[index].id! , index),


      leading: const Icon(
        Icons.account_balance_wallet_outlined,
        color: Colors.blue,
      ),
      title: Text(
        cubit.transactions[index].locationName!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        cubit.transactions[index].description!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Text(
        '-\$${cubit.transactions[index].amount!}',
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
