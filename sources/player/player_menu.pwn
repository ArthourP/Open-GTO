/*

	Created: 07.04.2011
	Author: ziggi

*/

#if defined _player_menu_included
	#endinput
#endif

#define _player_menu_included

/*
	PMenu_OnPlayerKeyStateChange
*/

PMenu_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (!PRESSED(KEY_USING)) {
		return 0;
	}

	Dialog_Show(playerid, Dialog:PlayerMenu);
	return 1;
}

DialogCreate:PlayerMenu(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerMenu, DIALOG_STYLE_LIST,
		"���� ������",
		"���������� � ���������\n\
		������������\n\
		�����\n\
		����� ������\n\
		��������\n\
		���������\n\
		��������� ������\n\
		����� ������\n\
		��� �������\n\
		��� ���������\n\
		������������� ������\n\
		���������\n\
		������",
		"��", "������"
	);
}

DialogResponse:PlayerMenu(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		// ���������� � ���������
		case 0: {
			new premium_status[MAX_NAME];
			if (IsPlayerHavePremium(playerid)) {
				format(premium_status, sizeof(premium_status), "�� %s", ReturnPlayerPremiumDateString(playerid));
			} else {
				strcpy(premium_status, "���");
			}

			new fstylename[MAX_STRING];
			GetFightStyleName(GetPlayerFightStyleUsed(playerid), fstylename);

			new gangname[MAX_GANG_NAME];
			GetPlayerGangName(playerid, gangname);
			if (strlen(gangname) == 0) {
				strcpy(gangname, "���");
			}

			new played_time[MAX_LANG_VALUE_STRING];
			GetTimeStringFromSeconds(Account_GetCurrentPlayedTime(playerid), played_time);

			new money_str[16], bank_money_str[16], total_money_str[16];
			InsertSpacesInInt(GetPlayerMoney(playerid), money_str);
			InsertSpacesInInt(GetPlayerBankMoney(playerid), bank_money_str);
			InsertSpacesInInt(GetPlayerTotalMoney(playerid), total_money_str);

			new string[MAX_LANG_MULTI_STRING];
			__m(PLAYER_MENU_INFO, string);

			format(string, sizeof(string),
				string,

				GetPlayerLevel(playerid),
				GetPlayerXP(playerid), GetXPToLevel(GetPlayerLevel(playerid) + 1),
				timestamp_to_format_date( Account_GetRegistrationTime(playerid) ),
				played_time,

				gangname,

				money_str, bank_money_str, total_money_str,

				GetPlayerKills(playerid), GetPlayerDeaths(playerid), GetPlayerKillDeathRatio(playerid),
				GetPlayerJailedCount(playerid),
				GetPlayerMutedCount(playerid),

				fstylename,
				premium_status
			);

			Dialog_Open(playerid, Dialog:PlayerReturnMenu, DIALOG_STYLE_MSGBOX, "���������� � ���������", string, "�����", "�����");
			return 1;
		}
		// competition
		case 1: {
			Dialog_Show(playerid, Dialog:CompetitionMenu);
			return 1;
		}
		// �����
		case 2: {
			Dialog_Show(playerid, Dialog:GangMenu);
			return 1;
		}
		// ����� ������
		case 3: {
			Dialog_Show(playerid, Dialog:PlayerFights);
			return 1;
		}
		// ��������
		case 4: {
			Dialog_Show(playerid, Dialog:AnimLib);
			return 1;
		}
		// ���������
		case 5: {
			if (GetPVarInt(playerid, "teleports_Pause") == 1) {
				Dialog_Open(playerid, Dialog:PlayerReturnMenu, DIALOG_STYLE_MSGBOX, "���� ����������", "�� ������� �����������������, �����...", "�����", "�����");
				return 0;
			}
			Dialog_Show(playerid, Dialog:PlayerTeleportMenu);
			return 1;
		}
		// ��������� ������
		case 6: {
			ResetPlayerWeapons(playerid);
			Dialog_Open(playerid, Dialog:PlayerReturnMenu, DIALOG_STYLE_MSGBOX, "��������� ������", "�� ����������� ���������� �� ����� ������.", "�����", "�����");
			return 1;
		}
		// ����� ������
		case 7: {
			Dialog_Show(playerid, Dialog:PlayerSpawnMenu);
			return 1;
		}
		// ��� �������
		case 8: {
			Dialog_Show(playerid, Dialog:BusinessPlayerOwned);
			return 1;
		}
		// ��� ���������
		case 9: {
			Dialog_Show(playerid, Dialog:PlayerVehicleMenu);
			return 1;
		}
		// ������������� ������
		case 10: {
			new idsa = 0,
				idsm = 0,
				admins[(MAX_PLAYER_NAME + 1 + 5) * 10],
				moders[(MAX_PLAYER_NAME + 1 + 5) * 10];

			foreach (new id : Player) {
				if (IsPlayerHavePrivilege(id, PlayerPrivilegeAdmin)) {
					format(admins, sizeof(admins), "%s%s(%d)\n", admins, ReturnPlayerName(id), id);
					idsa++;
				} else if (IsPlayerHavePrivilege(id, PlayerPrivilegeModer)) {
					format(moders, sizeof(moders), "%s%s(%d)\n", moders, ReturnPlayerName(id), id);
					idsm++;
				}
			}

			new string[(MAX_PLAYER_NAME + 1 + 5) * 20 + 64];
			if (idsa == 0 && idsm == 0) {
				format(string, sizeof(string), _(NO_ADMINS));
			} else {
				if (idsa != 0) {
					format(string, sizeof(string), "�������������:\n%s\n", admins);
				}

				if (idsm != 0) {
					format(string, sizeof(string), "%s\n���������:\n%s\n", string, moders);
				}
			}

			Dialog_Open(playerid, Dialog:PlayerReturnMenu, DIALOG_STYLE_MSGBOX, "������������� ������", string, "�����", "�����");
			return 1;
		}
		// ���������
		case 11: {
			Dialog_Show(playerid, Dialog:PlayerSettingsMenu);
			return 1;
		}
		// ������
		case 12: {
			Dialog_Open(playerid, Dialog:PlayerReturnMenu, DIALOG_STYLE_MSGBOX,
				"���������� � ������",
				"{AFE7FF}�� ������� �������:\n\
				\n\
				\t{FFFFFF}Open - Grand Theft Online {AA3333}"VERSION_STRING"{FFFFFF}.\n\
				\n\
				\n\
				{00C0DD}������ {AFE7FF}Iain Gilbert\n\
				\n\
				{00C0DD}����������:{AFE7FF}\n\
							\tPeter Steenbergen\n\
							\tRobin Kikkert\n\
							\tAsturel\n\
							\tDmitry Frolov (FP)\n\
							\tOpen-GTO Team:\n\
							\t\t�������: ziggi\n\
							\t\t����������: GhostTT, heufix, Elbi\n\
				\n\
				{00C0DD}�������������: {AFE7FF}\n\
							\tMX_Master - mxINI, Chat-Guard.\n\
							\tY_Less - foreach, fixes, sscanf2.\n\
							\tZeeX - zcmd, crashdetect, Pawn Compiler.\n\
							\tIncognito - Streamer.\n\
							\tD0erfler - mSelection.\n\
							\tNexius - MapFix.\n\
				\n\
				",
				"�����", "�����"
			);
			return 1;
		}
	}
	return 1;
}

DialogResponse:PlayerReturnMenu(playerid, response, listitem, inputtext[])
{
	if (response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}
