import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addPaymentHistory(
    String loanId, int amount, String date, userData) async {
  final docUser = FirebaseFirestore.instance
      .collection('Payment History')
      .doc(DateTime.now().toString());

  final json = {
    'loanId': loanId,
    'amount': amount,
    'date': date,
    'borrowerData': userData,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'year': DateTime.now().year,
    'month': DateTime.now().month,
    'day': DateTime.now().day,
  };

  await docUser.set(json);

  return docUser.id;
}
