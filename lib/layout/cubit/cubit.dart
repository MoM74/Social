import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_Social/layout/cubit/states.dart';
import 'package:fire_Social/models/message_model.dart';
import 'package:fire_Social/models/outfit_post_model.dart';
import 'package:fire_Social/models/outfit_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/comment_model.dart';
import '../../../shared/components/constants.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds.dart';
import '../../modules/login/login_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/users/users_screen.dart';
import '../../shared/components/components.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
//-----------------------------------------------------------------------------
  UserModel? model;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data() as Map<String, dynamic>);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

//-----------------------------------------------------------------------------
  int currentIndex = 0;
  void changeBottomNav(int index) {
    if (index == 3) {
      getFavoritesList();
      getWatchLaterList();
    }
    if (index == 4) {
      getUserPostsLength();
      getUserFollowersLength();
    }
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  List<Widget> bottomScreens = [
    FeedScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chat',
    'Post',
    'Category',
    'Profile',
  ];
//-----------------------------------------------------------------------------
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUserUpdateLoadingState());
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      uId: model!.uId,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      emit(SocialUserUpdateSuccessState());
      getUserData();
    }).catchError((error) {
      debugPrint('error f UserUpdate');
      emit(SocialUserUpdateErrorState());
    });
  }

//___________________ profileImage ________________________________________
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  //___________________________________________________________________________
  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

//___________________________________________________________________________
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

//___________________________________________________________________________
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  //______________________ postGalleryImage _____________________________________
  File? postImage;
  Future<void> getPostGalleryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> getPostCameraImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }
  //___________________________________________________________

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }
  //___________________________________________________________

  void uploadPostImage({
    required String dateTime,
    required String text,
    String? location,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
          location: location ?? '',
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  //__________________ createPost _________________________________________
  PostModel? post;
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
    String? location,
  })
//async
  {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      location: location ?? '',
    );
//await
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

//--------------------- remove post -------------------------------
  void removePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((_) {
      print("Post successfully deleted!");
      // Delete the comments for the post
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
        print("Comments successfully deleted!");
      });
      // Delete the likes for the post
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
        print("Likes successfully deleted!");
      });
      // Delete the rates for the post
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('rate')
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
        print("Rate successfully deleted!");
      });

      emit(SocialRemovePostSuccessState());
    }).catchError((error) {
      emit(SocialRemovePostErrorState());
    });
  }

//_______________________ getPosts ____________________________________
  List<PostModel> posts = [];
  List<String> postsId = [];
  Map<String, int> likesNumber = {};
  Map<String, int> commentsNumber = {};

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("dateTime", descending: true)
        .get()
        .then((val) {
      posts = [];

      for (var post in val.docs) {
        post.reference.collection('comments').get().then((value) {
          commentsNumber.addAll({
            post.id: value.docs.length,
          });
        }).catchError((error) {});
      }

      for (var post in val.docs) {
        post.reference.collection('likes').get().then((value) {
          likesNumber.addAll({
            post.id: value.docs.length,
          });
          postsId.add(post.id);
          posts.add(PostModel.fromJson(post.data()));
        }).catchError((error) {});
      }

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void unlikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .delete()
        .then((value) {
      emit(SocialUnlikePostSuccessState());
    }).catchError((error) {
      emit(SocialUnlikePostErrorState(error.toString()));
    });
  }

// ____________________________________
  CommentModel? comment;
  void createComment({
    required String dateTime,
    required String commentText,
    String? commentImage,
    required String postId,
  }) {
    emit(SocialCreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      postId: postId,
      dateTime: dateTime,
      commentText: commentText,
      commentImage: commentImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessState());
    }).catchError((error) {
      emit(SocialCreateCommentErrorState());
    });
  }

  //____________________ getComments _______________________________________
  List<CommentModel> comments = [];
  void getComments({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
      emit(SocialGetCommentsSuccessState());
    }).catchError((error) {
      emit(SocialGetCommentsErrorState(error.toString()));
    });
  }

//_________________ userPosts _________________________
  List<int> userPosts = [];
  var postLength;
  var PostUId;
  void getUserPostsLength() {
    emit(SocialGetMessageLoginState());
    userPosts = [];
    var userPostsCount = FirebaseFirestore.instance.collection('posts');
    userPostsCount.where('uId', isEqualTo: uId).get().then((value) {
      for (var element in value.docs) {
        userPosts.add(element.data().length);
      }
      postLength = userPosts.length;

      emit(SocialGetUserPostsLengthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserPostsLengthErrorState());
    });
  }

