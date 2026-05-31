import 'package:flutter/material.dart';
import 'package:pertemuan8_1/models/post_model.dart';
import 'package:pertemuan8_1/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel> posts = [];

  bool isLoading = false;
  String errorMessage = '';

  Future<void> getPosts() async {
    try {
      isLoading = true;
      notifyListeners();
      posts = await PostService.getPosts();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}