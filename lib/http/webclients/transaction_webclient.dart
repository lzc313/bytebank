import 'dart:convert';

import 'package:bytebank/http/webclient.dart';

import '../../models/contact.dart';
import '../../models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(baseUrl))
        .timeout(const Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions =
    decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
    // List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    // Map<String, dynamic> transactionMap = _toMap(transaction);
    // final String transactionJson = jsonEncode(transactionMap);
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client
        .post(Uri.parse(baseUrl),
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson)
        .timeout(const Duration(seconds: 5));

    return Transaction.fromJson(jsonDecode(response.body));
    // return _toTransactoin(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions =
        decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
    // final List<Transaction> transactions = [];
    // for (Map<String, dynamic> transactionJson in decodedJson) {
    //   // final Map<String, dynamic> contactJson = transactionJson['contact'];
    //   // final Transaction transaction = Transaction(
    //   //   transactionJson['value'],
    //   //   Contact(
    //   //     0,
    //   //     contactJson['name'],
    //   //     contactJson['accountNumber'],
    //   //   ),
    //   // );
    //   // transactions.add(transaction);
    //   transactions.add(Transaction.fromJson(transactionJson));
    // }
    return transactions;
  }

  Transaction _toTransactoin(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
    // final Map<String, dynamic> contactJson = json['contact'];
    // return Transaction(
    //   json['value'],
    //   Contact(
    //     0,
    //     contactJson['name'],
    //     contactJson['accountNumber'],
    //   ),
    // );
  }

// Map<String, dynamic> _toMap(Transaction transaction) {
//   final Map<String, dynamic> transactionMap = {
//     'value': transaction.value,
//     'contact': {
//       'name': transaction.contact.name,
//       'accountNumber': transaction.contact.accountNumber,
//     },
//   };
//   return transactionMap;
// }
}
