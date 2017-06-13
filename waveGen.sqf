private ["_infUnits", "_motorUnits", "_mrapUnits", "_ifvUnits", "_apcUnits", "_armorUnits", "_unitPool", "_motorPool", "_unitAllowance"];
// Weighted units (limited weight per waveCount)


// ChDKZ 	  UNITS
//	TEAM - 		8
//	PATROL - 	4
//	MG -		2
//	AT -		2

// configfile >> "CfgGroups" >> "East" >> "rhsgref_faction_chdkz" >>
//_infPrefix = "rhsgref_group_chdkz_insurgents_infantry";
// [CLASSNAME, COST]
_infUnits = [
	["rhsgref_group_chdkz_infantry_at", 1],
	["rhsgref_group_chdkz_infantry_mg", 1],
	["rhsgref_group_chdkz_infantry_patrol", 2],
	["rhsgref_group_chdkz_insurgents_squad", 4]
];
_motorUnits = [
	["rhsgref_ins_uaz_ags", 15],
	["rhsgref_ins_uaz_dshkm", 10],
	["rhsgref_ins_uaz_spg9", 12]
];
_mrapUnits = [
	["rhsgref_BRDM2_ins", 30],
	["rhsgref_BRDM2_HQ_ins", 26]
];
_ifvUnits = [
	["rhsgref_ins_bmd1", 32],
	["rhsgref_ins_bmd1p", 32],
	["rhsgref_ins_bmd2", 34],
	["rhsgref_ins_bmp1", 34],
	["rhsgref_ins_bmp1d", 34],
	["rhsgref_ins_bmp1k", 34],
	["rhsgref_ins_bmp1p", 34],
	["rhsgref_ins_bmp2", 36],
	["rhsgref_ins_bmp2e", 36],
	["rhsgref_ins_bmp2d", 36],
	["rhsgref_ins_bmp2k", 36]
];
_apcUnits = [
	["rhsgref_ins_btr60", 44],
	["rhsgref_ins_btr70", 44]
];
_armorUnits = [
	["rhsgref_ins_t72ba", 72],
	["rhsgref_ins_t72bb", 72],
	["rhsgref_ins_t72bc", 72]
];
///////////////////////////////////////////////////

_unitAllowance = waveCount * 10;
_unitPool = [];
_motorPool = [];

while {_unitAllowance > 0} do {
	//diag_log format ["Allowance (%1)", _unitAllowance];
	if (random 10 < 3) then {
		// Motor
		if ((waveCount > 2) && (waveCount < 6)) then {
			_unitSelect = selectRandom _motorUnits;
			_unitSelectPrice = _unitSelect select 1;
			//diag_log format ["RLOG :: Unit - %1", _unitSelect];
			//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
			if (_unitSelectPrice <= _unitAllowance) then {
				_unitAllowance = _unitAllowance - _unitSelectPrice;
				_motorPool pushBack (_unitSelect select 0);	
			} else {
				//_unitAllowance = _unitAllowance - 1;
				//diag_log format ["RLOG :: Too much! (%1)", (_unitAllowance - _unitSelectPrice)];
			};
		};
		// MRAP
		if ((waveCount > 4) && (waveCount < 10)) then {
			_unitSelect = selectRandom _mrapUnits;
			_unitSelectPrice = _unitSelect select 1;
			//diag_log format ["RLOG :: Unit - %1", _unitSelect];
			//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
			if (_unitSelectPrice <= _unitAllowance) then {
				_unitAllowance = _unitAllowance - _unitSelectPrice;
				_motorPool pushBack (_unitSelect select 0);	
			} else {
				//_unitAllowance = _unitAllowance - 1;
				//diag_log format ["RLOG :: Too much! (%1)", (_unitAllowance - _unitSelectPrice)];
			};
		};
		// IFV
		if ((waveCount > 6) && (waveCount < 12)) then {
			_unitSelect = selectRandom _ifvUnits;
			_unitSelectPrice = _unitSelect select 1;
			//diag_log format ["RLOG :: Unit - %1", _unitSelect];
			//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
			if (_unitSelectPrice <= _unitAllowance) then {
				_unitAllowance = _unitAllowance - _unitSelectPrice;
				_motorPool pushBack (_unitSelect select 0);	
			} else {
				//_unitAllowance = _unitAllowance - 1;
				//diag_log format ["RLOG :: Too much! (%1)", (_unitAllowance - _unitSelectPrice)];
			};
		};
		// APC
		if ((waveCount > 8) && (waveCount < 16)) then {
			_unitSelect = selectRandom _apcUnits;
			_unitSelectPrice = _unitSelect select 1;
			//diag_log format ["RLOG :: Unit - %1", _unitSelect];
			//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
			if (_unitSelectPrice <= _unitAllowance) then {
				_unitAllowance = _unitAllowance - _unitSelectPrice;
				_motorPool pushBack (_unitSelect select 0);	
			} else {
				//_unitAllowance = _unitAllowance - 1;
				//diag_log format ["RLOG :: Too much! (%1)", (_unitAllowance - _unitSelectPrice)];
			};
		};
		// ARMOR
		if (waveCount > 10) then {
			_unitSelect = selectRandom _armorUnits;
			_unitSelectPrice = _unitSelect select 1;
			//diag_log format ["RLOG :: Unit - %1", _unitSelect];
			//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
			if (_unitSelectPrice <= _unitAllowance) then {
				_unitAllowance = _unitAllowance - _unitSelectPrice;
				_motorPool pushBack (_unitSelect select 0);	
			} else {
				//_unitAllowance = _unitAllowance - 1;
				//diag_log format ["RLOG :: Too much! (%1)", (_unitAllowance - _unitSelectPrice)];
			};
		};
	} else {
		//Infantry
		_unitSelect = selectRandom _infUnits;
		_unitSelectPrice = _unitSelect select 1;
		//diag_log format ["RLOG :: Unit - %1", _unitSelect];
		//diag_log format ["RLOG :: Price - %1", _unitSelectPrice];
		if (_unitSelectPrice <= _unitAllowance) then {
			_unitAllowance = _unitAllowance - _unitSelectPrice;
			_unitPool pushBack (_unitSelect select 0);
		} else {
			_unitAllowance = _unitAllowance - 1;
			//diag_log format ["RLOG :: Too much! (%1) - Subtracting allowance by (1)", (_unitAllowance - _unitSelectPrice)];
		};
	};
};
//diag_log format ["Ending Allowance (%1)", _unitAllowance];
//diag_log format ["unitPool - %1", _unitPool];
//diag_log format ["motorPool - %1", _motorPool];

//Wave Spawner
//diag_log format ["RLOG :: spawnGen Started"];
private _spawnGen = [_unitPool, _motorPool] execVM "spawnGen.sqf";
waitUntil {isNull _spawnGen};
//diag_log format ["RLOG :: spawnGen Ended"];
sleep 5;

// Intermission calculator
//diag_log format ["RLOG :: lulGen Started"];
private _lulGen = [_unitPool, _motorPool] execVM "lulGen.sqf";
waitUntil {isNull _lulGen};
//diag_log format ["RLOG :: lulGen Ended"];
sleep 5;

waveEnded = true;