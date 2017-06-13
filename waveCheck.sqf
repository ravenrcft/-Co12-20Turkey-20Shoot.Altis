private _enemyUnits = [];
timestamp = time;

//Init
{
	if (side _x == east) then { 
		_enemyUnits pushBackUnique _x;
	};
}forEach allUnits;


///////////////////////////
while {(count _enemyUnits) > 0} do {
	_enemyUnits = [];
	_pruneUnits = [];
	_barrierUnits = [];


	//Refreshing List
	{
		if (side _x == east) then { 
			_enemyUnits pushBackUnique _x;
		};
	}forEach allUnits;

	//Wave Checker
	diag_log format ["RLOG :: Running waveCheck... %1", (time - timestamp)];
	{	
		//Prune units
		if (((time - timestamp) > 300) && !(_x inArea "towerCheck")) then {
			_pruneUnits pushBack _x;
			_x setDamage 1;
		};

		//2k check
		if !(_x inArea "rangeCheck") then {
			_barrierUnits pushBackUnique _x;
			_x setDamage [1, false];
		};
	}forEach _enemyUnits;

	diag_log format ["RLOG :: Enemy count: %1", count _enemyUnits];
	if (count _pruneUnits > 0) then {diag_log format ["RLOG :: Pruned %1 units", count _pruneUnits];};
	if (count _barrierUnits > 0) then {diag_log format ["RLOG :: Lost Units %1", count _barrierUnits];};
	if (count _enemyUnits > 0) then {sleep 10;};
};

//["<t color='#ffffff' size = '1'>Wave Complete!</t>",-1,-1,4,1,0,789] spawn BIS_fnc_dynamicText;
//[str("You Text") , str(date select 1) + "." + str(date select 2) + "." + str(date select 0), str("You Text")] spawn BIS_fnc_infoText;
[str("Wave Complete")] spawn BIS_fnc_infoText;