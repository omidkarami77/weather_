class CurrentCityDataModel {
  String? _cityName;
  var _long;
  var _lat;
  var _main;
  String? decription;
  var _temp;
  var _temp_min;
  var _temp_max;
  var _pressure;
  var _humidity;
  var _windSpeed;
  var _dataTime;
  String? _country;
  var _sunrise;
  var _sunset;
  String? get cityName => this._cityName;

  set cityName(String? value) => this._cityName = value;

  get long => this._long;

  set long(value) => this._long = value;

  get lat => this._lat;

  set lat(value) => this._lat = value;

  get main => this._main;

  set main(value) => this._main = value;

  get getDecription => this.decription;

  set setDecription(decription) => this.decription = decription;

  get temp => this._temp;

  set temp(value) => this._temp = value;

  get temp_min => this._temp_min;

  set temp_min(value) => this._temp_min = value;

  get temp_max => this._temp_max;

  set temp_max(value) => this._temp_max = value;

  get pressure => this._pressure;

  set pressure(value) => this._pressure = value;

  get humidity => this._humidity;

  set humidity(value) => this._humidity = value;

  get windSpeed => this._windSpeed;

  set windSpeed(value) => this._windSpeed = value;

  get dataTime => this._dataTime;

  set dataTime(value) => this._dataTime = value;

  get country => this._country;

  set country(value) => this._country = value;

  get sunrise => this._sunrise;

  set sunrise(value) => this._sunrise = value;

  get sunset => this._sunset;

  set sunset(value) => this._sunset = value;

  CurrentCityDataModel(
      this._cityName,
      this._main,
      this._long,
      this._lat,
      this.decription,
      this._temp,
      this._temp_max,
      this._temp_min,
      this._pressure,
      this._humidity,
      this._windSpeed,
      this._dataTime,
      this._country,
      this._sunrise,
      this._sunset);
}
