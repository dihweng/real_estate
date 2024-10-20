import 'package:dio/dio.dart';

import '../locator.dart';
import '../services/home_page_services.dart';
import 'base_model.dart';

class HomePageModel extends BaseViewModel {
  final HomePageServices _homePageServices = locator<HomePageServices>();



  // Future generateUploadUrl(Map<String, dynamic> apiRequestPayload) async{
  //   setStatus(ViewStatus.Loading);
  //   Response? response;
  //   try {
  //     response = await _homePageServices.generateUploadUrl(apiRequestPayload);
  //
  //     final Map<String, dynamic> data = pick(response.data, 'data').asMapOrEmpty();
  //     return data;
  //   } on DioException catch (e) {
  //     setStatus(ViewStatus.Error);
  //     if (e.response != null) {
  //       errorMessage = e.response!.data['message'];
  //       return errorMessage;
  //     }
  //     return;
  //   } catch (e) {
  //     print(e);
  //   }
  // }


}
