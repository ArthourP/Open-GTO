/*

	��������: ����� ������ � ������
	�����: ziggi

*/


#if defined _weapon_skill_included
	#endinput
#endif

#define _weapon_skill_included
#pragma library weapon_skill


static wskill_Enabled = WEAPON_SKILL_ENABLED;

#define PLAYER_WEAPON_SKILLS 11
new PlayerWeaponsSkills[MAX_PLAYERS][PLAYER_WEAPON_SKILLS];
new Text:weapon_TextDraw_Level[MAX_PLAYERS];

stock wskill_LoadConfig(file_config)
{
	ini_getInteger(file_config, "Weapon_Skill_IsEnabled", wskill_Enabled);
}

stock wskill_SaveConfig(file_config)
{
	ini_setInteger(file_config, "Weapon_Skill_IsEnabled", wskill_Enabled);
}

stock wskill_OnPlayerConnect(playerid)
{
	if (!wskill_Enabled) {
		return 0;
	}
	weapon_TextDraw_Level[playerid] = TextDrawCreate(499.000000, 13.000000, "999/1000");
	TextDrawBackgroundColor(weapon_TextDraw_Level[playerid], 255);
	TextDrawFont(weapon_TextDraw_Level[playerid], 1);
	TextDrawLetterSize(weapon_TextDraw_Level[playerid], 0.240000, 1.000000);
	TextDrawColor(weapon_TextDraw_Level[playerid], -1);
	TextDrawSetOutline(weapon_TextDraw_Level[playerid], 0);
	TextDrawSetProportional(weapon_TextDraw_Level[playerid], 1);
	TextDrawSetShadow(weapon_TextDraw_Level[playerid], 1);
	return 1;
}

stock wskill_OnPlayerDisconnect(playerid,reason)
{
	#pragma unused reason
	if (!wskill_Enabled) {
		return 0;
	}
	wskill_HideTextDraw(playerid);
	TextDrawDestroy(weapon_TextDraw_Level[playerid]);
	return 1;
}

stock wskill_OnPlayerDeath(playerid,killerid,reason)
{
	#pragma unused playerid
	if (killerid == INVALID_PLAYER_ID) {
		return 0;
	}

	if (!wskill_Enabled) {
		return 0;
	}

	if (!IsWeapon(reason)) {
		return 0;
	}

	new skill_id = GetWeaponSkillID(reason);
	if (skill_id == -1) {
		return 0;
	}

	if (PlayerWeaponsSkills[killerid][skill_id] < 1000) {
		PlayerWeaponsSkills[killerid][skill_id] += WEAPON_SKILL_SPEED;

		if (PlayerWeaponsSkills[killerid][skill_id] > 1000) {
			PlayerWeaponsSkills[killerid][skill_id] = 1000;
		}

		SetPlayerSkillLevel(killerid, skill_id, PlayerWeaponsSkills[killerid][skill_id]);
	}
	return 1;
}

stock wskill_OnPlayerRequestClass(playerid, classid)
{
	#pragma unused classid
	if (!wskill_Enabled) {
		return 0;
	}
	wskill_HideTextDraw(playerid);
	return 1;
}

stock weapon_SetSkills(playerid)
{
	for (new i = 0; i < PLAYER_WEAPON_SKILLS; i++)
	{
		SetPlayerSkillLevel(playerid, i, PlayerWeaponsSkills[playerid][i]);
	}
	return 1;
}

stock weapon_ResetSkills(playerid)
{
	for (new i = 0; i < PLAYER_WEAPON_SKILLS; i++) {
		PlayerWeaponsSkills[playerid][i] = 0;
		SetPlayerSkillLevel(playerid, i, 0);
	}
	return 1;
}

// �� ������ ��� ��� ������
stock GetWeaponSkillID(weaponid)
{
	static const
		weapon_skills[] = {
			WEAPONSKILL_PISTOL, // 22
			WEAPONSKILL_PISTOL_SILENCED, // 23
			WEAPONSKILL_DESERT_EAGLE, // 24
			WEAPONSKILL_SHOTGUN, // 25
			WEAPONSKILL_SAWNOFF_SHOTGUN, // 26
			WEAPONSKILL_SPAS12_SHOTGUN, // 27
			WEAPONSKILL_MICRO_UZI, // 28
			WEAPONSKILL_MP5, // 29
			WEAPONSKILL_AK47, // 30
			WEAPONSKILL_M4, // 31
			WEAPONSKILL_MICRO_UZI, // 32
			WEAPONSKILL_SNIPERRIFLE, // 33
			WEAPONSKILL_SNIPERRIFLE // 34
		};

	new index = weaponid - 22;

	if (index < 0 || index > sizeof(weapon_skills) - 1) {
		return -1;
	}

	return weapon_skills[index];
}
//

// ������ ������, ������������ ������ ��������
stock SetWeaponsSkillsFromDBString(playerid, dbstring[])
{
	new idx;
	for (new i = 0; i < PLAYER_WEAPON_SKILLS; i++)
	{
		PlayerWeaponsSkills[playerid][i] = strval( strcharsplit(dbstring, idx, '/') );
	}
}
// ���������� ������ ��� ���������� ������� ������
stock CreateWeaponSkillsDBString(playerid)
{
	new wepstr[MAX_STRING];
	for (new i = 0; i < PLAYER_WEAPON_SKILLS; i++)
	{
		format(wepstr, sizeof(wepstr), "%s%d/", wepstr, PlayerWeaponsSkills[playerid][i]);
	}
	return wepstr;
}
//

stock wskill_HideTextDraw(playerid)
{
	TextDrawHideForPlayer(playerid, weapon_TextDraw_Level[playerid]);
	return 1;
}

stock UpdatePlayerWeaponTextDraws(playerid)
{
	if (!wskill_Enabled) {
		return 0;
	}
	
	if (!Player_IsSpawned(playerid)) {
		return 0;
	}

	new skillid = GetWeaponSkillID( GetPlayerWeapon(playerid) );
	if (skillid != -1) {
		new string[MAX_STRING];
		format(string, sizeof(string), "%03d/1000", PlayerWeaponsSkills[playerid][skillid]);
		TextDrawSetString(weapon_TextDraw_Level[playerid], string);
		TextDrawShowForPlayer(playerid, weapon_TextDraw_Level[playerid]);
	} else {
		wskill_HideTextDraw(playerid);
	}
	return 1;
}
