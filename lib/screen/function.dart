
import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';

class Fun{

  static Future<void>shareText(String title)async{
    Share.share(title);
  }

  static Future<void>copyText(String title)async{
    FlutterClipboard.copy(title).then(( value ) => print('copied'));
  }
}