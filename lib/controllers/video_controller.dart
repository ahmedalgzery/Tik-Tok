import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/video.dart';

class VideoController extends GetxController {
  // Rx variable to hold the list of videos
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  // Getter to access the list of videos
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();

    // Bind the _videoList variable to a Firestore stream
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  // Method to handle liking/unliking a video
  likeVideo(String id) async {
    // Fetch the video document from Firestore
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;

    // Check if the user has already liked the video
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      // If liked, remove the user's like
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      // If not liked, add the user's like
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
