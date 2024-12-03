import 'package:cloud_firestore/cloud_firestore.dart';

class UserViewModel {


  Future<void> saveUserToFirestore(
      bio, city, country, email, firstName, lastName, id) async {
    Map<String, dynamic> dataMap = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'bio': bio,
      'city': city,
      'country': country,
      'isHost': false,
    };
    await FirebaseFirestore.instance.collection('users').doc(id).set(dataMap);
  }
}
