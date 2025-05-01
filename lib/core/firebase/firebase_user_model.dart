import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/auth_entity/login_entity.dart';
import '../cache/shared_pref.dart';

class FirebaseFunc {
  /// Adds a new user to the users collection
  static addUser(LoginEntity user) {
    var collection = getUsersCollection();
    var docref = collection.doc(user.id.toString());
    docref.set(user);
  }

  /// Returns a reference to the users collection
  static CollectionReference<LoginEntity> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<LoginEntity>(
      fromFirestore: (snapshot, _) => LoginEntity.fromJson(snapshot.data()!),
      toFirestore: (value, _) => value.toJson(),
    );
  }

  /// Reads user data from Firestore using the stored user ID
  static Future<LoginEntity?> ReadUserData() async {
    // Retrieve the user ID from SharedPreferences
    String? userId = await CacheHelper.getData<String>('userId');

    if (userId != null) {
      var collection = getUsersCollection();
      DocumentSnapshot<LoginEntity> docUser =
      await collection.doc(userId).get();
      return docUser.data();
    } else {
      print("User ID not found in SharedPreferences");
      return null;
    }
  }


}
