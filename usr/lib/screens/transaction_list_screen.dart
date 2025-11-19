import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_item.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'Salary', amount: 2500, date: DateTime.now(), type: TransactionType.income),
    Transaction(id: 't2', title: 'Groceries', amount: 150, date: DateTime.now().subtract(const Duration(days: 1)), type: TransactionType.expense),
    Transaction(id: 't3', title: 'Rent', amount: 800, date: DateTime.now().subtract(const Duration(days: 2)), type: TransactionType.expense),
  ];

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Transactions'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: _transactions.isEmpty
          ? const Center(child: Text('No transactions added yet.'))
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  transaction: _transactions[index],
                  deleteTransaction: _deleteTransaction,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTransaction = await Navigator.push<Transaction>(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
          );
          if (newTransaction != null) {
            _addTransaction(newTransaction);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
