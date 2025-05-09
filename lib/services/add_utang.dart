import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addUtang(
    String borrowerId,
    String name,
    String typeOfUtang,
    int interest,
    String paymentTerms,
    String dueDate,
    String myId,
    double amount,
    borrowerData,
    double payment,
    int duration) async {
  final docUser = FirebaseFirestore.instance.collection('Utang').doc();

  final json = {
    'borrowerId': borrowerId,
    'payment': payment,
    'name': name,
    'duration': duration,
    'typeOfUtang': typeOfUtang,
    'interest': interest,
    'paymentTerms': paymentTerms,
    'dueDate': dueDate,
    'myId': myId,
    'amount': amount,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'year': DateTime.now().year,
    'month': DateTime.now().month,
    'day': DateTime.now().day,
    'isPaid': false,
    'borrowerData': borrowerData,
  };

  await docUser.set(json);

  return docUser.id;
}
