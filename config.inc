/*
	��������: ������� � ��������� �� ���������
	�����: ZiGGi

*/

#if defined _config_included
	#endinput
#endif

#define _config_included
#pragma library config

#pragma tabsize 0

#define VERSION					"v1.0.0 alpha 2" // ������ ����
#define GTO_FILES_FORMAT		".gto" // ����������(.txt ��� ������������ ������ �� ���� Linux �� �������������)
#define GTO_FILES_FOLDER		"Open-GTO/" // �����, ��� �������� ����� Open-GTO, � scriptfiles/

#define LANGUAGE_USE			"Russian" // ������������ ����
#define LANG_BB_N				"[n]" // ������� �� ����� ������

#define MAX_STRING				128 // �� ������, ���-�� �������� ��� ����������� ��������� ����������
#define MAX_NAME				40 // ���-�� �������� ��� ���, ������� � ��.

#define MAX_MONEY				50000000 // ������������ ���-�� �����, ������� ����� ����� �����
#define UpdatePlayerScore(%1)	SetPlayerScore(%1,GetPVarInt(%1,"Level"))
#define MAX_SEND_SYMBOLS		64 // ������������ ���-�� ������������ �������� � �� ����� click

#define INVALID_QUEST_ID		0
#define MAX_QUESTS				255

#define WORLD_SAVE_TIME			300000
// �������(��������� �� ���������)
#define ANTI_HEALTH_HACK_ENABLED	1 // ������ �� ���� �� ��������
#define ANTI_MONEY_HACK_ENABLED		1 // ������ �� ���� �� ������

#define ANTI_HIGHT_PING_ENABLED		1 // ������ �� �������� �����
#define MAXIMAL_PING				500 // ����, ��� ������� ������

#define ANTI_IDLE_ENABLED	1 // ������ �� ��� �� ������ ��������
#define MAX_IDLE_TIME		5 // ���-�� �����, ����� ������� ������

#define CHAT_GUARD_ENABLED	1 // ������ ����

// ������
#define GROUNDHOID_ENABLED	1 // ����� ��������

#define BANK_PROFIT		2 // ������� ���������� ������� �� �������� � �����
#define MAX_BANK_MONEY	15000000 // ������������ ���������� �����, ������� ����� ������� � �����

#define PAYDAY_BASE_PAY		500 // PayDay ����� �� ������
#define PAYDAY_CUTOFF		MAX_MONEY / 2 // ���-�� �����, ��� ������� ���������� �������� ������ �� PayDay
#define	PAYDAY_PAYXP		200 // PayDay ����� �� ����

// ����
//#define BUY_ALL_HOUSES // ��������� ��������� �������� ����� ����(���� ���������������� �� ����� ���� ����� ��������)
//

// �������
#define MAX_UPGRADELEVEL	30 // ������������ ������� �������� �������
#define UPGRADE_TARIF		10 // ����� ����� �� ��������� ������, �������: (Businesses[id][Business_Upgrade]+1) * Businesses[id][Business_Value] * UPGRADE_TARIF
//

// ���������
#define CARS_RESPAWN_TIME	600 // ����� �������� ���������� � �������� (86400 - ���� ����) 
//

// �����
#define MAX_GANGS			MAX_PLAYERS // �������� ���� ������
#define MAX_GANG_SIZE		12 // ������������ ���-�� ����� � �����

#define MIN_GANG_NAME_LEN	3 // ����������� ����� ����� �����
#define MAX_GANG_NAME_LEN	40 // ������������ ����� ����� �����

#define GANG_CREATE_COST	100000 // ���-�� �����, ��������� �� �������� �����
#define GANG_COLOUR_COST	20000 // ���-�� �����, ��������� �� ����� ����� �����
//

// �����
#define MIN_HEALTH				35.0 // �����������(���������) ���-�� ��������
#define MAX_HEALTH				100.0 // ������������ ���-�� ��������
#define HEALTH_TARIF			4.0	// ������� ���������� ������������� �������� �� ���, �������: MIN_HEALTH + (GetPlayerLevel(playerid) * HEALTH_TARIF)
#define HEALTH_REGEN_TARIF		0.4 // ������� ���-�� ����������������� ��������, �������: (GetPlayerLevel(id) * HEALTH_REGEN_TARIF)

#define CHANGE_NICK_COST			10000 // ���-�� �����, ��������� ��� ����� ����
#define MIN_NICK_LEN				3
#define CHANGE_PASS_COST			5000 // ���-�� �����, ��������� ��� ����� ������
#define MIN_PASS_LEN				3
// ������
	// trucker
	#define TRUCKER_GIVE_XP_RATE	5 // ���-�� ����� �� �����, �������: ( (GetPlayerLevel(playerid)+1) * 2 )^2 * trucker_GIVE_XP_RATE
	#define TRUCKER_RUNNER_MISSION_TIME 300000 // ����� �������� ����� ��������, � ������������
	//
	
