import 'package:fire_Social/models/outfit_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/message_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class ChatsDetailsScreen extends StatelessWidget {
  UserModel? model;
  ChatsDetailsScreen({super.key, this.model});
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(reciverId: model!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if (state is SocialSendMessageSuccessState) {
              messageController.clear();
            }
            // if (state is SocialGetMessageSuccessState) {
            //   ScrollDragController.momentumRetainVelocityThresholdFactor;
            // }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          '${model!.image}',
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${model!.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).message[index];
                            if (SocialCubit.get(context).model!.uId ==
                                message.senderId)
                              return bulidMyMessage(message);

                            return bulidMessage(message);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: SocialCubit.get(context).message.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400]!,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.grey,
                                  size: 28,
                                )),
                            const SizedBox(height: 10),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Message...",
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              height: 48,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        reciverId: model!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  },
                                  icon: const Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  Widget bulidMessage(MessagerModel messagerModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          child: Text("${messagerModel.text}"),
        ),
      );
  Widget bulidMyMessage(MessagerModel messagerModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          child: Text("${messagerModel.text}"),
        ),
      );
}
