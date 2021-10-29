import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      //Settings
      'se_appbar1':"Settings",
      'se_title1':'Account',
      'se_title2':'Settings',
      'se_subtitle1':'Theme',
      'se_subtitle2':'Language',
      'se_select':'English',
      'se_subtitle3':'Notifications',
      'se_subtitle4':'Support',
      'se_subtitle5':'Help',
      'se_logout':'Log out',
      'se_dialogText':'Choose your language',

      //Home
      'ho_appbar1':'Home',
      'ho_buttonText1':'Tap to see',
      'ho_title1':'Not finished',
      'ho_title2':'Finished',
      'ho_subtitle1':'See all',

      //AllTasks
      'at_appbar1':'All Tasks',

      //Time
      'ti_appbar1':'Time',
      'ti_arrive':'Arrive',
      'ti_leave':'Leave',
      'ti_title1':'Currently working',
      'ti_buttonText1':'Edit',

      'ti_appbar2':'Edit Time',
      'ti_appbar2':'Edit Time',
      'ti_appbar2':'Edit Time',
      'ti_appbar2':'Edit Time',

    },
    'de_DE': {
      //Settings
      'se_appbar1':'Einstellungen',
      'se_title1':'Account',
      'se_title2':'Einstellungen',
      'se_subtitle1':'Ansicht',
      'se_subtitle2':'Sprache',
      'se_select':'Deutsch',
      'se_subtitle3':'Benachrichtigung',
      'se_subtitle4':'Support',
      'se_subtitle5':'Hilfe',
      'se_logout':'Abmelden',
      'se_dialogText':'Wähle deine Sprache',

      //Home
      'ho_appbar1':'Start',
      'ho_buttonText1':'Antippen um zu sehen',
      'ho_title1':'Nicht abgeschlossen',
      'ho_title2':'Abgeschlossen',
      'ho_subtitle1':'Alle anzeigen',

      //AllTasks
      'at_appbar1':'Alle Aufgaben',

    }
  };
}