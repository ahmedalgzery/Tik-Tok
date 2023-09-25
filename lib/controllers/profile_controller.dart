import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  // Method to update the user ID and fetch user data
  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  // Method to fetch user data from Firestore
  getUserData() async {
    List<String> thumbnails = [];

    // Query Firestore to get the user's videos
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    // Extract video thumbnails from the user's videos
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    // Query Firestore to get the user's profile data
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    // Calculate the total number of likes on the user's videos
    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    // Query Firestore to get the user's followers
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    // Query Firestore to get the user's following
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    // Update followers and following counts
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    // Check if the current user is following this user
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    // Update the user data map with the fetched information
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };

    // Notify listeners about the data update
    update();
  }

  // Method to follow or unfollow a user
  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      // If the current user is not following, add them as a follower
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      // Update the follower count
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      // If the current user is already following, unfollow them
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      // Update the follower count
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }

    // Toggle the 'isFollowing' status
    _user.value.update('isFollowing', (value) => !value);
    // Notify listeners about the data update
    update();
  }
}
