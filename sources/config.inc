/*

	About: defines and default settings
	Author: ziggi

*/

#if defined _config_included
	#endinput
#endif

#define _config_included

#define OPEN_GTO

/*
 * Core settings
 */

#define MAX_STRING  128
#define MAX_NAME    40
#define MAX_IP      16


/*
 * System settings
 */

//#define FS_USING // ���� �����������, �� ���������� ����� � ������ ������������� � FS (fixes, api)

#define MODE_NAME       "Open-GTO"
#define VERSION_MAJOR   2
#define VERSION_MINOR   0
#define VERSION_BUILD   0
#define VERSION_EXTRA   "-alpha"
#define VERSION_NAME    "New generation"

#define VERSION_STRING          "v2.0.0-alpha" // �� ����������� ���� ������ ����������: "v" #VERSION_MAJOR "." #VERSION_MINOR "." #VERSION_BUILD VERSION_EXTRA
#define GAMEMODE_TEXT           MODE_NAME " " VERSION_STRING
#define DATA_FILES_FORMAT       ".ini" // ����������(.txt ��� ������������ ������ �� ���� GNU/Linux �� �������������)
#define DATA_FILES_FOLDER       "open-gto/" // ������� � scriptfiles/, ��� �������� ����� Open-GTO

#define MDIALOG_ZLANG_MODE
#define MAX_LANG_FORMAT_STRING (288)
#define USE_PLAYER_PED_ANIMS
#define USED_PLAYER_MARKERS     PLAYER_MARKERS_MODE_GLOBAL
#define STREAMER_MAP_ICON_SD 300.0
#define USE_INCOGNITO_STREAMER // use streamer in MapFix script
#define FOREACH_I_PlayerPlayersStream
#define FOREACH_I_VehiclePlayersStream

#define PASSWORD_ENCRYPT_ENABLED // ���� �����������, �� ������ � ����� ������ ����� �����������
#define PASSWORD_SALT_LENGTH  12 // ����� ���� ��� ����
#define PASSWORD_HASH_LENGTH  64 // ����� ����

#define DEFAULT_ALPHABET "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define SERVER_REAL_TIME            1 // ������� ����� ������������� �������� ������� �������
#define SERVER_REAL_TIME_OFFSET     0 // �������� ������� ������������ �������

#define MAX_QUESTS          255
#define MAX_FIGHTS          6 // ������������ ���������� ������ ������ (����� �� ������)

#define WORLD_SAVE_TIME     300000 // 1 ���, �� ��� ���-�� ���������� ����������� ���������� ����� ����(300000 - 5 �����)

#define LOG_PRINTING // ���� ����������, �� ������� ������� ��������� � ������� �������
// ����(��������� �� ���������) 1 ���, 0 ����
#define LOG_MAIN_ENABLED    1 // ����������� ��������� ���������
#define LOG_SYSTEM_ENABLED  1 // ����������� ��������� ���������
#define LOG_PLAYER_ENABLED  1 // ����������� �������� ������

#define KEY_USING      KEY_YES // ������ 'Y' - �������� �� �������� ��������(����, ������� ����������...), ������/�������
#define KEY_NAME       "Y"

// ����������� ������� � ���������
#define ALLOWED_STRING_SYMBOLS      'a'..'z','A'..'Z','0'..'9','_','[',']','=','(',')',' '
#define ALLOWED_STRING_SYMBOLS_STR  "'a'..'z','A'..'Z','0'..'9','_','[',']','=','(',')',' '"
#define ALLOWED_NICK_SYMBOLS        'a'..'z','A'..'Z','0'..'9','_','[',']','.','=','(',')'
#define ALLOWED_NICK_SYMBOLS_STR    "'a'..'z','A'..'Z','0'..'9','_','[',']','.','=','(',')'"

// ������
#define MAPICON_HOSPITAL

#define MAX_PLAYER_LOGIN_ATTEMPT    3 // ������������ ���������� ������� �����

#define MIN_SEND_SYMBOLS  2 // ����������� ���-�� ������������ �������� � ��
#define MAX_SEND_SYMBOLS  200 // ������������ ���-�� ������������ �������� � ��

