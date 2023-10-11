import 'dart:io';

import 'package:animated_background/animated_background.dart';
import 'package:changebackgrond_frontend/API/api.dart';
import 'package:changebackgrond_frontend/Screens/home.dart';
import 'package:changebackgrond_frontend/Screens/upload.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../Transition/Fade.dart';
import '../values/values.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen>
    with TickerProviderStateMixin {
  MediaType? _mediaType;
  String? imagePath;
  XFile? file;
  bool? next;
  bool type = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    next = false;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AnimatedBackground(
          behaviour: RacingLinesBehaviour(
            direction: LineDirection.Ltr,
            numLines: 15,
          ),
          vsync: this,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 페이지 보여주기
                    imagePath != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.78,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.file(File(imagePath!)),
                          )
                        : Card(
                            child: Container(
                              color: AppColors.primaryColor,
                              width: MediaQuery.of(context).size.width * 0.78,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                  child: Text(
                                StringConst.select_o_file,
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium,
                              )),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // image
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _mediaType = MediaType.image;
                                  pickMedia(ImageSource.gallery);
                                });
                              },
                              child: Card(
                                elevation: 1,
                                child: Center(
                                    child: Text(
                                  StringConst.img,
                                  style: textTheme.bodySmall,
                                )),
                              )),
                        ),
                        // video
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  _mediaType = MediaType.video;
                                  pickMedia(ImageSource.gallery);
                                });
                              },
                              child: Card(
                                elevation: 1,
                                child: Center(
                                    child: Text(
                                  StringConst.vid,
                                  style: textTheme.bodySmall,
                                )),
                              )),
                        ),
                      ],
                    ),
                    next!
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: InkWell(
                                // 다음 페이지
                                onTap: () {
                                  Navigator.push(context,
                                      FadeRoute(page: const UploadScreen()));
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: Text(
                                    StringConst.next,
                                    style: textTheme.bodySmall,
                                  )),
                                )),
                          )
                        : const SizedBox(),
                  ],
                ),
                Positioned(
                  top: 40,
                  width: MediaQuery.of(context).size.width * 1.6,
                  child: IconButton(
                    icon: const Icon(
                      Icons.restart_alt_sharp,
                      color: Colors.grey,
                      size: Sizes.SIZE_30,
                    ),
                    tooltip: 'Go Home',
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context, FadeRoute(page: const HomeScreen()));
                      });
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> pickMedia(ImageSource source) async {
    if (_mediaType == MediaType.image) {
      file = await ImagePicker().pickImage(source: source);
      Post.file_type = "image";
      Post.i_input = file;
      Post.i_inputName = file?.name ?? "";
    } else {
      file = await ImagePicker().pickVideo(source: source);
      Post.file_type = "video";
      Post.v_input = file;
      Post.v_inputName = file?.name ?? "";
    }

    if (file != null) {
      imagePath = file!.path;

      if (_mediaType == MediaType.video) {
        imagePath = await VideoThumbnail.thumbnailFile(
            video: file!.path,
            imageFormat: ImageFormat.JPEG,
            quality: 100,
            maxWidth: 300,
            maxHeight: 400);
      }
    }
    if (file != null) {
      setState(() {
        next = true;
      });
    }
  }
}
