import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquify/models/app_user.dart';
import 'firestore_constants.dart';

class FirestoreUserService {
  static Future<void> checkAndCreateUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final userReference = FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(firebaseUser.uid);

    final userDocumentSnapshot = await userReference.get();

    if (userDocumentSnapshot.exists == false) {
      try {
        AppUser user = AppUser.temp();
        await userReference.set(user.toJson());
      } catch (e) {
        print(e);
        throw e;
      }
    }
  }

  static Stream<DocumentSnapshot> getUserStream() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final userDocumentStream = FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(firebaseUser.uid).snapshots();
    return userDocumentStream;
  }

  static Future<void> updateWaterNorm(int amount) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> update = Map();
    update.putIfAbsent(AppUser.waterNormField, () => amount);

    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(firebaseUser.uid).update(update);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}