#define MIN_NAME_LEN      3
#define MAX_NAME_LEN      20

#define MIN_PASS_LEN      3
#define MAX_PASS_LEN      40


/*
 * Protection settings
 */

#define ANTI_HEALTH_HACK_ENABLED      1 // ������ �� ���� �� ��������

#define ANTI_HIGH_PING_ENABLED        1 // ������ �� �������� �����
#define MAXIMAL_PING                  500 // ����, ��� ������� ������

#define ANTI_IDLE_ENABLED             1 // ������ �� ��� �� ������ ��������
#define ANTI_IDLE_TIME                5 // ���-�� �����, ����� ������� ������

#define CHAT_GUARD_ENABLED            1 // ������ ����
#define ANTI_RCON_HACK_ENABLED        1 // ������ �� ������ rcon ������
#define ANTI_ARMOUR_HACK_ENABLED      1 // ������ �� ���� �� �����
#define ANTI_SPECIAL_ACTION_ENABLED   1 // ������ �� ��������� special action

#define ANTI_WEAPON_HACK_ENABLED      1 // ������ �� ���� �� ������ � �������
#define ANTI_WEAPON_HACK_DELAY_TIME   1000 // ����������� ����� ����������

#define ANTI_VEHICLE_TELEPORT_ENABLED 1 // ������ �� ������������ ����������
#define ANTI_VEHICLE_TELEPORT_DISTANCE 20.0

#define PROTECTION_TELEPORT_ENABLED       1 // ������ �� speedhack, airbreak, ������������(���� ����������� ������ ������������, �������������� �������� ����)
#define PROTECTION_TELEPORT_DELAY         1000 // ����� �������� ����� ������ ���������
#define PROTECTION_TELEPORT_TIMER         400 // ����� �������
#define PROTECTION_TELEPORT_MAX_VEHICLE_DISTANCE 140.0
#define PROTECTION_TELEPORT_MAX_DISTANCE         80.0

/*
 * Gameplay settings
 */

// start player settings
#define PLAYER_START_LEVEL    1 // �������, ������� ����� ������ ����� �����������
#define PLAYER_START_MONEY    100 // ���-�� ��������� �����
#define PLAYER_START_WEAPON   {WEAPON_COLT45, 850}
//#define PLAYER_START_SKIN     95 // ���� �� ��������� (���� ���������, �� ����� ����� �����������)

// player
#define MIN_HEALTH            25.0 // �����������(���������) ���-�� ��������
#define MAX_HEALTH            100.0 // ������������ ���-�� ��������
#define HEALTH_TARIF          3.0 // ������� ���������� ������������� �������� �� ���, �������: MIN_HEALTH + (GetPlayerLevel(playerid) * HEALTH_TARIF)
#define HEALTH_REGEN_TARIF    0.1 // ������� ���-�� ����������������� ��������, �������: (GetPlayerLevel(id) * HEALTH_REGEN_TARIF)

#define MAX_LEVEL             60 // ������������ ������� ������
#define XP_RATE               50 // ����������� ���������� ����� ��� ������, ������� (XP_RATE * (3 * level + 2) * (level - 1))

#define MAX_MONEY             999_999_999 // ������������ ���-�� �����, ������� ����� ����� �����

#define CHANGE_NICK_COST      5000000 // ���-�� �����, ��������� ��� ����� ����

#define PLAYER_XP_PREMIUM_PROFIT  10 // ������� ������ �������� �� PLAYER_XP_PREMIUM_PROFIT ��������� ������ �����

#define MIN_REPORTS_FOR_JAIL  3 // ����������� ���������� �������� ��� ������� � ������
#define SKYDIVE_TIME          (5 * 60) // �����, ����� ������� ����� ����� ����� ������������ /skydive, � ��������
#define SYS_WEATHER_UPDATE    20 // �����, ����� ������� ��������� ��������� ������, � �������, ���� 0, �� ���������
#define TELEPORTS_PAUSE_TIME  300 // ����� ����� ����������������, ����� ������� ����� ��������� �����������������, � ��������

