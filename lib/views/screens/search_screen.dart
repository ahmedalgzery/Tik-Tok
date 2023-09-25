import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/search_controller.dart';
import 'package:tiktok/models/user.dart';
import 'package:tiktok/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  // Initialize the Search controller using GetX
  final Search searchController = Get.put(Search());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 35),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(.4),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    filled: true,
                    labelText: 'Search',
                    labelStyle: const TextStyle(color: Colors.grey)),
                // Callback when text is saved (enter key pressed)
                onSaved: (value) => searchController.searchUser(value!),
                // Callback when user submits the text
                onFieldSubmitted: (value) => searchController.searchUser(value),
              ),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Icon(
                    FontAwesomeIcons.tiktok,
                    size: 250,
                    shadows: [
                      Shadow(
                          blurRadius:
                              .50 * const MediaQueryData().devicePixelRatio,
                          color: Colors.red,
                          offset: const Offset(5, 5)),
                      Shadow(
                          blurRadius:
                              .50 * const MediaQueryData().devicePixelRatio,
                          color: Colors.blue,
                          offset: const Offset(-5, -5)),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    User user = searchController.searchedUsers[index];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(uid: user.uid),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePhoto,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }
}
