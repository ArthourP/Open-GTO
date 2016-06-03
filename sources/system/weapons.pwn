/*
	Created: 05.09.06
	Aurthor: Iain Gilbert
	Modified by ziggi
*/


#if defined _weapons_included
	#endinput
#endif

#define _weapons_included


#define MAX_BULLETS				9000

enum WeaponInfo {
	Weapon_Name[MAX_NAME], // weapon name
	Weapon_Allowed, // is weapon allowed
	Weapon_IsFirearm, // is weapon is firearm
	Weapon_Cost, // cost per bullet
	Weapon_Level // player level required to buy this weapon
}

new Weapons[][WeaponInfo] = {
	{"����������",                    0, 0, 0,     0},
	{"������",                        1, 0, 600,   4},
	{"������ ��� ������",             0, 0, 600,   2},
	{"�������",                       0, 0, 1000,  8},
	{"���",                           1, 0, 1000,  10},
	{"����������� ����",              1, 0, 1500,  7},
	{"������",                        0, 0, 100,   0},
	{"���",                           1, 0, 100,   2},
	{"������",                        1, 0, 2000,  8},
	{"���������",                     1, 0, 750,   9},
	{"��������� Dildo",               0, 0, 500,   6},
	{"�����",                         1, 0, 500,   5},
	{"��������",                      0, 0, 700,   8},
	{"���������� ��������",           0, 0, 500,   4},
	{"����� ������",                  1, 0, 100,   3},
	{"������",                        0, 0, 100,   1},

	{"�������",                       1, 1, 800,   27},
	{"������� ������",                0, 1, 400,   5},
	{"�������� ��������",             0, 1, 550,   30},
	{"�����������",                   0, 0, 10,    30},
	{"�����������",                   0, 0, 10,    30},
	{"�����������",                   0, 0, 10,    30},
	{"�������� 9��",                  1, 1, 10,    0},
	{"�������� 9�� � ����������",     1, 1, 10,    5},
	{"��������� ���",                1, 1, 20,    10},
	{"��������",                      1, 1, 15,    5},
	{"��������� ��������",            1, 1, 25,    15},
	{"������ ��������",               1, 1, 40,    10},
	{"���",                           1, 1, 30,    20},
	{"MP5",                           1, 1, 25,    20},
	{"AK-47",                         1, 1, 40,    23},
	{"M4",                            1, 1, 40,    23},
	{"Tec-9",                         1, 1, 30,    20},
	{"��������",                      1, 1, 150,   22},
	{"����������� ��������",          1, 1, 400,   26},
	{"���",                           1, 1, 1000,  30},
	{"���������� �������� ���������", 0, 1, 1000,  29},
	{"������",                       0, 1, 200,   28},
	{"������ ������(�������)",       0, 1, 100,   30},
	{"���������� ������",             0, 1, 500,   30},
	{"��������� � �������",           0, 0, 1,     30},

	{"��������� � �������",           0, 1, 40,    5},
	{"������������",                  0, 1, 10,    5},
	{"����������",                    0, 1, 60,    5},
	{"���� ������� �������",          0, 0, 10,    0},
	{"�������� ����",                 0, 0, 10,    0},
	{"�������",                       1, 0, 500,   1},
	{"�����",                         1, 0, 200,   10}
};

weapon_LoadConfig(file_config)
{
	ini_getString(file_config, "Weapon_DB", db_weapon);
}

weapon_SaveConfig(file_config)
{
	ini_setString(file_config, "Weapon_DB", db_weapon);
}

weapon_LoadAll()
{
	new file_weapons,
		db_weaponname[MAX_STRING];

	for (new i = 0; i < sizeof(Weapons); i++) {
		format(db_weaponname, sizeof(db_weaponname), "%sid_%d"DATA_FILES_FORMAT, db_weapon, i);
		if (!ini_fileExist(db_weaponname)) {
			continue;
		}

		file_weapons = ini_openFile(db_weaponname);

		ini_getString(file_weapons, "Name", Weapons[i][Weapon_Name], MAX_NAME);
		ini_getInteger(file_weapons, "IsAllowed", Weapons[i][Weapon_Allowed]);
		ini_getInteger(file_weapons, "Level", Weapons[i][Weapon_Level]);
		ini_getInteger(file_weapons, "Price", Weapons[i][Weapon_Cost]);

		ini_closeFile(file_weapons);
	}
	return 1;
}

weapon_SaveAll()
{
	new file_weapons,
		db_weaponname[MAX_STRING];

	for (new i = 0; i < sizeof(Weapons); i++) {
		format(db_weaponname, sizeof(db_weaponname), "%sid_%d"DATA_FILES_FORMAT, db_weapon, i);
		file_weapons = (!ini_fileExist(db_weaponname)) ? ini_createFile(db_weaponname) : ini_openFile(db_weaponname);

		ini_setString(file_weapons, "Name", Weapons[i][Weapon_Name]);
		ini_setInteger(file_weapons, "IsAllowed", Weapons[i][Weapon_Allowed]);
		ini_setInteger(file_weapons, "Level", Weapons[i][Weapon_Level]);
		ini_setInteger(file_weapons, "Price", Weapons[i][Weapon_Cost]);

		ini_closeFile(file_weapons);
	}
	return 1;
}

