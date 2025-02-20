import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/theme/palette.dart';
import 'package:music_app/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget{
  const Home({super.key});

@override
  Widget build(BuildContext context){

var controller = Get.put(PlayerController());

  return Scaffold(
    backgroundColor: bgdark,
    appBar: AppBar(
      backgroundColor: bgdark,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search,color: white)),
      ],
      leading:const Icon(Icons.sort_rounded,color: white),
      title:  Text(
        "Beats",
        style: customfontStyle(
          family: bold,
          size: 18,
        ),
        
        ),
    ),
    body:FutureBuilder<List<SongModel>>(
      future: controller.audioQuery.querySongs(
         ignoreCase: true,
         orderType: OrderType.ASC_OR_SMALLER,
         sortType: null,
         uriType: UriType.EXTERNAL,
      ),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.data!.isEmpty){
          return  Center(
            child: Text(
              "No song Found",
              style: customfontStyle(),
            ),
          );
        
      }else{
        // print(snapshot.data);
        return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
              child:  Obx(
                ()=> ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    ),
                tileColor: bgdark,
                title:  Text(
                  snapshot.data![index].displayNameWOExt,
                  style: const TextStyle(
                  color: white,
                  fontFamily: "bold",
                  fontSize: 15,
                ),
                //  style: customfontStyle(family: bold,size: 15 ),
                ),
                subtitle:  Text(
                  "${snapshot.data![index].artist}",
                  style: const TextStyle(
                  color: white,
                  fontFamily: "bold",
                  fontSize: 12,
                ),
                ),
                leading: QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  color: white,
                  size: 32,
                  ),
                ),
                trailing:controller.playIndex.value == index && controller.isPlaying.value
                ? const Icon(Icons.play_arrow,
                color: white,
                 size: 26,
                ) : null,
                onTap: (){
                  Get.to(() => Player(
                    data: snapshot.data!,
                    ),  
                  transition: Transition.downToUp,
                  );
                  controller.playSong(snapshot.data![index].uri, index);
                },
                            ),
              )
            );
        }
        ),
    );

      }
   
      },
    )
  );
}

}


