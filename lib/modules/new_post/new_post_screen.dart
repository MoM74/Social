import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../feeds/feeds.dart';

class NewPostScreen extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          SocialCubit.get(context).getPosts();
          Navigator.pop(context);
          showToast(
            text: 'Your Post Successfully added',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is SocialCreatePostErrorState) {
          showToast(
            text: 'Your post failed to upload',
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        var postImageFile = SocialCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create post"),
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            actions: [
              defaultTextButton(
                function: () {
                  final now = DateTime.now();
                  if (SocialCubit.get(context).postImage != null) {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                      location: locationController.text,
                    );
                  } else {
                    if (textController.text != '') {
                      SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                        location: locationController.text,
                      );
                    } else {
                      showToast(
                        text: 'Please write post or add photo ',
                        state: ToastStates.ERROR,
                      );
                    }
                  }
                },
                text: "Post",
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(height: 15),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        "${SocialCubit.get(context).model?.image}",
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${SocialCubit.get(context).model?.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Public',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.4,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText:
                          "What's on your mind ${SocialCubit.get(context).model?.name} ...",
                      border: InputBorder.none,
                    ),
                    //cursorHeight: 20,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 10),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          image: DecorationImage(
                            image: FileImage(postImageFile!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Write a Location ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      IconBroken.Location,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, height: 1),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          ShowModel(context);
                        },
                        child: Row(
                          children: const [
                            Icon(IconBroken.Image_2),
                            SizedBox(width: 5.0),
                            Text("add photos")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Icon(IconBroken.Location),
                            SizedBox(width: 5.0),
                            Text("Location")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void ShowModel(context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          padding: const EdgeInsetsDirectional.only(top: 10),
          decoration: const BoxDecoration(
            //color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).getPostGalleryImage();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Image_2,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "From Gallery ",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Choose Image From Gallery",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).getPostCameraImage();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Camera,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "From Camera",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Choose Image From Camera",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
