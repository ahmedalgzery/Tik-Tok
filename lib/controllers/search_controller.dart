import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/user.dart';

class Search extends GetxController {
  // Private variable to hold the list of searched users
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  // Getter to access the list of searched users from external classes
  List<User> get searchedUsers => _searchedUsers.value;

  // Method to search for users based on the provided query
  // It's marked as asynchronous since it involves Firestore queries
  searchUser(String typedUser) async {
    // Bind the _searchedUsers list to a Firestore query
    _searchedUsers.bindStream(
      // Create a Firestore query to search for users
      firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map((QuerySnapshot query) {
        // Initialize an empty list to store matching users
        List<User> retVal = [];
        
        // Iterate through the documents returned by the query
        for (var elem in query.docs) {
          // Convert each document to a User object and add it to the list
          retVal.add(User.fromSnap(elem));
        }

        // Return the list of matching users
        return retVal;
      }),
    );
  }
}
