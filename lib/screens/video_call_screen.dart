import 'package:flutter/material.dart';
import 'package:jitsi_meet_v1/jitsi_meet.dart';
import 'package:zoom/resources/auth_methods.dart';
import 'package:zoom/resources/jitsi_meet_methods.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/meeting_options.dart';
class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController TextController;
  late TextEditingController NameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoOff = true;

  _joinMeeting(){
    _jitsiMeetMethods.createMeeting(
      roomName: TextController.text,
      isAudioMuted: isAudioMuted,
      isVideoOff: isVideoOff,
      username: NameController.text,
    );
  }

  @override
  void initState() {
    TextController = TextEditingController();
    NameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
    TextController.dispose();
    NameController.dispose();
    JitsiMeet.removeAllListeners();
  }
  onAudioMuted(bool? value){
    setState(() {
      isAudioMuted = value!;
    });
  }

  onVideoMuted(bool? value){
    setState(() {
      isVideoOff = value!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: TextController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room Id',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),

          SizedBox(
            height: 60,
            child: TextField(
              controller: NameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),

          const SizedBox(height: 20),

          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Join',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          MeetingOptions(text: 'Audio', isMute: isAudioMuted, onChanged:onAudioMuted,),
          MeetingOptions(text: 'Video ', isMute: isVideoOff, onChanged:onVideoMuted,),
        ],
      ),
    );
  }
}