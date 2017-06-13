private _unitPool = _this select 0;
private _motorPool = _this select 1;
private _allotedTime = 0;


//diag_log format ["unitPool %1, motorPool %2", (count _unitPool), (count _motorPool)];

//if ((count _unitPool) > 4) then {_allotedTime = _allotedTime + ((count _unitPool) * 2)};
if ((count _motorPool) > 0) then {_allotedTime = _allotedTime + ((count _motorPool) * 5)};
if (_allotedTime > 90) then {_allotedTime = 90;};
if (_allotedTime > 0) then {[str("INTERMISSION"), str(_allotedTime) + str(" seconds"), str("Get some Ammo!")] spawn BIS_fnc_infoText;};
sleep _allotedTime;