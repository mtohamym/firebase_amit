import 'package:firebase/feature/home_screen/view/widget/home_screen_header.dart';
import 'package:firebase/feature/home_screen/view/widget/recent_transactions_body.dart';
import 'package:firebase/feature/home_screen/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_payment_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getTransactions(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    HomeCubit().get(context).getTransactions();
                  },
                ),
                title: const Text(
                  'My Wallet',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              body: const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [HomeScreenHeader(), RecentTransactionBody()],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPayemntTranctions()));
                },
                child: const Icon(Icons.add),
              ));
        },
      ),
    );
  }
}