//________________________ Followers _______________________________________________
  void addFollowers({
    String? name,
    String? uId,
    String? image,
  }) {
    emit(SocialAddToFollowersLoadingState());
    UserModel userModel = UserModel(
      uId: uId,
      image: image,
      name: name,
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("FollowersList")
        .add(userModel.toMap())
        .then((value) {
      emit(SocialAddToFollowersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialAddToFollowersErrorState());
    });
  }

  List<int> followers = [];
  void getUserFollowersLength() {
    followers = [];
    emit(SocialGetUserFollowersLengthLoadingState());
    var userFollowersCount = FirebaseFirestore.instance.collection('user');
    userFollowersCount.doc(uId).collection("FollowersList").get().then((value) {
      for (var element in value.docs) {
        followers.add(element.data().length);
      }
      emit(SocialGetUserFollowersLengthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserFollowersLengthErrorState());
    });
  }

//_________________ Favorites and WatchLater ___________________________________________________
  void addToFavorites({
    required String name,
    required String image,
    required String dateTime,
    String? location,
    String? uId,
    String? text,
    String? postImage,
    String? postsId,
  }) {
    emit(SocialAddToFavoritesLoadingState());
    PostModel postModel = PostModel(
      dateTime: dateTime,
      uId: uId,
      image: image,
      name: name,
      postImage: postImage ?? '',
      text: text ?? '',
      location: location ?? '',
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("favoritesList")
        .add(postModel.toMap())
        .then((value) {
      emit(SocialAddToFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialAddToFavoritesErrorState());
    });
  }

  List<PostModel> favoritesList = [];
  void getFavoritesList() {
    favoritesList = [];
    emit(SocialGetFavoritesLoadingState());
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("favoritesList")
        .get()
        .then((value) {
      for (var element in value.docs) {
        favoritesList.add(PostModel.fromJson(element.data()));
      }
      print(favoritesList.length);
      emit(SocialGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetFavoritesErrorState());
    });
  }

  void removeFromFavorites(postId) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("favoritesList")
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialRemoveFromFavoritesSuccessState());
    }).catchError((error) {
      emit(SocialRemoveFromFavoritesErrorState());

      print(error);
    });
  }

  void addToWatchLater({
    required String name,
    String? uId,
    required String image,
    required String dateTime,
    String? text,
    String? location,
    String? postImage,
    String? postsId,
  }) {
    emit(SocialAddToWatchLaterLoadingState());
    PostModel postModel = PostModel(
      dateTime: dateTime,
      uId: uId,
      image: image,
      name: name,
      postImage: postImage ?? '',
      text: text ?? '',
      location: location ?? '',
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("watchlaterList")
        .add(postModel.toMap())
        .then((value) {
      emit(SocialAddToWatchLaterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialAddToWatchLaterErrorState());
    });
  }

  List<PostModel> watchLaterList = [];
  void getWatchLaterList() {
    watchLaterList = [];
    emit(SocialGetWatchLaterLoadingState());
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("watchlaterList")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        watchLaterList.add(PostModel.fromJson(element.data()));
      });
      print(favoritesList.length);
      emit(SocialGetWatchLaterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetWatchLaterErrorState());
    });
  }

//_________________ Chats ________________________
  List<UserModel> users = [];
  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("user").get().then((value) {
        for (var element in value.docs) {
          if (element['uId'] != model!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
          emit(SocialGetAllUsersSuccessState());
        }
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String reciverId,
    required String text,
    required String dateTime,
  }) {
    emit(SocialSendMessageLoadingState());
    MessagerModel messagerModel = MessagerModel(
      senderId: model!.uId,
      reciverId: reciverId,
      text: text,
      dateTime: dateTime,
    );
    // my message
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
    // reciver message
    FirebaseFirestore.instance
        .collection("user")
        .doc(reciverId)
        .collection("chats")
        .doc(model!.uId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
  }

  List<MessagerModel> message = [];
  void getMessages({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(model!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      for (var element in event.docs) {
        message.add(
          MessagerModel.fromJson(element.data()),
        );
      }
      emit(SocialGetMessageSuccessState());
    });
  }

//_____________________________________________________
  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      navigateTo(context, LoginScreen());
      emit(SocialUserSignOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserSignOutErrorState());
    });
  }

//----------------------------------------
  List<UserModel> searchData = [];
  void searchForUser({required String input}) {
    searchData = [];
    emit(SearchForUserLoadingState());
    // arrayContain will get all userName that contain input which user will type on textFormField
    FirebaseFirestore.instance
        .collection('user')
        .where('name', whereIn: [input])
        .get()
        .then((value) {
          for (var element in value.docs) {
            searchData.add(UserModel.fromJson(element.data()));
            emit(SearchForUserSuccessState());
          }
        });
  }
//------------------------------------------------------

}
