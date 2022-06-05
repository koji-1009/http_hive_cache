import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:hive/hive.dart' show Hive;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:path/path.dart' if (dart.library.html) 'stub/path.dart'
    as path_helper;

class HiveHelper {
  /// Initializes Hive with the path from [getTemporaryDirectory].
  static Future<void> initFlutter({
    required String subDir,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      return;
    }

    var cacheDir = await getTemporaryDirectory();
    Hive.init(path_helper.join(cacheDir.path, subDir));
  }
}