// on death
#define PLAYER_XP_KILL_TARIF            4 // �������� �� ���������� ����������� ����� ��� ��������, ��������� � ������� player_OnPlayerKill
#define PLAYER_XP_DEATH_MINUS_PROC      10 // ������� ��������� XP ��������� �� ��� ���������� �����
#define PLAYER_MONEY_DEATH_MINUS_PROC   20 // ������� ��������� ����� ���������

// admin
#define ADMIN_TELEPORT_ENABLED          1 // ��������-�� ������� ������������ ������������� �� ����� �� �����
#define ADMIN_TELEPORT_MIN_PRIVILEGE    PlayerPrivilegeAdmin // ����������� ������� ������� ��� ������������

// lottery
#define LOTTERY_ENABLED      1 // �������-�� ������ �������
#define LOTTERY_START_DELAY  60 // ����� ���������, � ��������
#define LOTTERY_WAIT_DELAY   3600 // ����� ������ ���������, � ��������
#define LOTTERY_WIN_MONEY    200000 // ���������� ����� ���������� � �������
#define LOTTERY_TICKET_COST  5000 // ���� ����������� ������

// skins
#define SKINS_COST    0 // ���� ������� �����
#define SKINS_IGNORE  0, 74  // ������ ������������ ������
#define MSELECT_MAX_ITEMS 310

// groundhold
#define GROUNDHOLD_ENABLED    1 // ����� ��������
#define GROUNDHOLD_HOLD_TIME  2 // �������� ������ ����� ��� ������ �� ����

// bank
#define BANK_PROFIT      2 // ������� ���������� ������� �� �������� � �����
#define BANK_PROFIT_PREMIUM  (BANK_PROFIT * 2) // ������� ���������� ������� �� �������� � ����� ��� ������� � �������
#define MAX_BANK_MONEY   1000000000 // ������������ ���������� �����, ������� ����� ������� � �����

// payday
#define PAYDAY_BASE_PAY  25 // PayDay ����� �� ������
#define PAYDAY_CUTOFF    (MAX_MONEY / 2) // ���-�� �����, ��� ������� ���������� �������� ������ �� PayDay
#define PAYDAY_PAYXP     200 // PayDay ����� �� ����

// weapon
#define WEAPON_SKILL_ENABLED  1 // �������� �������� ������ (���� ���������, �� ������ �� ���������)
#define WEAPON_SKILL_SPEED    10 // ���������� ��������� ������ �� ���� ��������
#define WEAPON_DROP_ENABLED   1 // �������� ��������� ������
#define WEAPON_DROP_TIME      10 // �����, ����� �������� �������� ������, �������� �� ������, � ��������
#define WEAPON_DROP_BULL      5 // ������� ��������� ���������� ������ ������� �� ������
#define MAX_DROPPED_WEAPONS   64 // ������������ ���������� ��������� ������ �������������(� ���� �������)
#define WEAPON_DRIVEBY_DISABLED WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE, WEAPON_SHOTGSPA

// house
#define PLAYER_HOUSE_INCREASE_LEVELS 0, 20, 40, 60 // ������, ��� ���������� ������� ������������� ����. ����� ������
#define HOUSE_UPGRADE_ARMOUR_COST  500000
#define HOUSE_UPGRADE_HEALTH_COST  100000
#define HOUSE_UPGRADE_USE_TIME     300 // ����� ����� ������� ����� ������������ ������� � ���� (� ��������)
//#define BUY_ALL_HOUSES // ��������� ��������� �������� ����� ����(���� ���������������� �� ����� ���� ������ ��������)

// business
#define PLAYER_BUSINESS_INCREASE_LEVELS 0, 20, 40, 60 // ������, ��� ���������� ������� ������������� ����. �������� ������
#define MAX_BUSINESS_LEVEL   3 // ������������ ������� �������� �������
#define UPGRADE_TARIF        100 // ����� ����� �� ��������� ������, �������: (Businesses[id][Business_Upgrade]+1) * Businesses[id][Business_Value] * UPGRADE_TARIF
//#define BUY_ALL_BUSINESS // ��������� ��������� �������� ����� �������(���� ���������������� �� ����� ������� ������ ��������)
#define BUSINESS_UNLOGIN_SELL_DAYS  14 // ���������� ����, ����� ������� ������ ����� ������, ���� ����� �� ������ � ����

