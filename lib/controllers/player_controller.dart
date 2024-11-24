import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

final audioQuery = OnAudioQuery();
final audioPlayer = AudioPlayer();

var playIndex = 0.obs;
var isPlaying = false.obs;

// var duration = ''.obs;
// var position = ''.obs;

var duration = '00:00'.obs;
var position = '00:00'.obs;

var max = 0.0.obs;
var value = 0.0.obs;

@override
  void onInit(){
  super.onInit();
  checkPermission();

}

 String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }


void updatePosition() {
    audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration.value = formatDuration(d);
        max.value = d.inSeconds.toDouble();
      }
    });



   audioPlayer.positionStream.listen((p) {
      position.value = formatDuration(p);
      value.value = p.inSeconds.toDouble();
    });
  }



changeDurationToSeconds(seconds){
  var duration = Duration(seconds: seconds);
  audioPlayer.seek(duration);
}

playSong(String? uri, index){
  playIndex.value = index;

try {
  
   audioPlayer.setAudioSource(
    AudioSource.uri(Uri.parse(uri!)),
    );
    audioPlayer.play();
    isPlaying(true);
    updatePosition();
}on Exception catch (e) {
  debugPrint(e.toString());
}
}

checkPermission()async{
  var perm = await  Permission.storage.request();
  if(perm.isGranted){

  }else{
    checkPermission();
  }
}


}