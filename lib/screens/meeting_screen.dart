import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom/resources/jitsi_meet_methods.dart';
import 'package:zoom/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async{
    var random = Random();
    String roomName = (random.nextInt(100000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(roomName: roomName, isAudioMuted: true, isVideoOff: true);
  }
  joinMeeting(BuildContext context){
    Navigator.pushNamed(context, '/video-call');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onpressed:createNewMeeting,
              icon: Icons.videocam,
              text: 'New Meeting',
            ),
    
            HomeMeetingButton(
              onpressed: () => joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: 'Join Meeting',
            ),
    
            HomeMeetingButton(
              onpressed: () {},
              icon: Icons.calendar_today,
              text: 'Schedule',
            ),
    
            HomeMeetingButton(
              onpressed: () {},
              icon: Icons.arrow_upward_rounded,
              text: 'Share Screen',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create or Join Meetings with just a click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
      ],
    );
  }
}