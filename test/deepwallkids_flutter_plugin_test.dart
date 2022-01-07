import 'package:deepwallkids_flutter_plugin/enums/environments.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deepwallkids_flutter_plugin/deepwallkids_flutter_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('deepwallkids_flutter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('initialize', () async {
    DeepWallKidsFlutterPlugin.initialize('API_KEY', Environment.SANDBOX.value);
    //expect(await DeepWallKidsFlutterPlugin.platformVersion, '42');
  });
}
