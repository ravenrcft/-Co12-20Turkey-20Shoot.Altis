private _unitPool = _this select 0;
private _motorPool = _this select 1;
private _infGroup = [];

//Wave Started!
[str("Wave ") + str(waveCount) + str(" Started!")] spawn BIS_fnc_infoText;

//PreSpawn smoke
private _spawnLoc = [];
{
	_ranPos = [[20602.2,20129.7,0], 550, 950, 2, 0, 0.3, 0, ["restricted"], [[20179.8,19702.2,0],[19699.2,20003.6,0]]] call BIS_fnc_findSafePos;
	_spawnLoc pushBack _ranPos;
}forEach _unitPool;
{
	//diag_log format ["RLOG :: smokeLoc %1", _x];
	for [{_i = 0}, {_i < 6}, {_i = _i + 1}] do {
		_gen = "SmokeShell" createVehicle [((_x select 0) + random 15), ((_x select 1) + random 15), 5];
		_gen setVelocity [0,0,10]
	};
}forEach _spawnLoc;
sleep 10;


{
	diag_log format ["RLOG :: Spawning [(%1)]", _x];
	//_randPos = [[20602.2,20129.7,0], 550, 950, 2, 0, 0.3, 0, ["restricted"], [[20179.8,19702.2,0],[19699.2,20003.6,0]]] call BIS_fnc_findSafePos;
	_randPos = selectRandom _spawnLoc;
	_spawnLoc = _spawnLoc - [_randPos];

	//_randPos = (select (random (count _spawnLoc)));
	_spawnGrp = [_randPos, east, (configfile >> "CfgGroups" >> "East" >> "rhsgref_faction_chdkz" >> "rhsgref_group_chdkz_insurgents_infantry" >> _x),[],[],[0.1,0.2],[],[], 0] call BIS_fnc_spawnGroup;	
	//diag_log format ["RLOG :: _spawnGrp - %1", _spawnGrp];
	_grpCount = count (units _spawnGrp);
	_infGroup pushBack [_grpCount, _spawnGrp];
	//_spawnLoc = _spawnLoc - _randPos;

	_wp = _spawnGrp addWaypoint [[20602.2,20129.7,0], 0]; 
	_wp setWaypointType "SAD";  
	_wp setWaypointFormation "COLUMN";
	_wp setWaypointBehaviour "AWARE";
	_wp setwaypointcombatmode "RED";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 5;
}forEach _unitPool;
//diag_log format ["RLOG :: _infGroup - %1", _infGroup];
_infGroup sort false;

{
	diag_log format ["RLOG :: Spawning [(%1)]", _x];
	_randPos = [[20602.2,20129.7,0], 750, 1500, 9, 0, 0.1, 0, ["restricted"], [[20179.8,19702.2,0],[19699.2,20003.6,0]]] call BIS_fnc_findSafePos; 
	_vehicle = _x createVehicle _randPos;
	//diag_log format ["Driver: %1 | Gunner: %2 | Commander: %3 | Cargo: %4", (_vehicle emptyPositions "driver"), (_vehicle emptyPositions "gunner"), (_vehicle emptyPositions "commander"), (_vehicle emptyPositions "cargo")];

	_spawnGrp = createGroup east;
	{
		if ((_vehicle emptyPositions _x) > 0) then {
			_spawnCrew = _spawnGrp createUnit ["rhsgref_ins_crew", _randPos, [], 2, "NONE"];	
			switch (_x) do {
				case "driver": {_spawnCrew moveInDriver _vehicle;};
				case "commander": {_spawnCrew moveInCommander _vehicle;};
				case "gunner": {_spawnCrew moveInGunner _vehicle;};
				default {_spawnCrew moveInAny _vehicle;};
			};
		};
	}forEach ["driver", "commander", "gunner"];

	if ((count _infGroup) > 0) then {
		//_selectGrp = selectRandom _infGroup;
		_selectList = _infGroup select 0;
		_selectGrp = _selectList select 1;
		_units = ["rhsgref_BRDM2_ins","rhsgref_BRDM2_HQ_ins","rhsgref_ins_bmd1","rhsgref_ins_bmd1p","rhsgref_ins_bmd2","rhsgref_ins_bmp1","rhsgref_ins_bmp1d","rhsgref_ins_bmp1k","rhsgref_ins_bmp1p","rhsgref_ins_bmp2","rhsgref_ins_bmp2e","rhsgref_ins_bmp2d","rhsgref_ins_bmp2k","rhsgref_ins_btr60","rhsgref_ins_btr70"];
		if (_x in _units) then {
			{
				_x moveInCargo _vehicle;
			}forEach units _selectGrp;
		};
		_infGroup = _infGroup - [_selectList];
	};

	_wp = _spawnGrp addWaypoint [[20602.2,20129.7,0], 0]; 
	_wp setWaypointType "SAD";  
	_wp setWaypointFormation "COLUMN";
	_wp setWaypointBehaviour "AWARE";
	_wp setwaypointcombatmode "RED";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 5;
}forEach _motorPool;

//Wave checker
//diag_log format ["RLOG :: waveCheck Started"];
private _waveCheck = [] execVM "waveCheck.sqf";
waitUntil {isNull _waveCheck};
//diag_log format ["RLOG :: waveCheck Ended"];
sleep 5;

waveCount = waveCount + 1;