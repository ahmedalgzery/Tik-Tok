// Import necessary packages
// ignore_for_file: library_private_types_in_public_api is used to ignore specific linting rules in this file, deprecated_member_use, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// A StatefulWidget that represents a video player item
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  // Constructor for VideoPlayerItem that takes a videoUrl parameter
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

// The state class for VideoPlayerItem
class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // Declare a VideoPlayerController
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController with the provided video URL
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        // Initialize and play the video when it's initialized
        videoPlayerController.play();
        
        // Set the volume of the video to maximum
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    
    // Dispose of the VideoPlayerController when it's no longer needed
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Return a Container with a black background containing the VideoPlayer widget
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
