/*
    CHAT GUARD

    �����:  MX_Master
    ������: 0.1

    ��������:
        ��� ������������ ��� ������������ SA-MP, ������� ������ �� ��������
        � ������� ����. �� ����������� ������������ ��������� ��� �����
        �������.

        ������������ ��������� �� ������������ � ����� ����.
        ��������� ������� � ������������� �������, ����� �� ����� � ����� ����.

        �� ��������� ������ � ����� ����:
            - IP ������
            - ������ ��� ����� ������
            - ���������, ���������������� ������� ��������� ����
            - ������� ����� ������ ���� � ������ ��������� �����
            - ���������� ��� ������� ��������� ������
            - ������ ��������� ��� ��������� ������ � ����������� ���������
            - ���� ��� ������ �������� IP ����� / �����
            - ������� ������ ��������� (����)
*/
/*
	��������� ��� Open-GTO: ZiGGi, 05.05.2011
*/

static IsEnabled = CHAT_GUARD_ENABLED;

/*
chatguard_OnGameModeInit();
chatguard_OnPlayerConnect(playerid);
chatguard_OnPlayerDisconnect(playerid,reason);
chatguard_OnPlayerText(playerid,text);

*/

#define SPACE_CHARS ' ', '\t', '\r', '\n'

/*
    ������� �� ����� ����� ������ ��� ���������� �������.
-----------
    ������ �� ����������.
*/

stock trimSideSpaces ( string[] )
{
    new c, len = strlen(string);

    for ( ; c < len; c++ ) // ������� ������� � ������
    {
        switch ( string[c] )
        {
            case SPACE_CHARS : continue;
            default:
            {
                if ( c != 0 ) strmid( string, string, c, len, len );
                break;
            }
        }
    }

    for ( c = len - c - 1; c >= 0; c-- ) // ������� ������� � �����
    {
        switch ( string[c] )
        {
            case SPACE_CHARS : continue;
            default:
            {
                string[c + 1] = 0;
                break;
            }
        }
    }
}











#define cells *4

/*
    �������� ������ ���������� �������� �� ��������� �������
-----------
    ������ �� ����������
*/

stock spaceGroupsToSpaces ( string[] )
{
    new len = strlen(string), c = len - 1, spaces;

    for ( ; c >= 0; c-- )
    {
        switch ( string[c] )
        {
            case SPACE_CHARS : spaces++;
            default :
            {
                if ( spaces > 1 )
                {
                    memcpy( string, string[c + spaces + 1], (c + 2) cells, (len - c - spaces - 1) cells, len );
                    len -= spaces - 1;
                }

                if ( spaces > 0 )
                {
                    string[c + 1] = ' ';
                    spaces        =  0;
                }
            }
        }
    }

    if ( spaces > 1 )
    {
        memcpy( string, string[c + spaces + 1], (c + 2) cells, (len - c - spaces - 1) cells, len );
        len -= spaces - 1;
    }
    if ( spaces > 0 ) string[c + 1] = ' ';

    string[len] = 0;
}

#undef SPACE_CHARS











/*
    ������ 1, ���� ������ �������� ����� �������� IP �����,
    ��� ����� 3 ����� �����, ����������� ������ ������� ���������.
------------
    �����, ������ 0.
*/

stock containsAnyIP ( string[] )
{
    new digits, digitGroups;

    for ( new pos; ; pos++ )
    {
        switch ( string[pos] )
        {
            case 0 : break;
            case '0'..'9', 'o', 'O', '�', '�', '�', '�' : digits++;
            default :
            {
                if ( digits >= 2 )
                {
                    digitGroups++;
                    digits = 0;
                }
            }
        }
    }

    if ( digits >= 2 ) digitGroups++;
    if ( digitGroups >= 4 ) return 1;

    return 0;
}











// ������ ����������� ������� 1 ������
stock forbiddenDomain[][] =
{
    ".net", ".n�t",
    ".com", ".�om", ".��m", ".c�m",
    ".ru", ".��",
    ".kz", ".�z", ".k�", ".��",
    ".info", ".inf�"
};

/*
    ������ 1, ���� ������ �������� ����� ����� �� ������ ����.
------------
    �����, ������ 0.
*/

stock containsDomainName ( string[] )
{
    new strLen = strlen(string);

    for ( new d = sizeof(forbiddenDomain) - 1, foundPos, domainLen; d >= 0; d-- )
    {
        foundPos  = -1;
        domainLen = strlen(forbiddenDomain[d]);

        for ( ; ( foundPos = strfind( string, forbiddenDomain[d], true, foundPos + 1 ) ) >= 0;  )
        {
            if ( foundPos + domainLen >= strLen ) return 1;

            switch ( string[ foundPos + domainLen ] )
            {
                case 0..64, 91..96, 123..191 : return 1;
            }
        }
    }

    return 0;
}











// ������ ������ ��� ������� ������
stock forbiddenName [ MAX_PLAYERS char ];

/*
    ������ 1, ���� ��� ������ �������� �������� ��� ��� ����� �������� IP.
-------------
    ����� ������ 0.
*/