weapon_OnGameModeInit()
{
	weapon_LoadAll();
	EnableVehicleFriendlyFire();
	Log_Game("SERVER: Weapon module init");
}

weapon_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	#pragma unused weaponid

	if (damagedid == INVALID_PLAYER_ID) {
		return 1;
	}

	if (IsPlayerGodmod(damagedid)) {
		return 1;
	}

	new team = GetPlayerTeam(playerid);
	if (team != NO_TEAM && team == GetPlayerTeam(damagedid)) {
		return 1;
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		amount /= 2.0;
	}

	if (bodypart == BODY_PART_HEAD) {
		amount *= 1.5;
	}

	new
		Float:health,
		Float:armour,
		Float:difference;

	GetPlayerHealth(damagedid, health);
	GetPlayerArmour(damagedid, armour);

	difference = armour - amount;

	if (difference > 0.0) {
		SetPlayerArmour(damagedid, difference);
	} else {
		SetPlayerArmour(damagedid, 0.0);
		SetPlayerHealth(damagedid, health + difference);
	}

	return 1;
}

weapon_OnPlayerStateChange(playerid, newstate, oldstate)
{
	#pragma unused oldstate
	new
		weaponid,
		ammo;

	if (newstate == PLAYER_STATE_DRIVER) {
		// fix for GetPlayerAmmo
		GetPlayerWeaponData(playerid, 4, weaponid, ammo);
		SetPlayerArmedWeapon(playerid, weaponid);
	} else if (newstate == PLAYER_STATE_PASSENGER) {
		weaponid = GetPlayerWeapon(playerid);

		// check semi automatic
		new
			semi_automatic_id,
			semi_automatic_ammo,
			bool:is_disabled_semi_automatic = false;

		GetPlayerWeaponData(playerid, 4, semi_automatic_id, semi_automatic_ammo);

		switch (semi_automatic_id) {
			case WEAPON_DRIVEBY_DISABLED: {
				is_disabled_semi_automatic = true;
			}
		}

		// set armed weapon
		switch (weaponid) {
			case WEAPON_DRIVEBY_DISABLED: {
				if (!is_disabled_semi_automatic) {
					SetPlayerArmedWeapon(playerid, semi_automatic_id);
				} else {
					SetPlayerArmedWeapon(playerid, 0);
				}
			}
		}
	}

	return 1;
}

stock ReturnWeaponName(weaponid)
{
	new name[MAX_NAME];
	name = "Unknown";

	if (!IS_IN_RANGE(weaponid, 0, sizeof(Weapons))) {
		return name;
	}

	strmid(name, Weapons[weaponid][Weapon_Name], 0, strlen(Weapons[weaponid][Weapon_Name]));
	return name;
}

stock GetWeaponMaxAmmo(weaponid)
{
	if (!IS_IN_RANGE(weaponid, 0, sizeof(Weapons))) {
		return 0;
	}

	if (Weapons[weaponid][Weapon_IsFirearm] == 1) {
		return MAX_BULLETS;
	}

	return 1;
}

stock IsPlayerAllowedWeapon(playerid, weaponid)
{
	if (!IS_IN_RANGE(weaponid, 0, sizeof(Weapons))) {
		return 0;
	}

	if (Weapons[weaponid][Weapon_Allowed] == 0 || Weapons[weaponid][Weapon_Level] > GetPlayerLevel(playerid)) {
		return 0;
	}

	return 1;
}

stock IsWeaponHandToHand(weaponid)
{
	if (!IS_IN_RANGE(weaponid, 0, sizeof(Weapons))) {
		return 0;
	}

	if (Weapons[weaponid][Weapon_IsFirearm] == 0) {
		return 1;
	}

	return 0;
}

stock GetWeaponCost(weaponid)
{
	if (!IS_IN_RANGE(weaponid, 0, sizeof(Weapons))) {
		return 0;
	}

	return Weapons[weaponid][Weapon_Cost];
}

stock IsWeapon(weaponid)
{
	if (IS_IN_RANGE(weaponid, 0, 46)) {
		return 1;
	}
	return 0;
}

// ���������� ��������� ������ �� ������
stock ShowWeaponsOnLevel(playerid, newlevel, oldlevel)
{
	new
		string[MAX_STRING],
		wepfound = 0;

	for (new weaponid = 1; weaponid < sizeof(Weapons); weaponid++) {
		if (Weapons[weaponid][Weapon_Allowed] == 0) {
			continue;
		}

		if (Weapons[weaponid][Weapon_Level] > oldlevel && Weapons[weaponid][Weapon_Level] <= newlevel) {
			if (wepfound == 0) {
				SendClientMessage(playerid, COLOR_GREEN, _(PLAYER_LEVEL_NEW_WEAPON));
				wepfound = 1;
			}
			format(string, sizeof(string), _(PLAYER_LEVEL_NEW_WEAPON_ITEM), ReturnWeaponName(weaponid), GetWeaponCost(weaponid));
			SendClientMessage(playerid, COLOR_MISC, string);
		}
	}
	return 1;
}
