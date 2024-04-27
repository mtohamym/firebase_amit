part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class TransactionsLoading extends HomeState {}
class TransactionsSuccess extends HomeState {}
class TransactionsFail extends HomeState {}


