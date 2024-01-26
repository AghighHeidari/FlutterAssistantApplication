import 'package:flutter/material.dart';
import 'package:flutter_assistant/controller/auth_controller.dart';
import 'package:flutter_assistant/controller/creator_controller.dart';
import 'package:flutter_assistant/service/api.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/service/theme.dart';
import 'package:flutter_assistant/widget/base_widget.dart';
import 'package:flutter_assistant/widget/loading_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_assistant/service/routing/router.dart' as R;

Future<void> _getXConfiguration() async {
  await GetStorage.init();
  Get.put(Pref(), permanent: true);
  Get.put(Api(), permanent: true);
  Get.put(AuthController(api: Get.find<Api>(), pref: Get.find<Pref>()));
  Get.put(CreatorController(api: Get.find<Api>(), pref: Get.find<Pref>()));
}

void main() async {
  await _getXConfiguration();
  runApp(const FlutterAssistantApp());
}

class FlutterAssistantApp extends StatelessWidget {
  const FlutterAssistantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidget: loadingWidget(context),
      useDefaultLoading: false,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetMaterialApp(
          theme: mainTheme,
          themeMode: ThemeMode.system,
          initialRoute: '/',
          builder: (_, child) => BaseWidget(child: child),
          getPages: R.Router.routes,
          locale: const Locale('fa', 'IR'),
        ),
      ),
    );
  }
}
