import 'package:get_it/get_it.dart';

import 'core/providers/comments_repository.dart';
import 'core/providers/db_provider.dart';
import 'core/repositories/comments_controller.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerSingleton<CommentsRepository>(CommentsRepository());

  locator.registerSingleton<DbProvider>(DbProvider());

  locator.registerSingleton<CommentsController>(CommentsController());
}
