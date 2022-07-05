class ForeCastDaysModel {
  var _temp;
  var _main;
  var _description;

  var _datetime;

  get datetime => _datetime;

  get temp => this._temp;

  set temp(value) => this._temp = value;

  get main => this._main;

  set main(value) => this._main = value;

  get description => this._description;

  set description(value) => this._description = value;

  ForeCastDaysModel(this._datetime, this._temp, this._main, this._description);
}
