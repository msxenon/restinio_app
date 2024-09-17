import 'package:flutter/cupertino.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class WoltModalPage<T> extends Page<T> {
  final ValueNotifier<WoltModalSheetPageListBuilder> pageListBuilderNotifier;
  const WoltModalPage({
    required this.pageListBuilderNotifier,
    required super.key,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return WoltModalSheetRoute(
      settings: this,
      pageListBuilderNotifier: pageListBuilderNotifier,
    );
  }
}
