import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquify/models/drink.dart';
import 'firestore_constants.dart';

class FirestoreDrinkService {
  static Stream<QuerySnapshot> getDrinksStream(DateTime date) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    final morningDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final nightDate = DateTime(date.year, date.month, date.day + 1, 0, 0, 0);

    final drinksCollectionStream = FirebaseFirestore.instance
        .collection(FirestoreConstants.userCollection)
        .doc(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection)
        .where('date', isGreaterThan: morningDate)
        .where('date', isLessThan: nightDate)
        .snapshots();
    return drinksCollectionStream;
  }

  static Future<void> drinkWater(Drink drink) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final drinksCollection = FirebaseFirestore.instance
        .collection(FirestoreConstants.userCollection)
        .doc(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection);

    drinksCollection.add(drink.toJson());
  }

  // Метод есть, но использоваться не будет
  static Future<void> removeDrink(Drink drink) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection(FirestoreConstants.userCollection)
        .doc(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection)
        .doc(drink.id)
        .delete();
  }
}