//
// ��� ������
#define PLAYER_XP_DEATH_MINUS_PROC		3 // ������� ��������� XP ��������� �� ��� ���������� �����
#define PLAYER_MONEY_DEATH_MINUS_PROC	20 // ������� ��������� ����� ���������

// ��������� ��������� ������
#define PLAYER_START_MONEY		1500 // ���-�� ��������� �����
#define PLAYER_START_WEAPON_1	WEAPON_COLT45 // �� ������� ���������� ������
#define PLAYER_START_WEAPON_2	0 // �� ������� ���������� ������
#define PLAYER_START_WEAPON_3	0 // �� �������� ���������� ������

#define MAX_COUNTDOWN		5 // ���-�� ������ ��� ������� ����� � ��
#define KEY_USING			KEY_WALK // ������ '������' - �������� �� �������� ��������(����, ������� ����������...), ������/�������

// �������
enum {
	message_DialogID,
	account_Reg_DialogID, account_Log_DialogID,
	bank_FirstList_DialogID, bank_Withdraw_DialogID, bank_Deposit_DialogID,
	click_DialogID, click_Resp_DialogID,
	house_DialogID, houses_DialogID,
	bis_DialogID, bis_Info_DialogID, bis_Msg_DialogID,
	fightstyles_DialogID, fightstyles_user_DialogID,
	user_menu_DialogID, user_menu_Return_DialogID, vehicle_menu_DialogID,
	weapons_Select_DialogID, weapons_Buy_DialogID,
	bar_DialogID,
	fastfood_DialogID,
}

// ������
#define ini_Create		ini_createFile
#define ini_Open		ini_openFile
#define ini_Close		ini_closeFile
#define ini_Set			ini_setString
#define ini_SetInt		ini_setInteger
#define ini_SetFloat	ini_setFloat
#define ini_Get			ini_getString
#define ini_GetInt		ini_getInteger
#define ini_GetFloat	ini_getFloat
#define ini_Remove		ini_removeKey
#define ini_Remov(%0)	fremove(%0)
#define ini_Exist(%0)	fexist(%0)

#define COLOUR_GREY 0xAFAFAFAA // grey
#define COLOUR_GREEN 0x33AA33AA // green
#define COLOUR_LIGHTGREEN 0x9ACD32AA //lightgreen
#define COLOUR_RED 0xAA3333AA // red
#define COLOUR_LIGHTRED 0xFF6347AA // lightred
#define COLOUR_YELLOW 0xFFFF00AA // yellow
#define COLOUR_WHITE 0xFFFFFFAA // white
#define COLOUR_BLUE 0x33AAFFAA // blue
#define COLOUR_LIGHTBLUE 0x33CCFFAA // LightBlue
#define COLOUR_ORANGE 0xFF9900AA //orange
#define COLOUR_PURPLE 0xC2A2DAAA //purple
#define COLOUR_CRIMSON 0xDC143CAA
#define COLOUR_LIMEGREEN 0x32CD32AA
#define COLOUR_AQUA 0x00FFFFAA
#define COLOUR_FLBLUE 0x6495EDAA
#define COLOUR_MAGENTA 0xFF00FFFF
#define COLOUR_GOLD 0xB8860BAA
#define COLOUR_PINK 0xFFC0CBAA
#define COLOUR_MISC 0xAFAFAFAA // Grey - Misc
#define COLOUR_CHAT 0xFFFFFFAA // White - Chat
#define COLOUR_PLAYER 0xAAAAAAAA // White - Player
#define COLOUR_XP_GOOD 0x00C7FFAA // Blue - XP
#define COLOUR_XP_BAD 0x00008BAA // Blue - XP
#define COLOUR_COMBAT_GOOD 0xAA3333AA // Red - Combat
#define COLOUR_COMBAT_BAD 0xBB3333AA // Red - Combat
#define COLOUR_MONEY_GOOD 0xFFFF00AA // Yellow - Money
#define COLOUR_MONEY_BAD 0xDAA520AA // Yellow - Money
#define COLOUR_RACE 0x005407AA // green - dark
#define COLOUR_RACE_BAD 0x545407AA // yellow-green-dark
#define COLOUR_GANG 0xFF8C00AA // orange
#define COLOUR_GANG_CHAT 0xFFA500AA // orange
#define COLOUR_DM 0xFF0066AA // red - purple
#define COLOUR_DM_BAD 0xFF0066AA // red - purple


#define SOUND_MUSIC_CLASSSELECT		1185
#define SOUND_MUSIC_RACEFINISH		1183
#define SOUND_MUSIC_RACERECORD		1097
#define SOUND_MUSIC_MISSIONCOMPLETE	1185
#define SOUND_OFF					1184
#define SOUND_BLIP1					1056
#define SOUND_BLIP2					1057
#define SOUND_EXPLOSION				1159
#define SOUND_PURCHASE				1149
#define SOUND_CHECKPOINT			1058
#define SOUND_DEATH					1057
#define SOUND_DMKILL				1056
#define SOUND_DMDEATH				1057

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))