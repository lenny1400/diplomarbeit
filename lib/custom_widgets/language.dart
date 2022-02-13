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
      'se_subtitle5':'FAQ',
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
      'ti_initialTime':'Initial Time',
      'ti_hours':'Hours',
      'ti_minutes':'Minutes',
      'ti_seconds':'Seconds',
      'ti_buttonText2':'Save',

      //Tasks
      'ta_appbar1':"Tasks",
      'ta_title1':'New Task',
      'ta_buttonIntern':'Intern',
      'ta_appbar2':"Intern",
      'ta_title2Activity':'Performed Activity',
      'ta_title3Date':'Date & Time',
      'ta_buttonSave':'Save',

      'ta_buttonNewCustomer':'New Customer',
      'ta_appbar3':"New Customer",
      'ta_fieldCName':"Company Name",
      'ta_hintCName':"Enter company name",
      'ta_fieldCNumber':"Customer Number",
      'ta_hintCNumber':"Enter Customer Number",
      'ta_fieldCTitle':"Title",
      'ta_hintCTitle':"Enter title",
      'ta_fieldFirst':"Firstname",
      'ta_hintFirst':"Enter first name",
      'ta_fieldLast':"Lastname",
      'ta_hintLast':"Enter last name",
      'ta_fieldStreet':"Street",
      'ta_hintStreet':"Enter street name",
      'ta_fieldNr':"Nr.",
      'ta_hintNr':"Nr.",
      'ta_fieldProvince':"Province",
      'ta_hintProvince':"Enter province name",
      'ta_fieldZip':"Zip Code",
      'ta_hintZip':"Zip Code",
      'ta_fieldCountry':"Country",
      'ta_hintCountry':"Enter country",
      'ta_fieldPhone':"Phone Number",
      'ta_hintPhone':"Enter phone number",
      'ta_fieldEmail':"Email",
      'ta_hintEmail':"Enter email address",
      'ta_fieldFax':"Fax",
      'ta_hintFax':"Enter Fax number",

      'ta_buttonOldCustomer':'Existing Customer',
      'ta_appbar4':"Existing Customer",
      'ta_titleKunde':"Customer",
      'ta_titleApproach':"Approach",
      'ta_yes':"Yes",
      'ta_no':"No",
      'ta_titleMileage':"Mileage",
      'ta_start':"Start",
      'ta_hintstart':"Mileage start",
      'ta_stop':"Stop",
      'ta_hintstop':"Mileage stop",
      'ta_titleTime':"Time",
      'ta_buttonNow':"Now",
      'ta_buttonNext':"Next",
      //page 2 Existing Customer
      'ta_titleActivity':'Performed Activity',
      'ta_titleMaterial':'Material expenses',
      'ta_titlePictures':'Pictures',
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

      //Time
      'ti_appbar1':'Zeit',
      'ti_arrive':'ankommen',
      'ti_leave':'verlassen',
      'ti_title1':'derzeit arbeitend',
      'ti_buttonText1':'Bearbeiten',
      'ti_appbar2':'Zeit editieren',
      'ti_initialTime':'Anfangszeitpunkt',
      'ti_hours':'Stunden',
      'ti_minutes':'Minuten',
      'ti_seconds':'Sekunden',
      'ti_buttonText2':'Speichern',

      //Tasks
      'ta_appbar1':"Aufgaben",
      'ta_title1':'Neue Aufgabe',
      'ta_buttonIntern':'Intern',
      'ta_appbar2':"Intern",
      'ta_title2Activity':'Durchgeführte Tätigkeit',
      'ta_title3Date':'Datum und Uhrzeit',
      'ta_buttonSave':'Speichern',

      'ta_buttonNewCustomer':'Neuer Kunde',
      'ta_appbar3':"Neuer Kunde",
      'ta_fieldCName':"Name des Unternehmens",
      'ta_hintCName':"Unternehmensname eingeben",
      'ta_fieldCNumber':"Kundennummer",
      'ta_hintCNumber':"Kundennummer eingeben",
      'ta_fieldCTitle':"Titel",
      'ta_hintCTitle':"Titel",
      'ta_fieldFirst':"Name",
      'ta_hintFirst':"Name eingeben",
      'ta_fieldLast':"Nachname",
      'ta_hintLast':"Nachname eingeben",
      'ta_fieldStreet':"Straße",
      'ta_hintStreet':"Straße eingeben",
      'ta_fieldNr':"Nr.",
      'ta_hintNr':"Nr.",
      'ta_fieldProvince':"Bundesland",
      'ta_hintProvince':"Bundesland eingeben",
      'ta_fieldZip':"PLZ",
      'ta_hintZip':"PLZ",
      'ta_fieldCountry':"Land",
      'ta_hintCountry':"Land eingeben",
      'ta_fieldPhone':"Rufnummer",
      'ta_hintPhone':"Rufnummer eingeben",
      'ta_fieldEmail':"E-Mail",
      'ta_hintEmail':"E-Mail eingeben",
      'ta_fieldFax':"Fax",
      'ta_hintFax':"Fax eingeben",

      'ta_buttonOldCustomer':'Bestehender Kunde',
      'ta_appbar4':"Bestehender Kunde",
      'ta_titleKunde':"Kunde",
      'ta_titleApproach':"Anfahrt",
      'ta_yes':"Ja",
      'ta_no':"Nein",
      'ta_titleMileage':"Kilometerstand",
      'ta_start':"Anfang",
      'ta_hintstart':"Kilometerstand Anfang",
      'ta_stop':"Ende",
      'ta_hintstop':"Kilometerstand Ende",
      'ta_titleTime':"Uhrzeit",
      'ta_buttonNow':"Jetzt",
      'ta_buttonNext':"Weiter",
      //page 2 Existing Customer
      'ta_titleActivity':'Durchgeführte Tätigkeit',
      'ta_titleMaterial':'Materialaufwand',
      'ta_titlePictures':'Bilder',
    }
  };
}