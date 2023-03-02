import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class FollowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Followers",
                style: TextStyle(
                  fontSize: 16,
                )),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => FollowerItemBuilder(
              SocialCubit.get(context).followers.length,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemCount: SocialCubit.get(context).followers.length,
          ),
        );
      },
    );
  }

  Widget FollowerItemBuilder(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: const [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  //'${model!.image}',
                  'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-Social-against-blue-background_1258-66609.jpg?w=740&t=st=1665498298~exp=1665498898~hmac=16c3f29b8236115ed05852d2113a80bb4eea31bc2a08dd2ce71b25510643e7af',
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                //'${model.name}',
                'Follower name',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
}
