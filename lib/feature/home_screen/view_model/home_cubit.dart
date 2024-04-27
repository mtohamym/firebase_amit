import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/transaction.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  TextEditingController locationController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  HomeCubit get(context) => BlocProvider.of(context);

  final db = FirebaseFirestore.instance;

  Future<void> addTransaction() async {
    emit(TransactionsLoading());
    TransactionModel transaction = TransactionModel(
      locationName: locationController.text,
      amount: amountController.text,
      date: dateController.text,
      description: descriptionController.text,
    );
    await db
        .collection("transactions")
        .doc() // auto generate id
        .set(transaction.toJson())
        .then((value) {
      clearControllers();
      emit(TransactionsSuccess());
    }).onError((error, stackTrace) {
      debugPrint('Transaction Failed ${error.toString()}');
      emit(TransactionsFail());
    });
  }

  List<TransactionModel> transactions = [];

  Future<void> getTransactions() async {
    emit(TransactionsLoading());
    transactions.clear();
    db.collection("transactions").get().then((querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        transactions.add(TransactionModel.fromJson(
            querySnapshot.docs[i].data(), querySnapshot.docs[i].id));
      }
      debugPrint('Transactions ${transactions.length}');
      emit(TransactionsSuccess());
    }).onError((error, stackTrace) {
      debugPrint('Transaction Failed ${error.toString()}');
      emit(TransactionsFail());
    });
  }

  void clearControllers() {
    locationController.clear();
    amountController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  Future<void> deleteTransaction(String id, int index) async {
    emit(TransactionsLoading());
    await db.collection("transactions").doc(id).delete().then((value) {
      transactions.removeAt(index);
      emit(TransactionsSuccess());
    }).onError((error, stackTrace) {
      debugPrint('Transaction Failed ${error.toString()}');
      emit(TransactionsFail());
    });
  }

  get totalAmount {
    double total = 0;
    transactions.forEach((element) {
      total += double.parse(element.amount!);
    });
    return total;
  }
}