stock playerHasForbiddenName ( playerid )
{
    if ( forbiddenName{playerid} == 0 )
    {
        new name[MAX_PLAYER_NAME+1];
        GetPlayerName( playerid, name, MAX_PLAYER_NAME );

        if ( containsAnyIP(name) || containsDomainName(name) )
        {
            forbiddenName{playerid} = 1;
            return 1;
        }

        forbiddenName{playerid} = -1;
        return 0;
    }
    else
    {
        if ( forbiddenName{playerid} == 1 ) return 1;
        else return 0;
    }
}











/*
    ������ 1, ���� ������ �������� ��������� �������� ����� �����-�� ������� ����.
    ����� ������ ��� ����� ������ ������� �� � ��� ���������.
-------------
    ����� ������ 0.
*/

#define INCORRECT_CMD_CHARS '.', '?'

stock incorrectCmdAttempt ( string[] )
{
    switch ( string[0] )
    {
        case INCORRECT_CMD_CHARS :
        {
            switch ( string[1] )
            {
                case 65..90, 97..122, 192..255 : return 1;
            }
        }
    }

    return 0;
}

#undef INCORRECT_CMD_CHARS











#define CHAT_STR_SIZE           128 // ���� ���-�� �������� � ��������� ����
#define CHAT_HISTORY_SIZE       20 // ���-�� ����������� ��������� ����
#define DUBLPOSTS_SIMILARITY    60 // ���������� % ���������, ������ ������, ��������� ������
#define MAX_MESSAGES_PER_TIME   3 // �������� ��������� ��, ��������� ����, ������� �������
#define MAX_MESSAGES_TIME       3000 // ��. �� ��������� ����� ������ ���� �� ����� MAX_FAST_MESSAGES ��������� ������

enum chatMsInfo // ���� � ������ ��������� ����
{
    chTick,
    chPosterID,
    chText [ CHAT_STR_SIZE ]
}

// ������, ��� �������� ���� CHAT_HISTORY_SIZE ��������� ����
static stock ms [ CHAT_HISTORY_SIZE ] [ chatMsInfo ];

/*
    ������ source[] ����� ��������� �� ��������� ��������
    � ������� ������� delimiter. ������ ��������� ��� ������� (��������)
    substrIndex ����� �������� � ������ dest[]
--------------
    ������ �� ����������.
*/

stock sparam
(
    dest[],             maxSize     = sizeof(dest),
    const source[],     delimiter   = ' ',
    substrIndex = 0,    withRest    = 0
)
{
    dest[0] = 0; // ������� ������ ����������

    for ( new cur, pre, i = -1; ; cur++ ) // ���������� �� ������� ������� � ������ source
    {
        if ( source[cur] == 0 ) // ���� ������� ������ � source - ��� ������ ����� ������
        {
            if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
                // ��������� � dest ������ ��������� �� source
                strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize );

            goto sparam_end;
        }

        if ( source[cur] == delimiter ) // ���� ������� ������ � source - ��� ������ ��� ���������� ������
        {
            if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
            {
                // ��������� � dest ������ ��������� �� source
                strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize );
                goto sparam_end;
            }

            pre = cur + 1;
        }
    }

    sparam_end:
    return; // �������� ������ �������
}

/*
    ������ 1, ���� ���������� ��������� ������ ����� �� ��� �������,
    ��� ������� ��������� ������ �� ���������� �� DUBLPOSTS_SIMILARITY ���������.
------------
    ����� ������ 0.
*/

stock sameTextAsLastBefore ( playerid, text[] )
{
    // ������ ���������� ��������� ������ � ������� ����
    new m;

    for ( ; m < CHAT_HISTORY_SIZE; m++ )
        if ( ms[m][chPosterID] == playerid ) break;

    if ( m >= CHAT_HISTORY_SIZE ) return 0;


    // ������, ������� � ������ ��������
    new words = 1, w = strfind( text, " ", false, 0 );
    while ( w >= 0 )
    {
        words++;
        w = strfind( text, " ", false, w + 1 );
    }


    // ������, ���-�� ���������� �������� �� ���� ������ ����� �����
    new word[2][CHAT_STR_SIZE], sameChars, c;
    for ( w = 0; w < words; w++ )
    {
        sparam( word[0], CHAT_STR_SIZE, text,          ' ', w );
        sparam( word[1], CHAT_STR_SIZE, ms[m][chText], ' ', w );

        for ( c = 0; word[0][c] != 0; c++ )
            if ( toupper( word[0][c] ) == toupper( word[1][c] ) ) sameChars++;
    }

    if ( float(sameChars) / float( strlen(ms[m][chText]) ) * 100.0 > DUBLPOSTS_SIMILARITY.0 ) return 1;


    return 0;
}

/*
    ������� ������� ��������� ����
----------
    ������ �� ������.
*/

