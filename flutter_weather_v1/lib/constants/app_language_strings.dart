enum Langages {
  Eng,
  Th,
}

abstract class StringApp {
  String Date;
  String Mintemp;
  String Temp;
  String Maxtemp;
  String Humidity;
  String WindSpeed;
}

class StringLangages {
  static StringApp getStrApp(Langages langages) {
    if (langages == Langages.Eng) {
      return StringAppEng();
    }
    if (langages == Langages.Th) {
      return StringAppTh();
    }
  }
}

class StringAppEng extends StringApp {
  @override
  String get Date => "Date";
  @override
  String get Mintemp => "Min temp";
  @override
  String get Temp => "Temp";
  @override
  String get Maxtemp => "Max temp";
  @override
  String get Humidity => "Humidity";
  @override
  String get WindSpeed => "Wind Speed";
}

class StringAppTh extends StringApp {
  @override
  String get Date => "วันที่";
  @override
  String get Mintemp => "อุณหภูมิต่ำสุด";
  @override
  String get Temp => "อุณหภูมิ";
  @override
  String get Maxtemp => "อุณหภูมิสูงสุด";
  @override
  String get Humidity => "ความชื้น";
  @override
  String get WindSpeed => "ความเร็วลม";
}
