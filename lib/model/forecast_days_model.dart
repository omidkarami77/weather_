class ForeCastDaysModel {
  var _dateTime;
  var _temp;
  var _main;
  var _description;

  get dateTime => this._dateTime;

  set dateTime(value) => this._dateTime = value;

  get temp => this._temp;

  set temp(value) => this._temp = value;

  get main => this._main;

  set main(value) => this._main = value;

  get description => this._description;

  set description(value) => this._description = value;

  ForeCastDaysModel(this._dateTime, this._temp, this._main, this._description);
}
