import 'dart:io';
import 'dart:isolate';

import 'package:animated_background/animated_background.dart';
import 'package:changebackgrond_frontend/API/api.dart';
import 'package:changebackgrond_frontend/values/values.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../Transition/Fade.dart';
import 'home.dart';

enum MediaType {
  image,
  video;
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

ReceivePort _port = ReceivePort();

class _UploadScreenState extends State<UploadScreen>
    with TickerProviderStateMixin {
  Post post = Post();
  MediaType? _mediaType;
  String? imagePath;
  XFile? file;
  bool? upload;

  @override
  void initState() {
    super.initState();
    upload = false;
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
                                StringConst.select_b_file,
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium,
                              )),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: InkWell(
                          onTap: () {
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
                    upload!
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: InkWell(
                                // 업로드 페이지
                                onTap: () {
                                  setState(() {
                                    Post.b_input = file;
                                    Post.b_inputName = file!.name;
                                    print(Post.file_type);
                                    Post.file_type == "image"
                                        ? Post.postImage(context)
                                        : Post.postVideo(context);
                                  });
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: Text(
                                    StringConst.upload,
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
                  child: GestureDetector(
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
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void pickMedia(ImageSource source) async {
    if (_mediaType == MediaType.image) {
      file = await ImagePicker().pickImage(source: source);
    } else {
      file = await ImagePicker().pickVideo(source: source);
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
        upload = true;
      });
    }
  }
}
