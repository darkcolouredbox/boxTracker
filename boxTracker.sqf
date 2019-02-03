//////////////////////////////////
// Blackbox's shot tracking     //
// v1   It does things          //
//////////////////////////////////

// Call via init.sqf

if (isDedicated) exitWith {}; // Will not run on server, client-side loading

player addEventHandler ["FiredNear", {
	[_this select 1] spawn {
		params ["_firer"];
		if (side _firer == side player) then {} else {
			_shotPos = getPosASL _firer;
			_shotMarker = createMarker [format ["shotMark_%1%2", name _firer, time], _shotPos];
			_shotMarker setMarkerShape "ICON";
			_shotMarker setMarkerType "loc_Tree";
			_shotMarker setMarkerColor "colorRED";
			_shotMarker setMarkerPos _shotPos;
			_shotMarker setMarkerAlpha 1;
			_shotAlpha = 1;
			while {_shotAlpha > 0} do {
				_shotAlpha = _shotAlpha - 0.01;
				_shotMarker setMarkerAlpha _shotAlpha;
				sleep 0.05;
			};
			deleteMarker _shotMarker;
		};
	};
}];