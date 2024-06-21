import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:medicnest_pro/config/strings.dart';
import 'package:permission_handler/permission_handler.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});
  static const String id = 'videoCallScreen';

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

// Application state class
class _VideoCallScreenState extends State<VideoCallScreen> {
  int? _remoteUid; // The UID of the remote user
  bool _localUserJoined = false; // Indicates whether the local user has joined the channel
  late RtcEngine _engine; // The RtcEngine instances

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // Get microphone and camera permissions
    await [Permission.microphone, Permission.camera].request();

    // Create RtcEngine instance
    _engine = createAgoraRtcEngine();

    // Initialize RtcEngine and set the channel profile to live broadcasting
    await _engine.initialize(const RtcEngineContext(
      appId: Strings.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // Add an event handler
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        // Occurs when the local user joins the channel successfully
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('local user ${connection.localUid} joined');
          setState(() {
            _localUserJoined = true;
          });
        },
        // Occurs when a remote user join the channel
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        // Occurs when a remote user leaves the channel
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    // Enable the video module
    await _engine.enableVideo();
    // Enable local video preview
    await _engine.startPreview();
    // Join a channel
    await _engine.joinChannel(
      token: Strings.agoraToken,
      channelId: 'MedicNestDemo',
      options: const ChannelMediaOptions(
        // Set the user role as host
        // To set the user role to audience, change clientRoleBroadcaster to clientRoleAudience
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
      uid: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }


  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  child: _localUserJoined
                      ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                      : const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        );
  }

  // Widget to display remote video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: 'MedicNestDemo'),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}