// other
#define MAX_GULPS            3 // ������������ ���������� ������� �� �������
#define GPICKUP_RESPAWN_TIME 90 // ���-�� ������ ����� ������� ����� �������� �������� �����

/*
 * Vehicle settings
 */

#define PLAYER_VEHICLE_INCREASE_LEVELS  0, 20, 30, 40, 50, 60 // ������, ��� ���������� ������� ������������� ����. ��������� ������
#define VEHSHOP_CAR_CHANGE_TIME  3 // ���������� �����, ����� ������� ��������� � �������� ��������
#define VEHICLE_RESPAWN_TIME     600 // ����� �������� ���������� � �������� (86400 - ���� ����)
#define OLD_ENGINE_DO // ��� � ��������� - ��������, ����� - ������(���� �����������)

// ��������� � VEHICLE_LIGHTS_ON_TIME � VEHICLE_LIGHTS_OFF_TIME �������� 0, ���� ������, ����� ���� ���������� � ����� �����
#define VEHICLE_LIGHTS_ON_TIME   16 // �����(�����), ����� ���� ���������� ����� ������������� ����������
#define VEHICLE_LIGHTS_OFF_TIME  7 // �����(�����), ����� ���� ���������� ����� ������������� �����������

// #define VEHICLE_DAMAGE_ENABLE_TIRES // �������� ������������ ��� � ������� ����������

// ��������� � ������
#define VEHICLE_FUEL_ENABLED     1
#define VEHICLE_FUEL_SPEED       2 // ���������� �������, ������������� �� 1 �������
#define VEHICLE_FUEL_FILL_TARIF  10 // ���� ������ ����� �������, � ��������
#define VEHICLE_FUEL_TARIF       20000

/*
 * Gang settings
 */

#define MAX_GANGS           MAX_PLAYERS // �������� ���� ������
#define MAX_GANG_SIZE       12 // ������������ ���-�� ����� � �����

#define MIN_GANG_NAME       3 // ����������� ����� ����� �����
#define MAX_GANG_NAME       40 // ������������ ����� ����� �����

#define MAX_GANG_MOTD       64 // ������������ ����� ���������� �����

#define GANG_CREATE_COST    500000 // ���-�� �����, ��������� �� �������� �����
#define GANG_COLOR_COST     20000 // ���-�� �����, ��������� �� ����� ����� �����

#define MAX_GANG_BANK       2000000000 // ������������ ���������� �����, ������� ����� ������� � ����� �����
#define GANG_XP_RATE        1000

#define MAX_GANG_INVITES     3 // ������������ ���������� �������� � ����� ������������
#define MAX_GANG_INVITE_TIME 60 // ������ �� �������� ������������� �������

/*
 * Mission settings
 */

// trucker
#define TRUCKER_ENABLED             1
#define TRUCKER_XP_RATE             100 // ����������� ����� �� �����
#define TRUCKER_MONEY_RATE          200
#define TRUCKER_TIME_GET_TRAILER    120 // ���-�� ������, �������� �� ����������� ���� � ������
#define TRUCKER_MISSION_TRY_COUNT   2 // ���-�� ���������� � ������������� ������ �� ��������
#define TRUCKER_MISSION_TIME        480 // ����� �������� �� ����������� ������
#define TRUCKER_PAUSE_MISSION_TIME  300 // ����� �������� ����� ��������, � ��������
#define TRUCKER_CAR_SPAWN_TIME      300
#define TRUCKER_BACK_CAR_TIME       60

// �������
#define SWAGUP_ENABLED      1 // �������� �� ������� ������
#define SWAGUP_MONEY_RATE   300 // ����������� ���������� ����� �� �������� �������
#define SWAGUP_XP_RATE      300 // ����������� ���������� ����� �� �������� �������
#define SWAGUP_PAUSE_TIME   480000


/*
 * CoordInfo
 */

enum CoordInfo {
	Float:Coord_X,
	Float:Coord_Y,
	Float:Coord_Z
}
