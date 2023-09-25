// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  // Initialize a TextEditingController for handling user comments.
  final TextEditingController _commentController = TextEditingController();

  // Get the CommentController instance for managing comments.
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Update the post ID in the CommentController to fetch comments for this post.
    commentController.updatePostId(id);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  // Display the list of comments as a scrollable list.
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          // Display user profile photo in a circle avatar.
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // Display the username of the commenter.
                                  "${comment.username}  ",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  // Display the comment text.
                                  comment.comment,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                // Display the relative time of the comment.
                                tago.format(
                                  comment.datePublished.toDate(),
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                // Display the number of likes for the comment.
                                '${comment.likes.length} likes',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Icon(
                              // Display a heart icon for liking the comment.
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authController.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () =>
                        commentController.postComment(_commentController.text),
                    icon: Icon(
                      // Display a paper plane icon for posting comments.
                      FontAwesomeIcons.solidPaperPlane,
                      color: buttonColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
