// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_print

part of api;

// 통신 API 요청

class Post with ChangeNotifier {
  static String file_type = "";
  // 파일 선언
  static XFile? v_input;
  static String? v_inputName;

  static XFile? b_input;
  static String? b_inputName;

  static XFile? i_input;
  static String? i_inputName;

  static void postImage(context) async {
    Navigator.push(context, FadeRoute(page: const WaitScreen()));

    // 모바일 사진 디렉토리 접근
    FormData formData = FormData.fromMap({
      "image":
          await MultipartFile.fromFile(i_input!.path, filename: i_inputName),
      "background":
          await MultipartFile.fromFile(b_input!.path, filename: b_inputName),
    });
    // 이미지 보내기
    var dio = Dio();
    try {
      dio.options.contentType = "multipart/form-data";
      var response = await dio.post(
        Info.baseUri + Info.uploadImageUrl,
        data: formData,
      );

      Navigator.push(context, FadeRoute(page: const DownloadScreen()));

      print(response.data);
      //return response.data;
    } catch (e) {
      Navigator.push(context, FadeRoute(page: const HomeScreen()));
      print(e);
    }
  }

  static void postVideo(context) async {
    Navigator.push(context, FadeRoute(page: const WaitScreen()));

    FormData formData = FormData.fromMap({
      "video":
          await MultipartFile.fromFile(v_input!.path, filename: v_inputName),
      "background":
          await MultipartFile.fromFile(b_input!.path, filename: b_inputName),
    });
    // 이미지 보내기
    var dio = Dio();
    try {
      dio.options.contentType = "multipart/form-data";
      var response = await dio.post(
        Info.baseUri + Info.uploadVideoUrl,
        data: formData,
      );

      Navigator.push(context, FadeRoute(page: const DownloadScreen()));

      print(response.data);
      //return response.data;
    } catch (e) {
      Navigator.push(context, FadeRoute(page: const HomeScreen()));
      print(e);
    }
  }

  static void getImage() async {
    String dir = (await getApplicationDocumentsDirectory())
        .path; //path provider로 저장할 경로 가져오기
    try {
      await FlutterDownloader.enqueue(
        url: Info.baseUri + Info.getImage, // file url
        savedDir: '$dir/', // 저장할 dir
        // fileName: , // 파일명
        saveInPublicStorage: true, // 동일한 파일 있을 경우 덮어쓰기 없으면 오류발생함!
      );
      print("파일 다운로드 완료");
    } catch (e) {
      print("eerror :::: $e");
    }
  }
}
