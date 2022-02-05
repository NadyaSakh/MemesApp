import 'package:dio/dio.dart';
import 'package:myapp/memes/models/meme.dart';
import 'package:myapp/memes/models/memes.dart';
import 'package:myapp/memes/utils/dio_logging.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://meme-api.herokuapp.com'
    ),
  )..interceptors.add(Logging());

  Future<List<Meme>> fetchMemes(int _memesPortionCount) async {
      Response response = await _dio.get('/gimme/$_memesPortionCount');
      if (response.statusCode == 200) {
        final body = Memes.fromJson(response.data);
        return body.memes;
      }
      throw Exception('Error fetching memes');
    }
}
