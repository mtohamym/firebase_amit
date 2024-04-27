import 'package:firebase/feature/home_screen/view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddPayemntTranctions extends StatelessWidget {
  const AddPayemntTranctions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is TransactionsSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message:
                    "Transaction Added Successfully",
              ),
            );
          } else if (state is TransactionsFail) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message:
                    "Transaction Failed",
              ),
            );
          }
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit().get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Add Payment Transaction',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Payment Transaction Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: cubit.locationController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter Location Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: cubit.amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: cubit.descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: cubit.dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: 'Enter Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    state is TransactionsLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              cubit.addTransaction();
                            },
                            child: const Text('Add Transaction'),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
