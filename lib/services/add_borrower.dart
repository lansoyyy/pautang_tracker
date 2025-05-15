import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> addBorrower(
    name, gender, contactNumber, address, note, myId) async {
  final docUser = FirebaseFirestore.instance.collection('Borrower').doc();

  final json = {
    'myId': myId,
    'name': name,
    'gender': gender,
    'contactNumber': contactNumber,
    'address': address,
    'note': note,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'year': DateTime.now().year,
    'month': DateTime.now().month,
    'day': DateTime.now().day,
  };

  await docUser.set(json);

  return docUser.id;
}
