import 'package:get_it/get_it.dart';
import 'package:qflutter_test_app/core/providers/db_provider.dart';
import 'package:qflutter_test_app/core/repositories/comments_repository.dart';
import 'package:qflutter_test_app/ui/widgets/comments_controller.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerSingleton<CommentsRepository>(CommentsRepository());

  locator.registerSingleton<CommentsController>(CommentsController());

  //locator.registerSingleton<DbProvider>(DbProvider.db);
}