stock updateMsHistory ( playerid, msTick, text[] )
{
    // ����� ���� ������� �� 1 ���� ������
    for ( new i = 1; i < CHAT_HISTORY_SIZE; i++ )
        memcpy( ms[i], ms[i - 1], 0, sizeof(ms[]) cells );

    // ������� ����� � ������ � ������� ��������� ����
    ms[0][chTick]     = msTick;
    ms[0][chPosterID] = playerid;
    strmid( ms[0][chText], text, 0, strlen(text), CHAT_STR_SIZE );
}

/*
    ������ 1, ���� ����� ������� ������ �������� ��������� ������.
-------------
    ����� ������ 0.
*/

stock tooManyMessagesForShortTime ( playerid, lastMsTick )
{
    // ������ ����� ������ ��������� ������ � ������� ���� �� ��� ���� ������� ���������
    new m, messages;

    for ( ; m < CHAT_HISTORY_SIZE; m++ )
        if ( ms[m][chPosterID] == playerid && ++messages > MAX_MESSAGES_PER_TIME ) break;

    if ( m >= CHAT_HISTORY_SIZE ) m--;
    if ( messages > MAX_MESSAGES_PER_TIME && lastMsTick - ms[m][chTick] < MAX_MESSAGES_TIME ) return 1;

    return 0;
}

#undef cells
#undef CHAT_STR_SIZE
#undef DUBLPOSTS_SIMILARITY
#undef MAX_MESSAGES_PER_TIME
#undef MAX_MESSAGES_TIME











/*
    ������ 1, ���� � ������ ������� ����� ���� � ������� ��������.
-----------
    ����� ������ 0.
*/

#define MAX_UPPERCASES    40 // ���������� % ���� � ������� ��������

stock tooManyUpperChars ( string[] )
{
    new len = strlen(string), c = len - 1, upperChars;

    for ( ; c >= 0; c-- )
    {
        switch ( string[c] )
        {
            case 'A'..'Z', '�'..'�' : upperChars++;
        }
    }

    if ( float(upperChars) / float(len) * 100.0 > MAX_UPPERCASES.0 ) return 1;

    return 0;
}

#undef MAX_UPPERCASES















stock pt_chat_LoadConfig(file_config)
{
	ini_getInteger(file_config, "Protection_Chat_IsEnabled", IsEnabled);
}

stock pt_chat_SaveConfig(file_config)
{
	ini_setInteger(file_config, "Protection_Chat_IsEnabled", IsEnabled);
}


stock pt_chat_OnGameModeInit()
{
	if (!IsEnabled) {
        return;
    }

    for ( new i; i < CHAT_HISTORY_SIZE; i++ ) {
        ms[i][chPosterID] = -1;
    }

	Log_Game("SERVER: (protections)ChatGuard(by MX_Master) module init");
}

#undef CHAT_HISTORY_SIZE

stock pt_chat_OnPlayerConnect ( playerid )
{
	if (!IsEnabled) {
        return 0;
    }
    forbiddenName{playerid} = 0;
    return 1;
}

stock pt_chat_OnPlayerDisconnect ( playerid, reason )
{
	#pragma unused reason
	if (!IsEnabled) {
        return 0;
    }
    forbiddenName{playerid} = 0;
    return 1;
}






stock pt_chat_OnPlayerText ( playerid, text[] )
{
	if (!IsEnabled || IsPlayerHavePrivilege(playerid, PlayerPrivilegeAdmin)) {
        return 1;
    }
    new msgTick = GetTickCount();


    // �������� ���� ������ �� ���������� ������ IP/������
    if ( playerHasForbiddenName(playerid) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_NICK_WITH_IP_OR_DOMAIN) );
        return 0;
    }

    // ��������� ����, ������� �� ������� ����� ������� ���� - ������������ �� �����
    if ( incorrectCmdAttempt(text) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_COMMAND_DETECTED) );
        return 0;
    }



    // ������ ����� ����� ���������� �������� �� ��������� �������
    spaceGroupsToSpaces(text);

    // ������� ���������� �������� �� �����
    trimSideSpaces(text);

    // ������ ��������� ������������ �� �����
    if ( text[0] == 0 ) return 0;

    // ������ ������ ����������, ���������� ����� ���� � ������� ��������
    if ( tooManyUpperChars(text) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_CAPSLOCK_ON) );
        return 0;
    }

    // ������ ������ ���������, ���������� IP ������
    if ( containsAnyIP(text) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_IP_IS_FORBIDDEN) );
        return 0;
    }

    // ������ ������ ���������, ���������� ����������� �������� �����
    if ( containsDomainName(text) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_DOMAIN_IS_FORBIDDEN) );
        return 0;
    }



    // ������ ������ �������� ���� ��������� ������
    if ( tooManyMessagesForShortTime( playerid, msgTick ) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_STOP_FLOOD) );
        return 0;
    }

    // ������ ������ ������� ��������� ������
    if ( sameTextAsLastBefore( playerid, text ) )
    {
        SendClientMessage( playerid, WARN_MS_COLOR, _(PROTECTION_CHAT_SIMILAR_MESSAGE) );
        return 0;
    }

    // ���������� ������� ��������� ����
    updateMsHistory( playerid, msgTick, text );



    // ������� ��������� � ����
    return 1;
}

#undef WARN_MS_COLOR
