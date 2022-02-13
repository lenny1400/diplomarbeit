import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class PreferenceService{
  //Save Function with async for the Color Theme
  Future saveSettings(Settings settings) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isSwitched', settings.isSwitched);
    /*await preferences.setStringList('language', settings.language
        .map((e) => e.indexOf('language'/*settings.language.toString()*/).toString())
        .toList());
     */
    print('saved settings');
  }

  //Print Function for the Color Theme
  Future<Settings> getSettings() async{
    final preferences = await SharedPreferences.getInstance();
    final bool isSwitched = preferences.getBool('isSwitched')!;
    //final List<String> language = preferences.getStringList('language')!;

    return Settings(
        //language: language,
        isSwitched: isSwitched
    );
  }

  Future saveTime(TimeStuff timeStuff) async{
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('timestampIn', timeStuff.timestampIn);

    print('saved time');
  }

  //Print Function for the Color Theme or more with language ... maybe in progress
  Future<TimeStuff> getTimeStuff() async{
    final preferences = await SharedPreferences.getInstance();

    final String timestampIn = preferences.getString('timestampIn')!;

    return TimeStuff(
        timestampIn: timestampIn
    );
  }
}