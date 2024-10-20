import 'package:get_it/get_it.dart';
import 'package:real_estate/services/error_state.dart';
import 'package:real_estate/services/home_page_services.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerLazySingleton(() => ErrorState());
  locator.registerLazySingleton(() => HomePageServices());
}
