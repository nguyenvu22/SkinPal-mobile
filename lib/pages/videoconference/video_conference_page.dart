import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/pages/videoconference/video_conference_controller.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceId;
  VideoConferencePage({super.key, required this.conferenceId});

  VideoConferenceController con = Get.put(VideoConferenceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID:
            1527383132, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            '7b878050d86e908b7ebd9d94b67de59c619cbaefc7097aee0bc50949ff801981', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: con.userSession.id.toString(),
        userName: con.userSession.name!,
        conferenceID: conferenceId,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
