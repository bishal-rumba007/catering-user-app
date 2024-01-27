

import 'package:catering_user_app/src/features/menu/data/menu_datasource.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuProvider = FutureProvider.autoDispose<List<Menus>>((ref) => MenuDataSource().getMenu());