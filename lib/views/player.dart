import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/state_manager.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/theme/palette.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {

  final List<SongModel> data;
  const Player({super.key,required this.data});

  @override
  Widget build(BuildContext context) {

var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(child: Container(
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                 height: 350,
                  width: 350,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  
                ),
                padding: const EdgeInsets.all(8),
              alignment: Alignment.center,  
              
              child: QueryArtworkWidget(
                id: data[controller.playIndex.value].id, 
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: const Icon(Icons.music_note,size: 48, color: white),
                
                ),
              ),
              ),
            ),


            const SizedBox(
              height: 35,
            ),




            Expanded(
              child: Container(
               
                alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))
              ),
                  child: Obx(
                    () => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          data[controller.playIndex.value].displayNameWOExt ,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontFamily: "bold",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        
                           ),
                        ),
                    
                    
                     const SizedBox(
                                  height: 4,
                                ),
                    
                    
                           Text(
                       data[controller.playIndex.value].artist.toString(),
                         textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                         style: customfontStyle(
                          fColor: bgdark,
                          family: regular,
                          size: 12,
                         ) ,
                         ),
                    
                          const SizedBox(
                                  height: 45,
                                ),
                    
                  Obx(
                    () => 
                    Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                         controller.position.value,
                           style: customfontStyle(fColor: bgdark),
                           ),
                      ),
                      Expanded(
                        child: Slider(
                          thumbColor: slideColor,
                          inactiveColor: slideColor,
                          activeColor: slideColor,
                          min: const Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          value: controller.value.value,
                           onChanged: (newValue){
                            controller.changeDurationToSeconds(newValue.toInt());
                            newValue = newValue;
                           }),
                           ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                         controller.duration.value,
                           style: customfontStyle(fColor: bgdark),
                           ),
                      ),
                                      ],
                                    ),
                    ),
                                ),
                    
                                 const SizedBox(
                                  height: 25,
                                ),
                    
                                Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    
                                  children: [

  IconButton(
                    onPressed: (){ },
                     icon: const Icon(
                      Icons.repeat,
                       size: 20,
                       color: bgdark,
                       ),
                       ),

                                    IconButton(
                    onPressed: (){
                    
                    controller.playSong(data[controller.playIndex.value - 1].uri,controller.playIndex.value - 1);
                    
                    
                    },
                     icon: const Icon(
                      Icons.skip_previous_rounded,
                       size: 40,
                       color: bgdark,
                       ),
                       ),

               
                    
                                    Obx(
                    () => CircleAvatar(
                      backgroundColor: lightBlue,
                      radius: 30,
                      child: Transform.scale(
                        scale: 1.5,
                        child: IconButton(
                          onPressed: (){
                            if(controller.isPlaying.value){
                              controller.audioPlayer.pause();
                              controller.isPlaying(false);
                            }else{
                               controller.audioPlayer.play();
                              controller.isPlaying(true);
                            }
                          }, 
                          icon:controller.isPlaying.value 
                          ? const Icon(
                            Icons.pause,
                             color: white)
                             : const Icon(
                              Icons.play_arrow_rounded,
                              color: white,
                              )
                            ),
                      )
                          ,),
                                    ),
    

                                    IconButton(
                    onPressed: (){
                    
                      controller.playSong(data[controller.playIndex.value + 1].uri,controller.playIndex.value + 1);
                    
                    },
                     icon: const Icon(
                      Icons.skip_next_rounded,
                       size: 40,
                        color: bgdark,
                       ),
                       ),

                                       
    IconButton(
                    onPressed: (){ },
                     icon: const Icon(
                      Icons.shuffle,
                       size: 20,
                       color: bgdark,
                       ),
                       ),
                    
                                  ],
                                )
                      ],
                    ),
                  ),
              ),
              ),

          ],
        ),
      ),
    );
  }
}