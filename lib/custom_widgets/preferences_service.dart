import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class PreferenceService{
  //Save Function with async for the Color Theme
  Future saveSettings(Settings settings) async{
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool('isSwitched', settings.isSwitched);
    //await preferences.setString('language', settings.language);

    //print('saved settings');
  }

  //Print Function for the Color Theme or more with language ... maybe in progress
  Future<Settings> getSettings() async{
    final preferences = await SharedPreferences.getInstance();

    final bool isSwitched = preferences.getBool('isSwitched')!;
    //final String language = preferences.getString('language')!;

    return Settings(
        //language: language,
        isSwitched: isSwitched
    );
  }
}