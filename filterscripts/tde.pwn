#include <a_samp>
#include <sscanf2>
#include <tde_tdinfo> //(0.3.7 support!)


/*

	___ __  __
	 | |  \|_  _|.|_ _  _
	 | |__/|__(_|||_(_)|

	Version 1.17   
	TDEditor Credits:

	    - adri1                                                                                         USER PROFILE: http://forum.sa-mp.com/member.php?u=106967
	    - Pottus   (1.14 update)                                                                        USER PROFILE: http://forum.sa-mp.com/member.php?u=169807
	    - iPLEOMAX   																					USER PROFILE: http://forum.sa-mp.com/member.php?u=122705
	    - Sasino97 (IsKeyDown plugin)                                                                   USER PROFILE: http://forum.sa-mp.com/member.php?u=111937
		- Y_Less   (sscanf2 plugin)        				                                                USER PROFILE: http://forum.sa-mp.com/member.php?u=29176



	IsKeyDown plugin was modified by adri1, adding the following functions:

		native PressKeyEnter(key);
		native PressAnyKey(key);
		native GetKeyState(key);
		native GetDoubleClickTime();
		native ActivateAnyKey();
		native ActivateAnyKeyVariable(valor);
		forward OnAnyKeyDown(key);
*/


#define VK_KEY_A	0x41
#define VK_KEY_B	0x42
#define VK_KEY_C	0x43
#define VK_KEY_D	0x44
#define VK_KEY_E	0x45
#define VK_KEY_F	0x46
#define VK_KEY_G	0x47
#define VK_KEY_H	0x48
#define VK_KEY_I	0x49
#define VK_KEY_J	0x4A
#define VK_KEY_K	0x4B
#define VK_KEY_L	0x4C
#define VK_KEY_M	0x4D
#define VK_KEY_N	0x4E
#define VK_KEY_O	0x4F
#define VK_KEY_P	0x50
#define VK_KEY_Q	0x51
#define VK_KEY_R	0x52
#define VK_KEY_S	0x53
#define VK_KEY_T	0x54
#define VK_KEY_U	0x55
#define VK_KEY_V	0x56
#define VK_KEY_W	0x57
#define VK_KEY_X	0x58
#define VK_KEY_Y	0x59
#define VK_KEY_Z	0x5A
#define VK_LBUTTON	0x01
#define VK_MBUTTON	0x04
#define VK_RBUTTON	0x02
#define VK_UP		0x26
#define VK_DOWN		0x28
#define VK_LEFT		0x25
#define VK_RIGHT	0x27
#define VK_LSHIFT	0xA0
#define VK_RSHIFT	0xA1
#define VK_SPACE    0x20
#define VK_CANCEL 0x03
#define VK_BACKSPACE 0x08
#define VK_TAB 0x09
#define VK_CLEAR 0x0C
#define VK_ENTER 0x0D
#define VK_SHIFT 0x10
#define VK_LSHIFT 0xA0
#define VK_RSHIFT 0xA1
#define VK_CTRL 0x11
#define VK_LCTRL 0xA2
#define VK_RCTRL 0xA3
#define VK_ALT 0x12
#define VK_CAPSLOCK 0x14
#define VK_ESCAPE 0x1B
#define VK_SELECT 0x29
#define VK_INSERT 0x2D
#define VK_DELETE 0x2E
#define VK_HELP 0x2F
#define VK_KEYB0 0x30
#define VK_KEYB1 0x31
#define VK_KEYB2 0x32
#define VK_KEYB3 0x33
#define VK_KEYB4 0x34
#define VK_KEYB5 0x35
#define VK_KEYB6 0x36
#define VK_KEYB7 0x37
#define VK_KEYB8 0x38
#define VK_KEYB9 0x39
#define VK_NUMLOCK 0x90
#define VK_NUMPAD0 0x60
#define VK_NUMPAD1 0x61
#define VK_NUMPAD2 0x62
#define VK_NUMPAD3 0x63
#define VK_NUMPAD4 0x64
#define VK_NUMPAD5 0x65
#define VK_NUMPAD6 0x66
#define VK_NUMPAD7 0x67
#define VK_NUMPAD8 0x68
#define VK_NUMPAD9 0x69
#define VK_MULTIPLY 0x6A
#define VK_ADD 0x6B
#define VK_SEPARATOR 0x6C
#define VK_SUBTRACT 0x6D
#define VK_DECIMAL 0x6E
#define VK_DIVIDE 0x6F
#define VK_OEM_PLUS 0xBB
#define VK_OEM_COMMA 0xBC
#define VK_OEM_MINUS 0xBD
#define VK_OEM_PERIOD 0xBE
#define VK_OEM_2 0xBF
#define VK_OEM_4 0xDB
#define VK_OEM_5 0xDC
#define VK_OEM_6 0xDD
#define VK_XBUTTON1 0x05
#define VK_XBUTTON2 0x06
#define VK_OEM_102 0xE2
#define VK_F6 0x75
#define VK_END 0x23
#define VK_HOME 0x24

#define EmptyString(%0)         %0[0] = '\0'
#define INVALID_INDEX_ID        (-1)
#define TDE_CALLBACK:%0(%1) forward %0(%1); public %0(%1)
#define Loop(%0,%1)       for (new c = %0; c < %1; c++)
#define MAX_PROJECT_TEXTDRAWS   (500)

native GetVirtualKeyState(key);
native GetScreenSize(&Width, &Height);
native GetMousePos(&X, &Y);
native PressKeyEnter(key);
native PressAnyKey(key);
native GetKeyState(key);
native GetDoubleClickTime();
native ActivateAnyKey();
native ActivateAnyKeyVariable(valor);
forward OnAnyKeyDown(key);


enum
{
    DIALOG_PROJECT = 6666,
    DIALOG_PROJECT_LIST,
    DIALOG_NEWPROJECT,
	DIALOG_LOADPROJECT,
	DIALOG_CLOSEPROJECT,
	DIALOG_DELETETD,
	DIALOG_TDLIST,
	DIALOG_EDITTEXT,
	DIALOG_EDITOUTLINE,
	DIALOG_EDITSHADOW,
	DIALOG_LETTERX,
	DIALOG_LETTERY,
	DIALOG_POSX,
	DIALOG_POSY,
	DIALOG_MIRROR,
	DIALOG_CONFIRMEDELETE,
	DIALOG_EDITCOLOR,
	DIALOG_SIZEX,
	DIALOG_SIZEY,
	DIALOG_NEW,
	DIALOG_MODELID,
	DIALOG_MODELS,
	DIALOG_MODELS_MLD,
	DIALOG_MODELS_RX,
	DIALOG_MODELS_RY,
	DIALOG_MODELS_RZ,
	DIALOG_MODELS_ZO,
	DIALOG_MODELS_C1,
	DIALOG_MODELS_C2,
	DIALOG_MANAGE = 7777,
	DIALOG_SELECTTDS = 8888
};

enum E_KEY_STRUCT
{
	bool:KEY_PRESSED,
	KEY_CODE,
};

enum E_TD_STRUCT
{
	ItsFromTDE,
	Text:ETextDrawID,
	ETextDrawText[800],
	Float:ETextDrawPosX,
	Float:ETextDrawPosY,
	Float:ETextDrawLetterX,
	Float:ETextDrawLetterY,
	Float:ETextDrawTextX,
	Float:ETextDrawTextY,
	ETextDrawOutline,
	ETextDrawShadow,
	ETextDrawModelid,
	Float:ETextDrawRotX,
	Float:ETextDrawRotY,
	Float:ETextDrawRotZ,
	Float:ETextDrawZoom,
	ETextDrawType, //Global/Player
	ETextDrawSelectable,
	ETextDrawColor,
	ETextDrawBGColor,
	ETextDrawBoxColor,
	ETextDrawVehCol1,
	ETextDrawVehCol2
};

enum
{
	EDITMODE_NONE,
	EDITMODE_TEXT,
	EDITMODE_POSITION,
	EDITMODE_OUTLINE,
	EDITMODE_SHADOW,
	EDITMODE_LETTERSIZE,
	EDITMODE_SIZE,
	EDITMODE_COLOR,
	EDITMODE_BGCOLOR,
	EDITMODE_BOXCOLOR,
 	EDITMODE_MODELS,
	EDITMODE_ADJUST
};

enum
{
	COLORMODE_NONE,
	COLORMODE_RED,
	COLORMODE_GREEN,
	COLORMODE_BLUE,
	COLORMODE_ALPHA
};

new PremadeColors[][] =
{
	{ 0xFF0000FF , "Red" },
	{ 0xFFFFFFFF , "White" },
	{ 0x00FFFFFF , "Cyan" },
	{ 0xC0C0C0FF , "Silver" },
	{ 0x0000FFFF , "Blue" },
	{ 0x808080FF , "Grey" },
	{ 0x0000A0FF , "DarkBlue" },
	{ 0x000000FF , "Black" },
	{ 0xADD8E6FF , "LightBlue" },
	{ 0xFFA500FF , "Orange" },
	{ 0x800080FF , "Purple" },
	{ 0xA52A2AFF , "Brown" },
	{ 0xFFFF00FF , "Yellow" },
	{ 0x800000FF , "Maroon" },
	{ 0x00FF00FF , "Lime" },
	{ 0x008000FF , "Green" },
	{ 0xFF00FFFF , "Fuchsia" },
	{ 0x808000FF , "Olive" }
};

new
	ProjectEditor = -1,
    bool:EditorEnabled,
	bool:IsPSel,
	CursorOX, CursorOY,
	CursorX, CursorY,
	ScreenWidth, ScreenHeight,
	VirtualKeys[95][E_KEY_STRUCT],
	ProjectTD[MAX_PROJECT_TEXTDRAWS][E_TD_STRUCT],
	Text:TDE_Menu[36] = {Text:INVALID_TEXT_DRAW, ...},
	Text:TD_Status,
	Text:TDELOGO,
	Float:OffsetZ = 415.0,
	EditIndex = INVALID_INDEX_ID,
	EditMode,
	Float:EditMoveSpeed = 0.1,
	Float:EditLetterSizeSpeed = 0.01,
	Float:EditSizeSpeed = 0.01,
	DeleteTimer, SpeedTimer, /*DoubleClickCount,*/ MoveTDTimer = -1,
	Text:TDEditor_Helper[2], TDEHTimer = -1, OutlineTimer, ShadowTimer,
	LetterSizeTimer = -1, LetterTimer, EditSizeTDTimer = -1, EditSizeSpeedT,
	ColorMode, Colors[4], BackManageDialog[15], PageStart, Float:Zoom = 1.0,
	ProjectFile[64], Pro_Str[5000], File:Handler, str_list[3000], EditorUpdateTimer,
    line[800], bool:MouseCursor, bool:PixelLock, SpeedSTR[256], bool:SelectedTextDraws[MAX_PROJECT_TEXTDRAWS], bool:moveselectedtds, bool:selectall
;

public OnFilterScriptInit()
{
    print(" ");
    print(" ");
    print(" ");
	print(" ");
	print("___ __  __");
	print(" | |  \\|_  _|.|_ _  _		");
	print(" | |__/|__(_|||_(_)|			");
    print(" ");
    print("TDEditor V1.17 by adri1");
    print("TDEditor loaded");
    print(" ");

	Loop(0, MAX_PROJECT_TEXTDRAWS) ProjectTD[c][ItsFromTDE] = -1;
	VirtualKeys[0][KEY_CODE] = VK_KEY_A;
    VirtualKeys[1][KEY_CODE] = VK_KEY_B;
    VirtualKeys[2][KEY_CODE] = VK_KEY_C;
    VirtualKeys[3][KEY_CODE] = VK_KEY_D;
    VirtualKeys[4][KEY_CODE] = VK_KEY_E;
    VirtualKeys[5][KEY_CODE] = VK_KEY_F;
    VirtualKeys[6][KEY_CODE] = VK_KEY_G;
    VirtualKeys[7][KEY_CODE] = VK_KEY_H;
    VirtualKeys[8][KEY_CODE] = VK_KEY_I;
    VirtualKeys[9][KEY_CODE] = VK_KEY_J;
    VirtualKeys[10][KEY_CODE] = VK_KEY_K;
    VirtualKeys[11][KEY_CODE] = VK_KEY_L;
    VirtualKeys[12][KEY_CODE] = VK_KEY_M;
    VirtualKeys[13][KEY_CODE] = VK_KEY_N;
    VirtualKeys[14][KEY_CODE] = VK_KEY_O;
    VirtualKeys[15][KEY_CODE] = VK_KEY_P;
    VirtualKeys[16][KEY_CODE] = VK_KEY_Q;
    VirtualKeys[17][KEY_CODE] = VK_KEY_R;
    VirtualKeys[18][KEY_CODE] = VK_KEY_S;
    VirtualKeys[19][KEY_CODE] = VK_KEY_T;
    VirtualKeys[20][KEY_CODE] = VK_KEY_U;
    VirtualKeys[21][KEY_CODE] = VK_KEY_V;
    VirtualKeys[22][KEY_CODE] = VK_KEY_W;
    VirtualKeys[23][KEY_CODE] = VK_KEY_X;
    VirtualKeys[24][KEY_CODE] = VK_KEY_Y;
    VirtualKeys[25][KEY_CODE] = VK_KEY_Z;
    VirtualKeys[26][KEY_CODE] = VK_LBUTTON;
    VirtualKeys[27][KEY_CODE] = VK_MBUTTON;
    VirtualKeys[28][KEY_CODE] = VK_RBUTTON;
    VirtualKeys[29][KEY_CODE] = VK_LEFT;
    VirtualKeys[30][KEY_CODE] = VK_RIGHT;
	VirtualKeys[31][KEY_CODE] = VK_UP;
    VirtualKeys[32][KEY_CODE] = VK_DOWN;
    VirtualKeys[33][KEY_CODE] = VK_LSHIFT;
    VirtualKeys[34][KEY_CODE] = VK_RSHIFT;
    VirtualKeys[35][KEY_CODE] = VK_SPACE;
    VirtualKeys[36][KEY_CODE] = VK_CANCEL; //03
	VirtualKeys[37][KEY_CODE] = VK_BACKSPACE; //08
	VirtualKeys[38][KEY_CODE] = VK_TAB; //09
	VirtualKeys[39][KEY_CODE] = VK_CLEAR; //0C
	VirtualKeys[40][KEY_CODE] = VK_ENTER; //0D
	VirtualKeys[41][KEY_CODE] = VK_SHIFT; //10
	VirtualKeys[42][KEY_CODE] = VK_LSHIFT; //A0
	VirtualKeys[43][KEY_CODE] = VK_RSHIFT; //A1
	VirtualKeys[44][KEY_CODE] = VK_CTRL; //11
	VirtualKeys[45][KEY_CODE] = VK_LCTRL; //A2
	VirtualKeys[46][KEY_CODE] = VK_RCTRL; //A3
	VirtualKeys[47][KEY_CODE] = VK_ALT; //12
	VirtualKeys[48][KEY_CODE] = VK_CAPSLOCK; //14
	VirtualKeys[49][KEY_CODE] = VK_ESCAPE; //1B
	VirtualKeys[50][KEY_CODE] = VK_SELECT; //29
	VirtualKeys[51][KEY_CODE] = VK_INSERT; //2D
	VirtualKeys[52][KEY_CODE] = VK_DELETE; //2E
	VirtualKeys[53][KEY_CODE] = VK_HELP; //2F
	VirtualKeys[54][KEY_CODE] = VK_KEYB0; //30
	VirtualKeys[55][KEY_CODE] = VK_KEYB1; //31
	VirtualKeys[56][KEY_CODE] = VK_KEYB2; //32
	VirtualKeys[57][KEY_CODE] = VK_KEYB3; //33
	VirtualKeys[58][KEY_CODE] = VK_KEYB4; //34
	VirtualKeys[59][KEY_CODE] = VK_KEYB5; //35
	VirtualKeys[60][KEY_CODE] = VK_KEYB6; //36
	VirtualKeys[61][KEY_CODE] = VK_KEYB7; //37
	VirtualKeys[62][KEY_CODE] = VK_KEYB8; //38
	VirtualKeys[63][KEY_CODE] = VK_KEYB9; //39
	VirtualKeys[64][KEY_CODE] = VK_NUMLOCK; //90
	VirtualKeys[65][KEY_CODE] = VK_NUMPAD0; //60
	VirtualKeys[66][KEY_CODE] = VK_NUMPAD1; //61
	VirtualKeys[67][KEY_CODE] = VK_NUMPAD2; //62
	VirtualKeys[68][KEY_CODE] = VK_NUMPAD3; //63
	VirtualKeys[69][KEY_CODE] = VK_NUMPAD4; //64
	VirtualKeys[70][KEY_CODE] = VK_NUMPAD5; //65
	VirtualKeys[71][KEY_CODE] = VK_NUMPAD6; //66
	VirtualKeys[72][KEY_CODE] = VK_NUMPAD7; //67
	VirtualKeys[73][KEY_CODE] = VK_NUMPAD8; //68
	VirtualKeys[74][KEY_CODE] = VK_NUMPAD9; //69
	VirtualKeys[75][KEY_CODE] = VK_MULTIPLY; //6A
	VirtualKeys[76][KEY_CODE] = VK_ADD; //6B
	VirtualKeys[77][KEY_CODE] = VK_SEPARATOR; //6C
	VirtualKeys[78][KEY_CODE] = VK_SUBTRACT; //6D
	VirtualKeys[79][KEY_CODE] = VK_DECIMAL; //6E
	VirtualKeys[80][KEY_CODE] = VK_DIVIDE; //6F
	VirtualKeys[81][KEY_CODE] = VK_OEM_PLUS;
	VirtualKeys[82][KEY_CODE] = VK_OEM_COMMA;
	VirtualKeys[83][KEY_CODE] = VK_OEM_MINUS;
	VirtualKeys[84][KEY_CODE] = VK_OEM_PERIOD;
	VirtualKeys[85][KEY_CODE] = VK_OEM_2;
	VirtualKeys[86][KEY_CODE] = VK_OEM_4;
	VirtualKeys[87][KEY_CODE] = VK_OEM_5;
	VirtualKeys[88][KEY_CODE] = VK_OEM_6;
	VirtualKeys[89][KEY_CODE] = VK_XBUTTON1;
	VirtualKeys[90][KEY_CODE] = VK_XBUTTON2;
	VirtualKeys[91][KEY_CODE] = VK_OEM_102;
	VirtualKeys[92][KEY_CODE] = VK_F6;
	VirtualKeys[93][KEY_CODE] = VK_END;
    VirtualKeys[94][KEY_CODE] = VK_HOME;


    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) ProjectTD[i][ETextDrawID] = Text:INVALID_TEXT_DRAW;
	return true;
}

public OnFilterScriptExit()
{
    print(" ");
    print(" ");
    print(" ");
	print(" ");
	print("___ __  __");
	print(" | |  \\|_  _|.|_ _  _		");
	print(" | |__/|__(_|||_(_)|			");
    print(" ");
    print("TDEditor V1.17 by adri1");
    print("TDEditor unloaded");
    print(" ");

    KillTimer(EditorUpdateTimer);
    KillTimer(DeleteTimer);
    KillTimer(SpeedTimer);
    KillTimer(MoveTDTimer); MoveTDTimer = -1;
    KillTimer(TDEHTimer); TDEHTimer = -1;
    KillTimer(OutlineTimer);
    KillTimer(ShadowTimer);
    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
	KillTimer(LetterTimer);
	KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
	KillTimer(EditSizeSpeedT);
	KillTimer(ShadowTimer);
	if(ProjectEditor != -1)
	{
	    TogglePlayerControllable(ProjectEditor, true);
	    ShowPlayerDialog(ProjectEditor, -1, 0, "","", "", "" );
	    CancelSelectTextDraw(ProjectEditor);
		if(strlen(ProjectFile))
		{
		    SaveProject();
		    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
		}
	}
	
	Loop(0, MAX_PROJECT_TEXTDRAWS) SelectedTextDraws[c] = false;
	moveselectedtds = false;
	selectall = false;
	
	DestroyMenuTextDraws();
    EditMode = EDITMODE_NONE;
	ColorMode = COLORMODE_NONE;
	ProjectEditor = -1;
	EditorEnabled = false;
	IsPSel = true;
	CursorOX = 0;
	CursorOY = 0;
	CursorX = 0;
	CursorY = 0;
	ScreenWidth = 0;
	ScreenHeight = 0;
	OffsetZ = 415.0;
	EditIndex = INVALID_INDEX_ID;
	EditMoveSpeed = 0.1;
	EditLetterSizeSpeed = 0.01;
	EditSizeSpeed = 0.01;
	PageStart = 0;
	Zoom = 1.0;
	MouseCursor = false;
	EmptyString(ProjectFile);
	EmptyString(Pro_Str);
	EmptyString(str_list);
	EmptyString(line);
	return true;
}

public OnPlayerConnect(playerid)
{
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(ProjectEditor == playerid)
	{
		KillTimer(EditorUpdateTimer);
	    KillTimer(DeleteTimer);
	    KillTimer(SpeedTimer);
	    KillTimer(MoveTDTimer); MoveTDTimer = -1;
	    KillTimer(TDEHTimer); TDEHTimer = -1;
	    KillTimer(OutlineTimer);
	    KillTimer(ShadowTimer);
	    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
		KillTimer(LetterTimer);
		KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
		KillTimer(EditSizeSpeedT);
		KillTimer(ShadowTimer);

		if(strlen(ProjectFile))
		{
		    SaveProject();
		    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
        }

		Loop(0, MAX_PROJECT_TEXTDRAWS) SelectedTextDraws[c] = false;
		moveselectedtds = false;
		selectall = false;
		
		DestroyMenuTextDraws();
	    EditMode = EDITMODE_NONE;
		ColorMode = COLORMODE_NONE;
		ProjectEditor = -1;
		EditorEnabled = false;
		IsPSel = true;
		CursorOX = 0;
		CursorOY = 0;
		CursorX = 0;
		CursorY = 0;
		ScreenWidth = 0;
		ScreenHeight = 0;
		OffsetZ = 415.0;
		EditIndex = INVALID_INDEX_ID;
		MouseCursor = false;
		EditMoveSpeed = 0.1;
		EditLetterSizeSpeed = 0.01;
		EditSizeSpeed = 0.01;
		PageStart = 0;
		Zoom = 1.0;
		EmptyString(ProjectFile);
		EmptyString(Pro_Str);
		EmptyString(str_list);
		EmptyString(line);
	}
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/tde", true, 4))
	{
	    if(ProjectEditor == playerid)
	    {
	        if(strlen(cmdtext) >= 6)
			{
			    if( (!strcmp(cmdtext[5], "ayuda", true)) || (!strcmp(cmdtext[5], "help", true))  )
				{
				    SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}/tde box - /tde exit - /tde cursor - /tde select.");
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "cursor", true)) )
				{
    				if(MouseCursor)
					{
						MouseCursor = false;
						CancelSelectTextDraw(ProjectEditor);
					}
			        else
					{
						MouseCursor = true;
						SelectTextDraw(ProjectEditor, -1);
					}
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "select", true)) )
				{
					SendClientMessage(playerid, -1, " ");
					SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Use /tde selectall to un/select all textdraws.");
					SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Use /tde edit  to edit selected textdraws.");
					CancelSelectTextDraw(playerid);
					IsPSel = false;
    				ShowSelectTDManage(playerid);
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "selectall", true)) )
				{

					if(selectall)
					{
						selectall = false;
						Loop(0, MAX_PROJECT_TEXTDRAWS) SelectedTextDraws[c] = false;
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}All textdraws unselected.");
					}
					else
					{
						selectall = true;
						Loop(0, MAX_PROJECT_TEXTDRAWS) SelectedTextDraws[c] = true;
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}All textdraws selected.");
    				}
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "edit", true)) )
				{
					if(moveselectedtds)
					{
						moveselectedtds = false;
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Edit selected textdraws: OFF.");
					}
					else 
					{
						moveselectedtds = true;
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Edit selected textdraws: ON.");
					}
					return 1;
				}
			    if( (!strcmp(cmdtext[5], "salir", true)) || (!strcmp(cmdtext[5], "exit", true))  )
				{
  					KillTimer(EditorUpdateTimer);
				    KillTimer(DeleteTimer);
				    KillTimer(SpeedTimer);
				    KillTimer(MoveTDTimer); MoveTDTimer = -1;
				    KillTimer(TDEHTimer); TDEHTimer = -1;
				    KillTimer(OutlineTimer);
				    KillTimer(ShadowTimer);
				    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
					KillTimer(LetterTimer);
					KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
					KillTimer(EditSizeSpeedT);
					KillTimer(ShadowTimer);

					if(strlen(ProjectFile))
					{
					    SaveProject();
					    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
			        }
					
					Loop(0, MAX_PROJECT_TEXTDRAWS) SelectedTextDraws[c] = false;
					moveselectedtds = false;
					selectall = false;

					DestroyMenuTextDraws();
				    EditMode = EDITMODE_NONE;
					ColorMode = COLORMODE_NONE;
					ProjectEditor = -1;
					EditorEnabled = false;
					IsPSel = true;
					CursorOX = 0;
					CursorOY = 0;
					CursorX = 0;
					CursorY = 0;
					ScreenWidth = 0;
					ScreenHeight = 0;
					OffsetZ = 415.0;
					EditIndex = INVALID_INDEX_ID;
					EditMoveSpeed = 0.1;
					EditLetterSizeSpeed = 0.01;
					EditSizeSpeed = 0.01;
					PageStart = 0;
					MouseCursor = false;
					Zoom = 1.0;
					EmptyString(ProjectFile);
					EmptyString(Pro_Str);
					EmptyString(str_list);
					EmptyString(line);

					TogglePlayerControllable(playerid, true);
				    ShowPlayerDialog(playerid, -1, 0, "","", "", "" );
				    CancelSelectTextDraw(playerid);
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "box", true)) || (!strcmp(cmdtext[5], "icons", true)) || (!strcmp(cmdtext[5], "adjust", true)) )
				{
				    if(EditMode == EDITMODE_ADJUST)
				    {
				        if(!VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
						{
					        new Float:pos[2];
				        	for(new i = 1; i < sizeof(TDE_Menu); i++)
				        	{
				        	    TDE_TextDrawGetPos(TDE_Menu[i], pos[0], pos[1]);
				        	    TDE_TextDrawSetPos(TDE_Menu[i], pos[0], OffsetZ);
				        	    TDE_TextDrawShowForPlayer(playerid, TDE_Menu[i]);
				        	}

				 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
				 		    EditMode = EDITMODE_NONE;
				 		    IsPSel = true;
					        return 1;
						}
						return 1;
				    }
				    IsPSel = false;
					TDE_TextDrawSetString(TD_Status, "EDITMODE_ADJUST");
    				EditMode = EDITMODE_ADJUST;
    				SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Press 'ESC' to finish this mode.");
					return 1;
				}
				return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}/tde {e2b960}(box/help)");
			}
			TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
   			EditMode = EDITMODE_NONE;
			CancelSelectTextDraw(playerid);
			IsPSel = false;
			ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
	    }
	    if(ProjectEditor == -1)
	    {
	        new ip[16];
	        GetPlayerIp(playerid, ip, 16);
	        if(strcmp(ip, "127.0.0.1", false)) return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor only can be used from localhost (127.0.0.1)");
	        IsPSel = true;
	        MouseCursor = true;
	        TogglePlayerControllable(playerid, false);
	        DestroyMenuTextDraws();
  			CreateMenuTextDraws();
	        SendClientMessage(playerid, -1, "{e2b960}TDEditor 1.17 {FFFFFF}Click on the image to start...");
	        TDE_TextDrawShowForPlayer(playerid, TDELOGO);
	        SelectTextDraw(playerid, -1);
            EmptyString(ProjectFile);
	    }
	    return true;
	}
	return false;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PROJECT)
	{
		if(response)
		{
		    switch(listitem)
		    {
		        case 0:
				{
				    if(strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Closes the current project first.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
					ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
				}
		        case 1:
		        {
		            if(strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Closes the current project first.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
          			new Found;
				    Handler = fopen("tdelist.txt", io_read);
				    if(Handler)
				    {
					    while(fread(Handler, Pro_Str))
					    {
							if(strlen(Pro_Str))
							{
							    if(!Found)
								{
									EmptyString(str_list);
									Found = true;
								}
								strcat(str_list, Pro_Str);
							}
						}
					    fclose(Handler);
				    }
				    else
				    {
				        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}There isn't list.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
				        return 1;
				    }
				    if(!Found)
				    {
				        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}There isn't list.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
				        return 1;
				    }
				    ShowPlayerDialog(playerid, DIALOG_PROJECT_LIST, DIALOG_STYLE_LIST, "TDEditor - Projects list", str_list, ">>", "<<");
		        }
		        case 2:
		        {
		            if(!strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}You haven't created/loaded any project.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
		            CloseProject();
		            SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project closed.");
		            ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
		        }
		    }
		}
		else
		{
		    if(ProjectEditor == -1)
		    {

			    SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor finished.");
			    TDE_TextDrawHideForPlayer(playerid, TDELOGO);
			    TogglePlayerControllable(playerid, true);
		        DestroyMenuTextDraws();
		        IsPSel = true;
		        return 1;
			}
			SelectTextDraw(playerid, -1);
			IsPSel = true;
			SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}If you want exit use /tde exit.");
		}
	    return 1;
	}
	else if(dialogid == DIALOG_NEWPROJECT)
	{
	    if(response)
	    {
	        if(!(1 <= strlen(inputtext) <= 32)) return ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
			if(!IsValidProjectName(inputtext)) return ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
			if(strlen(ProjectFile)) CloseProject();

			format(ProjectFile, sizeof ProjectFile, "%s.tde", inputtext);
			if(!CheckProject(inputtext)) AddProject(ProjectFile);

			ProjectEditor = playerid;
	        EditorEnabled = true;
	        IsPSel = true;
	        ShowEditor();

	        PageStart = 0;
			if(fexist(ProjectFile))
			{
				LoadProject();
				SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project loaded.");
			}
			else
			{
			    Handler = fopen(ProjectFile, io_write);
			    fclose(Handler);
			    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project created.");
			}

			if(EditIndex != INVALID_INDEX_ID)
 	    	{
     	    	Loop(1, sizeof(TDE_Menu))
			    {
					TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
					TDE_TextDrawSetSelectable(TDE_Menu[c], true);
			        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
			    }
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
			    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
			    UpdateIcons(EditIndex);
			}

			EditorUpdateTimer = SetTimerEx("OnEditorUpdate", 25, true, "i", ProjectEditor);
	    }
	    else ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
	    return 1;
	}
	else if(dialogid == DIALOG_PROJECT_LIST)
	{
	    if(response)
        {
            Handler = fopen("tdelist.txt", io_read);
         	if(!Handler) return 1;

         	new Index = -1;
         	while(fread(Handler, Pro_Str))
         	{
         	    if(!strlen(Pro_Str)) continue;
         	    Index++;

         	    if(Index == listitem)
         	    {
         	    	StripNewLine(Pro_Str);

         	    	if(strlen(ProjectFile))
         	    	{
             	    	SaveProject();
             	    	CloseProject();
         	    	}
         	    	ProjectEditor = playerid;
			        EditorEnabled = true;
			        IsPSel = true;
			        ShowEditor();

         	    	format(ProjectFile, sizeof(ProjectFile), "%s", Pro_Str);
         	    	if(!LoadProject())
					{
					    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldn't load this project, check .tde file.");
                        ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
                        return 1;
					}
         	    	if(EditIndex >= INVALID_INDEX_ID)
         	    	{
	         	    	Loop(1, sizeof(TDE_Menu))
					    {
							TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
							TDE_TextDrawSetSelectable(TDE_Menu[c], true);
					        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
					    }
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
					    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
					    UpdateIcons(EditIndex);
					}

					EditorUpdateTimer = SetTimerEx("OnEditorUpdate", 25, true, "i", ProjectEditor);
         	    }
         	}
        }
        else ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
        return 1;
	}
    if(!EditorEnabled || ProjectEditor != playerid) return false;
    if(EditMode == EDITMODE_ADJUST) return false;
	switch(dialogid)
	{
	    case DIALOG_NEW:
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0: //Normal
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TDE_TextDrawSetSelectable(TDE_Menu[c], true);
						        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

						TDE_TextDrawCreate(ProjectTD[Index][ETextDrawID], 290.0, 190.0, "TDEditor");
						TDE_TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.4, 1.6);
						TDE_TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TDE_TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
						TDE_TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "TDEditor");
						ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.4;
						ProjectTD[EditIndex][ETextDrawLetterY] = 1.6;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);

				        if(EditMode == EDITMODE_MODELS)
				        {
				            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	                case 1: //TXD
	                {
						new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TDE_TextDrawSetSelectable(TDE_Menu[c], true);
						        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

				      	TDE_TextDrawCreate(ProjectTD[Index][ETextDrawID], 265.0, 155.0, "LD_SPAC:white");
						TDE_TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 0.0);
						TDE_TextDrawTextSize(ProjectTD[Index][ETextDrawID], 90.0, 90.0);
						TDE_TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TDE_TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawFont(ProjectTD[Index][ETextDrawID], 4);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "LD_SPAC:white");
						ProjectTD[EditIndex][ETextDrawPosX] = 265.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 155.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 90.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 90.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);

				        if(EditMode == EDITMODE_MODELS)
				        {
				            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	                case 2: //Previews
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TDE_TextDrawSetSelectable(TDE_Menu[c], true);
						        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

				      	TDE_TextDrawCreate(ProjectTD[Index][ETextDrawID], 265.0, 155.0, "");
						TDE_TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 0.0);
						TDE_TextDrawTextSize(ProjectTD[Index][ETextDrawID], 90.0, 90.0);
						TDE_TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TDE_TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawFont(ProjectTD[Index][ETextDrawID], 5);
						TDE_TextDrawSetPreviewModel(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetPreviewRot(ProjectTD[Index][ETextDrawID], 0.0, 0.0, 0.0, 1.0);
						TDE_TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 0x000000FF);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "");
						ProjectTD[EditIndex][ETextDrawPosX] = 265.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 155.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 90.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 90.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawModelid] = 0;
						ProjectTD[EditIndex][ETextDrawRotX] = 0.0;
						ProjectTD[EditIndex][ETextDrawRotY] = 0.0;
						ProjectTD[EditIndex][ETextDrawRotZ] = 0.0;
						ProjectTD[EditIndex][ETextDrawZoom] = 1.0;
						ProjectTD[EditIndex][ETextDrawVehCol1] = 1;
	                    ProjectTD[EditIndex][ETextDrawVehCol2] = 1;
						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);
	                }
	                case 3:
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TDE_TextDrawSetSelectable(TDE_Menu[c], true);
						        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

						TDE_TextDrawCreate(ProjectTD[Index][ETextDrawID], 290.0, 190.0, "box");
						TDE_TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 10.0);
						TDE_TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TDE_TextDrawUseBox(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawTextSize(ProjectTD[Index][ETextDrawID], 350.0, 0.0);
						TDE_TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TDE_TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
						TDE_TextDrawBoxColor(ProjectTD[Index][ETextDrawID], 255);
						TDE_TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "box");
						ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 10.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 350.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);

				        if(EditMode == EDITMODE_MODELS)
				        {
				            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	            }
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_MANAGE:
	    {
	        if(response)
	        {
	            if(BackManageDialog[listitem] == 1)
				{
                    PageStart -= 10;
                    ShowManage(ProjectEditor);
				    return 1;
				}

	            if(listitem == 10)
				{
					PageStart += 10;
                    ShowManage(ProjectEditor);
                    return 1;
				}

				new id = 0;
                for(new i = PageStart; i < MAX_PROJECT_TEXTDRAWS; i ++)
                {
                    if(ProjectTD[i][ItsFromTDE] == 1)
                    {
						if(id == listitem)
						{
						    EditIndex = i;
							break;
						}
						id ++;
					}
                }
                UpdateIcons(EditIndex);
                new string[128];
                format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}selected.", EditIndex);
                SendClientMessage(ProjectEditor, -1, string);
                SelectTextDraw(ProjectEditor, -1);
                IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
		case DIALOG_SELECTTDS:
		{
			if(response)
	        {
	            if(BackManageDialog[listitem] == 1)
				{
                    PageStart -= 10;
                    ShowSelectTDManage(ProjectEditor);
				    return 1;
				}

	            if(listitem == 10)
				{
					PageStart += 10;
                    ShowSelectTDManage(ProjectEditor);
                    return 1;
				}

				new id = 0;
                for(new i = PageStart; i < MAX_PROJECT_TEXTDRAWS; i ++)
                {
                    if(ProjectTD[i][ItsFromTDE] == 1)
                    {
						if(id == listitem)
						{
							if(SelectedTextDraws[i]) SelectedTextDraws[i] = false;
							else SelectedTextDraws[i] = true;
							break;
						}
						id ++;
					}
                }
                ShowSelectTDManage(ProjectEditor);
                
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
		}
	    case DIALOG_EDITTEXT:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Text", "Insert the TextDraw text:", ">>", "X");
	            format(ProjectTD[EditIndex][ETextDrawText], 800, "%s", inputtext);
	            TDE_TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_MODELID:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	            if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
				ProjectTD[EditIndex][ETextDrawModelid] = inputtext[0];
				TDE_TextDrawSetPreviewModel(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawModelid]);
				if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) TDE_TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_CONFIRMEDELETE:
	    {
	        if(response)
	        {
	            if(EditIndex == INVALID_INDEX_ID) return false;
             	new string[128];
                format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}removed.", EditIndex);
                SendClientMessage(ProjectEditor, -1, string);

	            RemoveTextDrawTDE(EditIndex);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_SIZEX:
		{
            if(response)
			{
			    new Float:SizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
	            if(sscanf(inputtext, "f", SizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
				ProjectTD[EditIndex][ETextDrawTextX] = SizeX;
				new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	            if(alignment == 2) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
	            else TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0) ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "<<");
	            ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
 		    return 1;
	    }
	    case DIALOG_SIZEY:
	    {
	        if(response)
	        {
	            new Float:SizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
	            if(sscanf(inputtext, "f", SizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
                if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)
                {
                    ProjectTD[EditIndex][ETextDrawLetterY] = SizeY;
		            TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		            SelectTextDraw(ProjectEditor, -1);
		            IsPSel = true;
                    return 1;
                }
				ProjectTD[EditIndex][ETextDrawTextY] = SizeY;
	            new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	            if(alignment == 2) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
	            else TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
	    }
	    case DIALOG_EDITOUTLINE:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
				//if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
                ProjectTD[EditIndex][ETextDrawOutline] = inputtext[0];
				TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], inputtext[0]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_MODELS:
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	                case 1: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 2: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 3: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 4: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
	                case 5: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
	                case 6: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
	            }
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_MODELS_MLD:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	            if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawModelid] = inputtext[0];
				TDE_TextDrawSetPreviewModel(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawModelid]);
				if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) TDE_TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RX:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotX] = coord;
				TDE_TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RY:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotY] = coord;
				TDE_TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RZ:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotZ] = coord;
				TDE_TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_ZO:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawZoom] = coord;
				TDE_TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
		case DIALOG_MODELS_C1:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawVehCol1] = inputtext[0];
				TDE_TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
		case DIALOG_MODELS_C2:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawVehCol2] = inputtext[0];
				TDE_TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_EDITSHADOW:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
				//if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
                ProjectTD[EditIndex][ETextDrawShadow] = inputtext[0];
				TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], inputtext[0]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_LETTERX:
	    {
			if(response)
			{
			    new Float:LetterSizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawLetterX] = LetterSizeX;
	            TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "<<");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_LETTERY:
	    {
			if(response)
			{
			    new Float:LetterSizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawLetterY] = LetterSizeY;
	            TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	    }
	    case DIALOG_POSX:
	    {
			if(response)
			{
			    new Float:LetterSizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
				
				if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
	   			{
				    if(TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
					{
					    new Float:Offset = ProjectTD[EditIndex][ETextDrawTextX] - ProjectTD[EditIndex][ETextDrawPosX];
						ProjectTD[EditIndex][ETextDrawTextX] = LetterSizeX+Offset;
				    	TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
					}
				}
				ProjectTD[EditIndex][ETextDrawPosX] = LetterSizeX;
	            TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_POSY:
	    {
			if(response)
			{
			    new Float:LetterSizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawPosY] = LetterSizeY;
	            TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
	    }
	    case DIALOG_MIRROR:
	    {
	    	if(response)
			{
		        new Index = GetAvailableIndex();
				if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");

				new string[128];
		        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}was duplicated on TextDraw{e2b960} #%d.", EditIndex, Index);
		        SendClientMessage(ProjectEditor, -1, string);
				DuplicateTextDraw(EditIndex, Index);

				switch(listitem)
				{
					// Mirror X
				    case 0: ProjectTD[Index][ETextDrawPosX] = floatabs(ProjectTD[Index][ETextDrawPosX] - 640.0);
					// Mirror Y
				    case 1: ProjectTD[Index][ETextDrawPosY] = floatabs(ProjectTD[Index][ETextDrawPosY] - 440.0);
					// Mirror XY
					case 2:
					{
					    ProjectTD[Index][ETextDrawPosX] = floatabs(ProjectTD[Index][ETextDrawPosX] - 640.0);
					    ProjectTD[Index][ETextDrawPosY] = floatabs(ProjectTD[Index][ETextDrawPosY] - 440.0);
					}
				}
	            TDE_TextDrawSetPos(ProjectTD[Index][ETextDrawID], ProjectTD[Index][ETextDrawPosX], ProjectTD[Index][ETextDrawPosY]);
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);
	        }
			SelectTextDraw(ProjectEditor, -1);
			IsPSel = true;
	    }


	    case DIALOG_EDITCOLOR:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
                        new str[1024];
						Loop(0, sizeof(PremadeColors))
						{
						    format(str, sizeof(str), "%s{%06x}%s\n", str, PremadeColors[c][0] >>> 8, PremadeColors[c][1]);
						}
						ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+100, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", str, ">>", "<<");
		            }
		            case 1: ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+101, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "Insert the color in HEX RRGGBBAA formar, for example: FF0000FF", ">>", "<<");
		            case 2: ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
		        }
		    }
		    else
			{
				EditMode = EDITMODE_NONE;
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
		}
		case DIALOG_EDITCOLOR+100:
		{
		    if(response)
		    {
		        switch(EditMode)
		        {
		        	case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = PremadeColors[listitem][0];
		        		TDE_TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = PremadeColors[listitem][0];
		        		TDE_TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = PremadeColors[listitem][0];
		        		TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
		    }
		    else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+101:
		{
		    if(response)
		    {
		        if(strlen(inputtext) < 8) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+101, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "Insert the color in HEX RRGGBBAA formar, for example: FF0000FF", ">>", "<<");

				if(inputtext[0] == '0' && inputtext[1] == 'x') Colors[0] = HexToInt(inputtext[2]);
				if(inputtext[0] == '#') Colors[0] = HexToInt(inputtext[1]);
		        else Colors[0] = HexToInt(inputtext);
		        switch(EditMode)
		        {
			        case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = Colors[0];
		        		TDE_TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = Colors[0];
		        		TDE_TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = Colors[0];
		        		TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
		    }
		    else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+102:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
			    Colors[0] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+103:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "X");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "X");
			    Colors[1] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
		}
		case DIALOG_EDITCOLOR+104:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "X");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "X");
			    Colors[2] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "<<");
		}
		case DIALOG_EDITCOLOR+105:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			    Colors[3] = inputtext[0];
			    new color = RGB(Colors[0], Colors[1], Colors[2], Colors[3]);
			    switch(EditMode)
		        {
			        case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = color;
		        		TDE_TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = color;
		        		TDE_TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = color;
		        		TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "<<");
		}
	}
	return false;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(!EditorEnabled && ProjectEditor == -1)
	    {
	        if(!IsPSel) return false;
	    	TogglePlayerControllable(playerid, true);
	    	TDE_TextDrawHideForPlayer(playerid, TDELOGO);
	        DestroyMenuTextDraws();
	        MouseCursor = false;
	        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor closed.");
	        return 1;
	    }
	}
	if(clickedid == TDELOGO)
	{
	    if(!IsPSel) return false;
	    IsPSel = false;
	    TDE_TextDrawHideForPlayer(playerid, TDELOGO);
	    CancelSelectTextDraw(playerid);
	    ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor started, if you need help you can use /tde help...");
		return 1;
	}

	if(!EditorEnabled || ProjectEditor != playerid) return false;
	if(EditMode == EDITMODE_ADJUST) return false;
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(!IsPSel) return false;
		if(MouseCursor) SelectTextDraw(playerid, -1);
	    return 1;
	}
	if(clickedid == TDE_Menu[1])
	{
	    if(EditIndex == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "Error");
	    if(EditMode == EDITMODE_COLOR || EditMode == EDITMODE_BGCOLOR || EditMode == EDITMODE_BOXCOLOR || EditMode == EDITMODE_MODELS)
	    {
	        if(!CursorX && (0 < CursorY < (ScreenHeight - 1)) ) return 1;
	        if(CursorX == (ScreenWidth - 1) && (0 < CursorY < (ScreenHeight - 1)) ) return 1;
	        if(CursorY == (ScreenHeight - 1) && (0 < CursorX < (ScreenWidth - 1)) ) return 1;
	    }
	    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    EditMode = EDITMODE_NONE;
	    IsPSel = false;
	    CancelSelectTextDraw(ProjectEditor);
	    //CheckManageDialog();
     	new d, c, e = -1, dialog[310], str[31];
	    for (d = PageStart; d < MAX_PROJECT_TEXTDRAWS; d++)
		{
		    if(ProjectTD[d][ItsFromTDE] == 1)
		    {
			    e = 1;
				BackManageDialog[c] = 0;
				c ++;
				if(c == 11)
				{
					if(PageStart >= 10)
				    {
						format(str, 30, ">>\n");
						strcat(dialog, str);
					}
					else
					{
					    format(str, 30, ">>");
					    strcat(dialog, str);
					}
					break;
				}
				if(TDE_TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
				else format(str, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);
				if(strlen(str) >= 30)
				{
					strdel(str, 28, 30);
					strcat(str, "\n");
				}
				strcat(dialog, str);
			}
		}
		if(PageStart >= 10)
		{
		    BackManageDialog[c] = 1;
			format(str, 30, "<<");
			strcat(dialog, str);
		}
		if(e == -1)
		{

		    new d1, c1, e1 = -1, dialog1[310], str1[31], DC = PageStart - 10;
		    for (d1 = DC; d1 < DC+11; d1++)
			{
			    if(ProjectTD[d1][ItsFromTDE] == 1)
			    {
				    e1 = 1;

					BackManageDialog[c] = 0;
					c1 ++;
					if(c1 == 11)
					{
					    if(DC >= 10)
					    {
							format(str1, 30, ">>\n");
							strcat(dialog1, str1);
						}
						else
						{
						    format(str1, 30, ">>");
						    strcat(dialog1, str1);
						}
						break;
					}
					if(TDE_TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str1, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
					else format(str1, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);

					if(strlen(str1) >= 30)
					{
						strdel(str1, 28, 30);
						strcat(str1, "\n");
					}
					strcat(dialog1, str1);
				}
			}
			if(DC >= 10)
			{
			    BackManageDialog[c1] = 1;
			    format(str1, 30, "<<");
				strcat(dialog1, str1);
			}
			if(e1 == -1) return SelectTextDraw(ProjectEditor, -1), IsPSel = true, SendClientMessage(ProjectEditor, -1, "Error");
			PageStart -= 10;
		    ShowPlayerDialog(ProjectEditor, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog1, ">>", "X");
		    IsPSel = false;
		    return 1;
		}
		ShowPlayerDialog(ProjectEditor, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog, ">>", "X");
		IsPSel = false;
	}
	if(clickedid == TDE_Menu[2])
	{
        new Index = GetAvailableIndex();
		if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
      	EditIndex = Index;

      	if(EditIndex == 0)
      	{
       		Loop(1, sizeof(TDE_Menu))
		    {
				TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
				TDE_TextDrawSetSelectable(TDE_Menu[c], true);
		        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
		    }
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
      	}

		TDE_TextDrawCreate(ProjectTD[Index][ETextDrawID], 290.0, 190.0, "TDEditor");
		TDE_TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.4, 1.6);
		TDE_TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
		TDE_TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
		TDE_TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
		TDE_TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
		TDE_TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
		TDE_TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
		TDE_TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
		TDE_TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
		TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


	    ProjectTD[EditIndex][ItsFromTDE] = 1;
	    format(ProjectTD[EditIndex][ETextDrawText], 800, "TDEditor");
		ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
		ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
		ProjectTD[EditIndex][ETextDrawLetterX] = 0.4;
		ProjectTD[EditIndex][ETextDrawLetterY] = 1.6;
		ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
		ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
		ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

		new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
        SendClientMessage(ProjectEditor, -1, string);
        UpdateIcons(EditIndex);

        if(EditMode == EDITMODE_MODELS)
        {
            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
	    return 1;
	}
	if(EditIndex == INVALID_INDEX_ID) return false;
	if(clickedid == TDE_Menu[3])
	{
	    IsPSel = false;
		CancelSelectTextDraw(ProjectEditor);
		TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
		EditMode = EDITMODE_NONE;
	    ShowPlayerDialog(ProjectEditor, DIALOG_CONFIRMEDELETE, DIALOG_STYLE_MSGBOX, "TDEditor - Remove TextDraw", "Are you sure you want to delete this TextDraw?", "Remove", "X");
	    IsPSel = false;
	    return 1;
	}
	if(clickedid == TDE_Menu[4])
	{
	    ExportProject();
	    return 1;
	}
	if(clickedid == TDE_Menu[8])
	{
        new Index = GetAvailableIndex();
		if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
		DuplicateTextDraw(EditIndex, Index);

		new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}was duplicated on TextDraw{e2b960} #%d.", EditIndex, Index);
        SendClientMessage(ProjectEditor, -1, string);
      	EditIndex = Index;
	    return 1;
	}
	if(clickedid == TDE_Menu[9])
	{
		if(EditMode != EDITMODE_POSITION)
		{
			TDE_TextDrawSetString(TD_Status, "EDITMODE_POSITION");
			EditMode = EDITMODE_POSITION;
		}
		else TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[10])
	{
	    if(EditMode != EDITMODE_SIZE)
		{
			TDE_TextDrawSetString(TD_Status, "EDITMODE_SIZE");
			EditMode = EDITMODE_SIZE;
		}
		else TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[11] || clickedid == TDE_Menu[35])
	{
 		/*if((GetTickCount() - DoubleClickCount) <= 180)
 		{
 		    ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Español", "Introduzca el texto aquí:", ">>", "X");
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    IsPSel = false;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
 		}
	    DoubleClickCount = GetTickCount();
	    */
	    if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	    {
	        IsPSel = false;
			CancelSelectTextDraw(ProjectEditor);
			TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
			EditMode = EDITMODE_NONE;
		    ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	        return 1;
	    }
		if(EditMode != EDITMODE_TEXT)
		{
			TDE_TextDrawSetString(TD_Status, "EDITMODE_TEXT");
			EditMode = EDITMODE_TEXT;
	    }
		else TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[14])
	{
	    if(EditMode != EDITMODE_COLOR)
		{
			ShowInfoDraw("~n~~n~~n~MOVE CURSOR AT CORNERS", 1000);
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_COLOR");
	    	EditMode = EDITMODE_COLOR;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[15])
	{
	    if(EditMode != EDITMODE_BGCOLOR)
		{
		    ShowInfoDraw("~n~~n~~n~MOVE CURSOR AT CORNERS", 1000);
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_BGCOLOR");
	    	EditMode = EDITMODE_BGCOLOR;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[32])
	{
	    if(EditMode != EDITMODE_BOXCOLOR)
		{
		    ShowInfoDraw("~n~~n~~n~MOVE CURSOR AT CORNERS", 1000);
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_BOXCOLOR");
	    	EditMode = EDITMODE_BOXCOLOR;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[16])
	{
	    if(EditMode != EDITMODE_LETTERSIZE)
		{
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_LETTERSIZE");
	    	EditMode = EDITMODE_LETTERSIZE;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[17])
	{
	    if(EditMode != EDITMODE_OUTLINE)
		{
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_OUTLINE");
	    	EditMode = EDITMODE_OUTLINE;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[18])
	{
	    if(EditMode != EDITMODE_SHADOW)
		{
	    	TDE_TextDrawSetString(TD_Status, "EDITMODE_SHADOW");
	    	EditMode = EDITMODE_SHADOW;
		}
		else
		{
		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[12] || clickedid == TDE_Menu[13] || clickedid == TDE_Menu[24] || clickedid == TDE_Menu[25] || clickedid == TDE_Menu[26] || clickedid == TDE_Menu[27])
	{
	    if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	    {
	        if(EditMode != EDITMODE_MODELS)
			{
		 		Colors[0] = floatround(ProjectTD[EditIndex][ETextDrawRotX]);
	            Colors[1] = floatround(ProjectTD[EditIndex][ETextDrawRotY]);
	            Colors[2] = floatround(ProjectTD[EditIndex][ETextDrawRotZ]);
	            Zoom = ProjectTD[EditIndex][ETextDrawZoom];

		    	TDE_TextDrawSetString(TD_Status, "EDITMODE_MODELS");
		    	EditMode = EDITMODE_MODELS;
			}
			else
			{
			    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
		    	EditMode = EDITMODE_NONE;
			}
	        return 1;
	    }
	    new font = TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]);
	    switch(font)
	    {
	        case 0:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~FONT~w~1", 1000);
	            TDE_TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 1);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[25]);
	        }
	        case 1:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~FONT~w~2", 1000);
	            TDE_TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 2);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[26]);
	        }
	        case 2:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~FONT~w~3", 1000);
	            TDE_TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 3);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[27]);
	        }
	        case 3:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~FONT~w~0", 1000);
	            TDE_TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 0);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[24]);
	        }
	    }
	    return 1;
	}
    if(clickedid == TDE_Menu[19] || clickedid == TDE_Menu[20] || clickedid == TDE_Menu[34])
	{
		if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
		    ShowInfoDraw("~n~~n~~n~~y~BOX~w~0", 1000);
			TDE_TextDrawUseBox(ProjectTD[EditIndex][ETextDrawID], 0);
			TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], 0);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
		}
		else
		{
		    ShowInfoDraw("~n~~n~~n~~y~BOX~w~1", 1000);
		    TDE_TextDrawUseBox(ProjectTD[EditIndex][ETextDrawID], 1);
		    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
		    if(ProjectTD[EditIndex][ETextDrawTextX] == 0.0)
			{
			    switch(alignment)
			    {
			    	case 1: ProjectTD[EditIndex][ETextDrawTextX] = floatadd(ProjectTD[EditIndex][ETextDrawPosX], 5.0);
			    	case 2: ProjectTD[EditIndex][ETextDrawTextX] = 10.0;
			    	case 3: ProjectTD[EditIndex][ETextDrawTextX] = floatadd(ProjectTD[EditIndex][ETextDrawPosX], 5.0); //SA-MP BUG?
				}
			}
		    if(alignment == 2) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		    else TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
		    TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], 255);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
		}
		return 1;
	}
    if(clickedid == TDE_Menu[21] || clickedid == TDE_Menu[22] || clickedid == TDE_Menu[23])
	{
	    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	        case 1:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~ALIGNMENT~w~2", 1000);
	            TDE_TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 2);
	            if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
	        }
	        case 2:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~ALIGNMENT~w~3", 1000);
	            TDE_TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 3);
	            if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
	        }
	        case 3:
	        {
	            ShowInfoDraw("~n~~n~~n~~y~ALIGNMENT~w~1", 1000);
	            TDE_TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 1);
	            if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
				TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
	        }
	    }
	    return 1;
	}
    if(clickedid == TDE_Menu[28] || clickedid == TDE_Menu[29])
	{
	    if(ProjectTD[EditIndex][ETextDrawSelectable] == 0)
	    {
	        ShowInfoDraw("~n~~n~~n~~y~SELECTABLE~w~1", 1000);
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[29]);
			ProjectTD[EditIndex][ETextDrawSelectable] = 1;
	    }
	    else
	    {
	        ShowInfoDraw("~n~~n~~n~~y~SELECTABLE~w~0", 1000);
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[28]);
			ProjectTD[EditIndex][ETextDrawSelectable] = 0;
	    }
	    return 1;
	}
	if(clickedid == TDE_Menu[5] || clickedid == TDE_Menu[33])
	{
	    if(ProjectTD[EditIndex][ETextDrawType] == 0)
	    {
	        ShowInfoDraw("~n~~n~~n~~y~TYPE~w~PLAYER", 1000);
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[33]);
			ProjectTD[EditIndex][ETextDrawType] = 1;
	    }
	    else
	    {
	        ShowInfoDraw("~n~~n~~n~~y~TYPE~w~GLOBAL", 1000);
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[5]);
			ProjectTD[EditIndex][ETextDrawType] = 0;
	    }
	    return 1;
	}
	if(clickedid == TDE_Menu[30] || clickedid == TDE_Menu[31])
	{
	    if(EditMode == EDITMODE_COLOR || EditMode == EDITMODE_BGCOLOR || EditMode == EDITMODE_BOXCOLOR || EditMode == EDITMODE_MODELS)
	    {
	        if(!CursorX && (0 < CursorY < (ScreenHeight - 1)) ) return 1;
	        if(CursorX == (ScreenWidth - 1) && (0 < CursorY < (ScreenHeight - 1)) ) return 1;
	        if(CursorY == (ScreenHeight - 1) && (0 < CursorX < (ScreenWidth - 1)) ) return 1;
	    }
	    new proportional = TDE_TextDrawIsProportional(ProjectTD[EditIndex][ETextDrawID]);
		if(proportional == 0)
		{
		    ShowInfoDraw("~n~~n~~n~~y~PROPORTIONAL~w~1", 1000);
			TDE_TextDrawSetProportional(ProjectTD[EditIndex][ETextDrawID], 1);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
		}
		else
		{
		    ShowInfoDraw("~n~~n~~n~~y~PROPORTIONAL~w~0", 1000);
			TDE_TextDrawSetProportional(ProjectTD[EditIndex][ETextDrawID], 0);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
		}
		TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		return 1;
	}
	return false;
}

stock ActivateCallback_OnAnyKeyDown()
{
    ActivateAnyKeyVariable(1);
    ActivateAnyKey();
    return 1;
}

public OnAnyKeyDown(key)
{
 	printf("%d %c", key, key);
	return 1;
}

TDE_CALLBACK:OnEditorUpdate(playerid)
{
    //if(IsPlayerPaused(playerid)) return 0;
    for(new c = 0; c < sizeof(VirtualKeys); c++)
	{
		if(GetVirtualKeyState(VirtualKeys[c][KEY_CODE]) & 0x8000)
		{
		    if(!VirtualKeys[c][KEY_PRESSED])
		    {
		        CallLocalFunction("OnVirtualKeyDown", "id", playerid, VirtualKeys[c][KEY_CODE]);
		        VirtualKeys[c][KEY_PRESSED] = true;
		    }
		}
		else if(VirtualKeys[c][KEY_PRESSED])
		{
		    CallLocalFunction("OnVirtualKeyRelease", "id", playerid, VirtualKeys[c][KEY_CODE]);
		    VirtualKeys[c][KEY_PRESSED] = false;
		}
	}

	GetScreenSize(ScreenWidth, ScreenHeight);
	GetMousePos(CursorX, CursorY);

	if(CursorOX != CursorX || CursorOY != CursorY)
	{
	    CallLocalFunction("OnCursorPositionChange", "idd", playerid, CursorX, CursorY);
	    CursorOX = CursorX;
	    CursorOY = CursorY;
	}
	return 1;
}

TDE_CALLBACK:OnCursorPositionChange(playerid, NewX, NewY)
{
    if(!EditorEnabled || ProjectEditor != playerid) return false;
    if(TDEHTimer == 1)
	{
	 	TDE_TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(NewX), ScreenWidth) * 640.0)+0.15), -6.000000);
		TDE_TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(NewY), ScreenHeight) * 448.0)/9.0)+0.4));
		TDE_TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(NewX), ScreenWidth) * 640.0)+1.0), (floatdiv(float(NewY), ScreenHeight) * 448.0));

	    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
    }
    if(EditMode == EDITMODE_ADJUST)
    {
        if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
		{
        	OffsetZ -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
    	    TDE_TextDrawSetPos(TDE_Menu[0], 0.0, OffsetZ - 2.0);
    	    TDE_TextDrawShowForPlayer(playerid, TDE_Menu[0]);
         	if(OffsetZ < 10.0) TDE_TextDrawSetPos(TD_Status, 2.0, OffsetZ+35.14);
        	else TDE_TextDrawSetPos(TD_Status, 2.0, OffsetZ-10.14);
    	    TDE_TextDrawShowForPlayer(playerid, TD_Status);
            return 1;
		}
		return 1;
    }

	if(EditIndex == INVALID_INDEX_ID) return false;
    switch(EditMode)
    {
        case EDITMODE_POSITION:
        {
            if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
				if(moveselectedtds)
				{
					for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
					{
						if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
						{
							ProjectTD[i][ETextDrawPosX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
							ProjectTD[i][ETextDrawPosY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;

							if(PixelLock)
							{
								ProjectTD[i][ETextDrawPosX] = float(floatround(ProjectTD[i][ETextDrawPosX], floatround_round));
								ProjectTD[i][ETextDrawPosY] = float(floatround(ProjectTD[i][ETextDrawPosY], floatround_round));
							}

							TDE_TextDrawSetPos(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY]);

							if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]))
							{
								if(TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]) != 2)
								{
									ProjectTD[i][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
									ProjectTD[i][ETextDrawTextX] = float(floatround(ProjectTD[i][ETextDrawTextX], floatround_round));
									TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								}
							}
							TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						}
					}
				}
				else
				{
					ProjectTD[EditIndex][ETextDrawPosX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
					ProjectTD[EditIndex][ETextDrawPosY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;

					if(PixelLock)
					{
						ProjectTD[EditIndex][ETextDrawPosX] = float(floatround(ProjectTD[EditIndex][ETextDrawPosX], floatround_round));
						ProjectTD[EditIndex][ETextDrawPosY] = float(floatround(ProjectTD[EditIndex][ETextDrawPosY], floatround_round));
					}

					TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);

					if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
					{
						if(TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
						{
							ProjectTD[EditIndex][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
							ProjectTD[EditIndex][ETextDrawTextX] = float(floatround(ProjectTD[EditIndex][ETextDrawTextX], floatround_round));
							TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
						}
					}
					format(SpeedSTR, 256, "~n~~n~~n~~y~posX~w~%.4f ~y~posY~w~%.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
					ShowInfoDraw(SpeedSTR, 1000);

					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				}
			}
		}
		case EDITMODE_SIZE:
        {
            if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
				if(moveselectedtds)
				{
					for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
					{
						if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
						{
							ProjectTD[i][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
							ProjectTD[i][ETextDrawTextX] = float(floatround(ProjectTD[i][ETextDrawTextX], floatround_round));
							if(TDE_TextDrawGetFont(ProjectTD[i][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[i][ETextDrawID]) == 5)
							{
								ProjectTD[i][ETextDrawTextY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
								ProjectTD[i][ETextDrawTextY] = float(floatround(ProjectTD[i][ETextDrawTextY], floatround_round));
							}

							new alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
							switch(alignment)
							{
								case 1, 3: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								case 2: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
							}
							if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]) && ProjectTD[i][ETextDrawLetterX] == 0.0)
							{
								ProjectTD[i][ETextDrawLetterY] -= (floatdiv(floatsub(CursorOY, NewY), ScreenWidth) * 640.0)/10.0;
								TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
								TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
								return 1;
							}
							
							TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						}
					}
				}
				else
				{
					ProjectTD[EditIndex][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
					ProjectTD[EditIndex][ETextDrawTextX] = float(floatround(ProjectTD[EditIndex][ETextDrawTextX], floatround_round));
					if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
					{
						ProjectTD[EditIndex][ETextDrawTextY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
						ProjectTD[EditIndex][ETextDrawTextY] = float(floatround(ProjectTD[EditIndex][ETextDrawTextY], floatround_round));
					}

					new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
					switch(alignment)
					{
						case 1, 3: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
						case 2: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
					}
					if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)
					{
						ProjectTD[EditIndex][ETextDrawLetterY] -= (floatdiv(floatsub(CursorOY, NewY), ScreenWidth) * 640.0)/10.0;
						TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
						format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
						ShowInfoDraw(SpeedSTR, 1000);

						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
						return 1;
					}

					format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~sizeY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
					ShowInfoDraw(SpeedSTR, 1000);
					
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				}
			}
		}
		case EDITMODE_MODELS:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
			    switch(ColorMode)
	            {
	                case COLORMODE_RED: Colors[0] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 360.0  );
	                case COLORMODE_GREEN: Colors[1] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 360.0  );
	                case COLORMODE_BLUE: Colors[2] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 360.0 );
	                case COLORMODE_ALPHA: Zoom = floatdiv((NewX - 1), (ScreenWidth - 2)) * 10.0;
				}
				format(SpeedSTR, 256, "~n~~n~~n~~y~RX~w~%i~n~~y~RY~w~%i~n~~y~RZ~w~%i~n~~y~Z~w~%.2f", Colors[0], Colors[1], Colors[2], Zoom);
				ShowInfoDraw(SpeedSTR, 1000);
	            ProjectTD[EditIndex][ETextDrawRotX] = float(Colors[0]);
	            ProjectTD[EditIndex][ETextDrawRotY] = float(Colors[1]);
	            ProjectTD[EditIndex][ETextDrawRotZ] = float(Colors[2]);
	            ProjectTD[EditIndex][ETextDrawZoom] = Zoom;
	            TDE_TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_COLOR, EDITMODE_BGCOLOR, EDITMODE_BOXCOLOR:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{

			    if(EditMode == EDITMODE_COLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawColor], Colors[0], Colors[1], Colors[2], Colors[3]);
			    else if(EditMode == EDITMODE_BGCOLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawBGColor], Colors[0], Colors[1], Colors[2], Colors[3]);
			    else if(EditMode == EDITMODE_BOXCOLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawBoxColor], Colors[0], Colors[1], Colors[2], Colors[3]);
	            switch(ColorMode)
	            {
	                case COLORMODE_RED: Colors[0] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 255.0  );
	                case COLORMODE_GREEN: Colors[1] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 255.0  );
                    case COLORMODE_BLUE: Colors[2] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 255.0 );
                    case COLORMODE_ALPHA: Colors[3] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 255.0  );
				}
				format(SpeedSTR, 256, "~n~~n~~n~~r~R%i~n~~g~G%i~n~~b~B%i~n~~w~A%i", Colors[0], Colors[1], Colors[2], Colors[3]);
				ShowInfoDraw(SpeedSTR, 1000);
				switch(EditMode)
				{
				    case EDITMODE_COLOR:
				    {
						ProjectTD[EditIndex][ETextDrawColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TDE_TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
				    {
						ProjectTD[EditIndex][ETextDrawBGColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TDE_TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
				    {
						ProjectTD[EditIndex][ETextDrawBoxColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TDE_TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
	            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_OUTLINE:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
				if(moveselectedtds)
				{
					for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
					{
						if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
						{
							ProjectTD[i][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
							ProjectTD[i][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
							TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
							TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						}
					}
				}
				else
				{
					ProjectTD[EditIndex][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
					ProjectTD[EditIndex][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
					TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
					format(SpeedSTR, 256, "~n~~n~~n~~y~OUTLINE~w~%d", ProjectTD[EditIndex][ETextDrawOutline]);
					ShowInfoDraw(SpeedSTR, 1000);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				}
			}
		}
		case EDITMODE_SHADOW:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
				if(moveselectedtds)
				{
					for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
					{
						if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
						{
							ProjectTD[i][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
							ProjectTD[i][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
							TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
							TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						}
					}
				}
				else
				{
					ProjectTD[EditIndex][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
					ProjectTD[EditIndex][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
					TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
					format(SpeedSTR, 256, "~n~~n~~n~~y~SHADOW~w~%d", ProjectTD[EditIndex][ETextDrawShadow]);
					ShowInfoDraw(SpeedSTR, 1000);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				}
			}
		}
		case EDITMODE_LETTERSIZE:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
				if(moveselectedtds)
				{
					for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
					{
						if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
						{
							ProjectTD[i][ETextDrawLetterX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0 * 0.001;
							ProjectTD[i][ETextDrawLetterY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0 * 0.01;
							TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
							TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						}
					}
				}
				else
				{
					ProjectTD[EditIndex][ETextDrawLetterX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0 * 0.001;
					ProjectTD[EditIndex][ETextDrawLetterY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0 * 0.01;
					TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
					format(SpeedSTR, 256, "~n~~n~~n~~y~letterX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
					ShowInfoDraw(SpeedSTR, 1000);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				}
			}
		}
	}
	return true;
}

TDE_CALLBACK:OnVirtualKeyRelease(playerid, key)
{
  	if(!EditorEnabled || ProjectEditor != playerid) return false;
  	if(key == VK_ESCAPE)
  	{
  	    if(EditMode == EDITMODE_ADJUST)
	    {
	        SelectTextDraw(playerid, -1);
	        if(!VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	          	new Float:pos[2];
	        	for(new i = 1; i < sizeof(TDE_Menu); i++)
	        	{
	        	    if(i == 6 || i == 7) continue;
	        	    TDE_TextDrawGetPos(TDE_Menu[i], pos[0], pos[1]);
	        	    TDE_TextDrawSetPos(TDE_Menu[i], pos[0], OffsetZ);
	        	    TDE_TextDrawShowForPlayer(playerid, TDE_Menu[i]);
	        	}

	 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	 		    EditMode = EDITMODE_NONE;
	 		    IsPSel = true;
				return 1;
			}
	    }
  	}
  	if(key == VK_LBUTTON)
	{
        if(ColorMode) ColorMode = 0;
        if(IsPSel) SaveProject();
	}
  	if(EditMode == EDITMODE_ADJUST) return false;
	if(key == VK_RBUTTON)
	{
	    if(!IsPSel) return false;
		new Float:ConvertedX, Float:ConvertedY;
		ConvertedX = ((floatdiv(float(CursorX), ScreenWidth) * 640.0));
		ConvertedY = (((floatdiv(float(CursorY), ScreenHeight) * 448.0)));
		if( (ConvertedX > 64.01 && ConvertedX < 32.0+64.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //New
	    {
	        ShowPlayerDialog(ProjectEditor, DIALOG_NEW, DIALOG_STYLE_LIST, "TDEditor - New TextDraw", "Normal TextDraw\nSprite TextDraw (TXD)\nPreview Models (objects, vehicles, skins)\nBox TextDraw", ">>", "X");
	        IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
		if( (ConvertedX > 128.01 && ConvertedX < 32.0+128.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Duplicate
		{
			if(EditIndex == INVALID_INDEX_ID) return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}No textdraw selected");
            ShowPlayerDialog(ProjectEditor, DIALOG_MIRROR, DIALOG_STYLE_LIST, "TDEditor - Mirror Textdraw", "Mirror X\nMirror Y\nMirror XY", ">>", "X");
	        IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
		}

		if(EditIndex == INVALID_INDEX_ID) return false;
		if( (ConvertedX > 192.01 && ConvertedX < 32.0+192.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Position
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 160.01 && ConvertedX < 32.0+160.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Models/Font
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	        {
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
	            IsPSel = false;
	 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	 		    EditMode = EDITMODE_NONE;
	 		    CancelSelectTextDraw(ProjectEditor);
	 		    return 1;
			}
			return 1;
	    }
	    if( (ConvertedX > 224.01 && ConvertedX < 32.0+224.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //TextSize
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 256.01 && ConvertedX < 32.0+256.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Text
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Text", "Insert the TextDraw text:", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 384.01 && ConvertedX < 32.0+384.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //LetterSize
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 416.01 && ConvertedX < 32.0+416.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Outline
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 448.01 && ConvertedX < 32.0+448.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Shadow
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 288.01 && ConvertedX < 32.0+288.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Colors
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_COLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 320.01 && ConvertedX < 32.0+320.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //BGColors
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BGColor", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_BGCOLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 352.01 && ConvertedX < 32.0+352.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //BoxColors
	    {
	        if(TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TDE_TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BoxColor", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
 		    EditMode = EDITMODE_BOXCOLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	}
    switch(EditMode)
    {
	    case EDITMODE_TEXT:
	    {
	        if(key == VK_DELETE || key == VK_BACKSPACE) KillTimer(DeleteTimer);
		}
		case EDITMODE_POSITION:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(SpeedTimer);
		}
		case EDITMODE_SIZE:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(EditSizeSpeedT);
		}
		case EDITMODE_OUTLINE:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_UP || key == VK_RIGHT || key == VK_OEM_MINUS || key == VK_SUBTRACT || key == VK_DOWN || key == VK_LEFT) KillTimer(OutlineTimer);
		}
		case EDITMODE_SHADOW:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_UP || key == VK_RIGHT || key == VK_OEM_MINUS || key == VK_SUBTRACT || key == VK_DOWN || key == VK_LEFT) KillTimer(ShadowTimer);
		}
		case EDITMODE_LETTERSIZE:
		{
		    if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(LetterTimer);
		}
	}
	return 1;
}

TDE_CALLBACK:OnVirtualKeyDown(playerid, key)
{

    if(!EditorEnabled || ProjectEditor != playerid) return false;

    if(key == VK_RBUTTON)
    {
        if(TDEHTimer == 1)
		{
		    TDEHTimer = 2;
		    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Right click again to unfreeze the red lines.");
		}
		else if(TDEHTimer == 2)
		{
		    new X, Y;
		    GetMousePos(X, Y);
 			TDE_TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(X), ScreenWidth) * 640.0)+0.15), -6.000000);
			TDE_TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(Y), ScreenHeight) * 448.0)/9.0)+0.4));
			TDE_TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(X), ScreenWidth) * 640.0)+1.0), (floatdiv(float(Y), ScreenHeight) * 448.0));
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
			TDEHTimer = 1;
		}
    }

	if(VirtualKeys[44][KEY_PRESSED])
	{
	    if(key == VK_KEY_R)
	    {
	        if(TDEHTimer == -1)
			{
			    new X, Y;
			    GetMousePos(X, Y);
	 			TDE_TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(X), ScreenWidth) * 640.0)+0.15), -6.000000);
				TDE_TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(Y), ScreenHeight) * 448.0)/9.0)+0.4));
				TDE_TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(X), ScreenWidth) * 640.0)+1.0), (floatdiv(float(Y), ScreenHeight) * 448.0));
				SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Right click to freeze the red lines.");
			    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
			    TDE_TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
				TDEHTimer = 1;
			}
	        else
			{
				TDEHTimer = -1;
				TDE_TextDrawHideForPlayer(ProjectEditor, TDEditor_Helper[0]);
    			TDE_TextDrawHideForPlayer(ProjectEditor, TDEditor_Helper[1]);
			}
	        return 1;
	    }
	    if(EditMode == EDITMODE_ADJUST) return false;
	    if(key == VK_KEY_C)
	    {
	        if(EditIndex == INVALID_INDEX_ID) return false;
	        if(!IsPSel) return false;
	        new Index = GetAvailableIndex();
			if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
			DuplicateTextDraw(EditIndex, Index);

			new string[128];
	        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}was duplicated on TextDraw{e2b960} #%d.", EditIndex, Index);
	        SendClientMessage(ProjectEditor, -1, string);
	      	EditIndex = Index;
	        return 1;
	    }
	    if(key == VK_KEY_X)
	    {
	        if(EditIndex == INVALID_INDEX_ID) return false;
	        if(!IsPSel) return false;
	        new string[128];
            format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}removed.", EditIndex);
            SendClientMessage(ProjectEditor, -1, string);

            RemoveTextDrawTDE(EditIndex);
            SelectTextDraw(ProjectEditor, -1);
		}
	}
	if(key == VK_END)
    {
        if(MouseCursor)
		{
			MouseCursor = false;
			TogglePlayerControllable(ProjectEditor, 1);
			CancelSelectTextDraw(ProjectEditor);
		}
        else
		{
			MouseCursor = true;
			TogglePlayerControllable(ProjectEditor, 0);
			SelectTextDraw(ProjectEditor, -1);
		}
        return 1;
    }

   	if(key == VK_HOME)
    {
        if(PixelLock)
		{
			PixelLock = false;
			SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Pixel Lock Off");
		}
        else
		{
			PixelLock = true;
            SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Pixel Lock On");
		}
        return 1;
    }



	if(EditMode == EDITMODE_ADJUST) return false;
	if(EditIndex == INVALID_INDEX_ID) return false;
    switch(EditMode)
    {
        case EDITMODE_TEXT:
        {
       		if(key == VK_KEY_T || key == VK_F6) PressKeyEnter(VK_ENTER);
            if(key == VK_DELETE || key == VK_BACKSPACE)
            {
                new len = strlen(ProjectTD[EditIndex][ETextDrawText]);
                if(len == 0) return 1;
                if(ProjectTD[EditIndex][ETextDrawText][len-1] == '~' && ProjectTD[EditIndex][ETextDrawText][len-2] == 'n' && ProjectTD[EditIndex][ETextDrawText][len-3] == '~')
				{
					strdel(ProjectTD[EditIndex][ETextDrawText], len-3, len);
				}
				else strdel(ProjectTD[EditIndex][ETextDrawText], len-1, len);
         		TDE_TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
         		DeleteTimer = SetTimer("DeleteTextDrawLetter", 500, 0);
                return 1;
            }
            /*new KEYT[24];                     NO HAVE GOOD WORK
            /format(KEYT, 24, "%c", key);*/
         	strcat(ProjectTD[EditIndex][ETextDrawText], KeyToString(key), 800);
         	TDE_TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
        }
        case EDITMODE_POSITION:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(MoveTDTimer == -1) MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditMoveSpeed == 0.05)
				 	{
				 		EditMoveSpeed = 0.1;
				 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
						ShowInfoDraw(SpeedSTR, 1000);
				 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditMoveSpeed += 0.1;
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
			 		ShowInfoDraw(SpeedSTR, 1000);
			 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditMoveSpeed <= 0.1)
					{
						EditMoveSpeed = 0.05;
				 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~r~%.2f", EditMoveSpeed);
						ShowInfoDraw(SpeedSTR, 1000);
				 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 1);
				 		return 1;
					}
					EditMoveSpeed -= 0.1;
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
					ShowInfoDraw(SpeedSTR, 1000);
			 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 1);
				}
            }
        }
        case EDITMODE_SIZE:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(EditSizeTDTimer == -1) EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditSizeSpeed == 0.05)
				 	{
				 		EditSizeSpeed = 0.1;
				 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
						ShowInfoDraw(SpeedSTR, 1000);
				 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditSizeSpeed += 0.1;
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
					ShowInfoDraw(SpeedSTR, 1000);
			 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditSizeSpeed <= 0.1)
					{
						EditSizeSpeed = 0.05;
				 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~r~%.2f", EditSizeSpeed);
						ShowInfoDraw(SpeedSTR, 1000);
				 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 1);
				 		return 1;
					}
					EditSizeSpeed -= 0.1;
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
					ShowInfoDraw(SpeedSTR, 1000);
			 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 1);
				}
            }
        }
        case EDITMODE_COLOR, EDITMODE_BGCOLOR, EDITMODE_BOXCOLOR, EDITMODE_MODELS:
        {
			if(key == VK_LBUTTON)
			{
		        if(!CursorX && (0 < CursorY < (ScreenHeight - 1)) && ColorMode != COLORMODE_RED) ColorMode = COLORMODE_RED;
		        if(CursorX == (ScreenWidth - 1) && (0 < CursorY < (ScreenHeight - 1)) && ColorMode != COLORMODE_BLUE) ColorMode = COLORMODE_BLUE;
		        if(!CursorY && (0 < CursorX < (ScreenWidth - 1)) && ColorMode != COLORMODE_GREEN) ColorMode = COLORMODE_GREEN;
		        if(CursorY == (ScreenHeight - 1) && (0 < CursorX < (ScreenWidth - 1)) && ColorMode != COLORMODE_ALPHA) ColorMode = COLORMODE_ALPHA;
			}
        }
        case EDITMODE_OUTLINE:
        {
            switch(key)
            {
                case VK_OEM_PLUS, VK_ADD, VK_UP, VK_RIGHT:
			 	{
					if(moveselectedtds)
					{
						for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
						{
							if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
							{
								ProjectTD[i][ETextDrawOutline] += 1;
								TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
								TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
							}
						}
						OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 0);
						return 1;
					}
			 	    ProjectTD[EditIndex][ETextDrawOutline] += 1;
					TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~OUTLINE~w~%d", ProjectTD[EditIndex][ETextDrawOutline]);
					ShowInfoDraw(SpeedSTR, 1000);

			 		OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 0);
			 	}
			 	case VK_OEM_MINUS, VK_SUBTRACT, VK_DOWN, VK_LEFT:
			 	{
					if(moveselectedtds)
					{
						for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
						{
							if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
							{
								ProjectTD[i][ETextDrawOutline] -= 1;
								TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
								TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
							}
						}
						OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 1);
						return 1;
					}
			 	    ProjectTD[EditIndex][ETextDrawOutline] -= 1;
					TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~OUTLINE~w~%d", ProjectTD[EditIndex][ETextDrawOutline]);
					ShowInfoDraw(SpeedSTR, 1000);

			 		OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 1);
			 	}
            }
        }
        case EDITMODE_SHADOW:
        {
            switch(key)
            {
                case VK_OEM_PLUS, VK_ADD, VK_UP, VK_RIGHT:
			 	{
					if(moveselectedtds)
					{
						for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
						{
							if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
							{
								ProjectTD[i][ETextDrawShadow] += 1;
								TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
								TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
							}
						}
						ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 0);
						return 1;
					}
			 	    ProjectTD[EditIndex][ETextDrawShadow] += 1;
					TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			 		format(SpeedSTR, 256, "~n~~n~~n~~y~SHADOW~w~%d", ProjectTD[EditIndex][ETextDrawShadow]);
					ShowInfoDraw(SpeedSTR, 1000);

			 		ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 0);
			 	}
			 	case VK_OEM_MINUS, VK_SUBTRACT, VK_DOWN, VK_LEFT:
			 	{
					if(moveselectedtds)
					{
						for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
						{
							if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
							{
								ProjectTD[i][ETextDrawShadow] -= 1;
								TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
								TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
							}
						}
						ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 1);
						return 1;
					}
			 	    ProjectTD[EditIndex][ETextDrawShadow] -= 1;
					TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
					new Speed[32];
			 		format(Speed, 24, "~y~SHADOW~w~%d", ProjectTD[EditIndex][ETextDrawShadow]);
					ShowInfoDraw(Speed, 1000);

			 		ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 1);
			 	}
            }
        }
        case EDITMODE_LETTERSIZE:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(LetterSizeTimer == -1) LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditLetterSizeSpeed == 0.005)
				 	{
				 		EditLetterSizeSpeed = 0.01;
				 		new Speed[24];
				 		format(Speed, 24, "~y~S~w~%.3f", EditLetterSizeSpeed);
						ShowInfoDraw(Speed, 1000);
				 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditLetterSizeSpeed += 0.01;
			 		new Speed[24];
			 		format(Speed, 24, "~y~S~w~%.3f", EditLetterSizeSpeed);
					ShowInfoDraw(Speed, 1000);
			 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditLetterSizeSpeed <= 0.01)
					{
						EditLetterSizeSpeed = 0.005;
						new Speed[24];
				 		format(Speed, 24, "~y~S~r~%.4f", EditLetterSizeSpeed);
						ShowInfoDraw(Speed, 1000);
				 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
				 		return 1;
					}
					EditLetterSizeSpeed -= 0.01;
					new Speed[24];
			 		format(Speed, 24, "~y~S~w~%.3f", EditLetterSizeSpeed);
					ShowInfoDraw(Speed, 1000);
			 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
				}
            }
        }
    }
	return true;
}

TDE_CALLBACK:EditOutline(key)
{
    if(EditMode != EDITMODE_OUTLINE) return 1;
    if(key == 0)
    {
        if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED] || VirtualKeys[31][KEY_PRESSED] || VirtualKeys[30][KEY_PRESSED])
		{
			if(moveselectedtds)
			{
				for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
				{
					if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
					{
						ProjectTD[i][ETextDrawOutline] += 1;
						TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
					}
				}
				OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 0);
				return 1;
			}
		    ProjectTD[EditIndex][ETextDrawOutline] += 1;
			TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "~y~OUTLINE~w~%d", ProjectTD[EditIndex][ETextDrawOutline]);
			ShowInfoDraw(Speed, 1000);
	 		OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 0);
		}
    }
    else if(key == 1)
    {
        if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED] || VirtualKeys[32][KEY_PRESSED] || VirtualKeys[29][KEY_PRESSED])
		{
			if(moveselectedtds)
			{
				for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
				{
					if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
					{
						ProjectTD[i][ETextDrawOutline] -= 1;
						TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
					}
				}
				OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 1);
				return 1;
			}
		    ProjectTD[EditIndex][ETextDrawOutline] -= 1;
			TDE_TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "~y~OUTLINE~w~%d", ProjectTD[EditIndex][ETextDrawOutline]);
			ShowInfoDraw(Speed, 1000);
	 		OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 1);
		}
    }
	return 1;
}

TDE_CALLBACK:EditShadow(key)
{
    if(EditMode != EDITMODE_SHADOW) return 1;
    if(key == 0)
    {
        if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED] || VirtualKeys[31][KEY_PRESSED] || VirtualKeys[30][KEY_PRESSED])
		{
			if(moveselectedtds)
			{
				for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
				{
					if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
					{
						ProjectTD[i][ETextDrawShadow] += 1;
						TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
					}
				}
				ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 0);
				return 1;
			}
		    ProjectTD[EditIndex][ETextDrawShadow] += 1;
			TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "~y~SHADOW~w~%d", ProjectTD[EditIndex][ETextDrawShadow]);
			ShowInfoDraw(Speed, 1000);
	 		ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 0);
		}
    }
    else if(key == 1)
    {
        if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED] || VirtualKeys[32][KEY_PRESSED] || VirtualKeys[29][KEY_PRESSED])
		{
			if(moveselectedtds)
			{
				for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
				{
					if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
					{
						ProjectTD[i][ETextDrawShadow] -= 1;
						TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
					}
				}
				ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 1);
				return 1;
			}
	 		ProjectTD[EditIndex][ETextDrawShadow] -= 1;
			TDE_TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
			TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "~y~SHADOW~w~%d", ProjectTD[EditIndex][ETextDrawShadow]);
			ShowInfoDraw(Speed, 1000);
	 		ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 1);
		}
    }
	return 1;
}

TDE_CALLBACK:EditSizeSpeedCallback(key)
{
    if(EditMode != EDITMODE_SIZE) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
	 		if(EditSizeSpeed == 0.05)
		 	{
		 		EditSizeSpeed = 0.1;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 0);
		 		return 1;
			}
	 		EditSizeSpeed += 0.1;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditSizeSpeed <= 0.1)
			{
				EditSizeSpeed = 0.05;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~r~%.2f", EditSizeSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 1);
		 		return 1;
			}
			EditSizeSpeed -= 0.1;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditSizeSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:EditMovementSpeed(key)
{
    if(EditMode != EDITMODE_POSITION) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
		    if(EditMoveSpeed == 0.05)
		 	{
		 		EditMoveSpeed = 0.1;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 0);
		 		return 1;
			}
	 		EditMoveSpeed += 0.1;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditMoveSpeed <= 0.1)
			{
				EditMoveSpeed = 0.05;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~r~%.2f", EditMoveSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 1);
		 		return 1;
			}
			EditMoveSpeed -= 0.1;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.1f", EditMoveSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:TEditLetterSizeSpeed(key)
{
    if(EditMode != EDITMODE_LETTERSIZE) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
		    if(EditLetterSizeSpeed == 0.005)
		 	{
		 		EditLetterSizeSpeed = 0.01;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.3f", EditLetterSizeSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
		 		return 1;
			}
	 		EditLetterSizeSpeed += 0.01;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.3f", EditLetterSizeSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditLetterSizeSpeed <= 0.01)
			{
				EditLetterSizeSpeed = 0.005;
		 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~r~%.4f", EditLetterSizeSpeed);
				ShowInfoDraw(SpeedSTR, 1000);
		 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
		 		return 1;
			}
			EditLetterSizeSpeed -= 0.01;
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~S~w~%.3f", EditLetterSizeSpeed);
			ShowInfoDraw(SpeedSTR, 1000);
	 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:DeleteTextDrawLetter()
{
    if(EditMode != EDITMODE_TEXT) return 1;
    if(VirtualKeys[52][KEY_PRESSED] || VirtualKeys[37][KEY_PRESSED]) //Delete
	{
    	new len = strlen(ProjectTD[EditIndex][ETextDrawText]);
        if(len == 0) return 1;
        if(ProjectTD[EditIndex][ETextDrawText][len-1] == '~' && ProjectTD[EditIndex][ETextDrawText][len-2] == 'n' && ProjectTD[EditIndex][ETextDrawText][len-3] == '~')
		{
			strdel(ProjectTD[EditIndex][ETextDrawText], len-3, len);
		}
		else strdel(ProjectTD[EditIndex][ETextDrawText], len-1, len);
 		TDE_TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
 		DeleteTimer = SetTimer("DeleteTextDrawLetter", 25, 0);
	}
	return 1;
}

TDE_CALLBACK:LetterSizeTextDrawEDITOR()
{
	if(EditMode != EDITMODE_LETTERSIZE) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawLetterY] -= EditLetterSizeSpeed;
					TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawLetterY] -= EditLetterSizeSpeed;
	    TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~letterX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawLetterY] += EditLetterSizeSpeed;
					TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawLetterY] += EditLetterSizeSpeed;
	    TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~letterX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawLetterX] -= floatdiv(EditLetterSizeSpeed, 10);
					TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
     	ProjectTD[EditIndex][ETextDrawLetterX] -= floatdiv(EditLetterSizeSpeed, 10);
	    TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~letterX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawLetterX] += floatdiv(EditLetterSizeSpeed, 10);
					TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawLetterX] += floatdiv(EditLetterSizeSpeed, 10);
	    TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~letterX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(LetterSizeTimer);
	LetterSizeTimer = -1;
	return 1;
}

TDE_CALLBACK:ReSizeTextDrawEDITOR()
{
	if(EditMode != EDITMODE_SIZE) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					if( (TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]) && ProjectTD[i][ETextDrawLetterX] == 0.0)  )
					{
						ProjectTD[i][ETextDrawLetterY] -= EditSizeSpeed/10;
						TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);

						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						return 1;
					}
					ProjectTD[i][ETextDrawTextY] -= EditSizeSpeed;
					new alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
					switch(alignment)
					{
						case 1, 3: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						case 2: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
					}
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    if( (TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  )
		{
            ProjectTD[EditIndex][ETextDrawLetterY] -= EditSizeSpeed/10;
            TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);

            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
			ShowInfoDraw(SpeedSTR, 1000);
		    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
		    return 1;
		}
		ProjectTD[EditIndex][ETextDrawTextY] -= EditSizeSpeed;
	    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);

 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~sizeY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					if( (TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]) && ProjectTD[i][ETextDrawLetterX] == 0.0)  )
					{
						ProjectTD[i][ETextDrawLetterY] += EditSizeSpeed/10;
						TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);

						TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
						return 1;
					}
					ProjectTD[i][ETextDrawTextY] += EditSizeSpeed;
					new alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
					switch(alignment)
					{
						case 1, 3: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						case 2: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
					}
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    if( (TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  )
		{
            ProjectTD[EditIndex][ETextDrawLetterY] += EditSizeSpeed/10;
            TDE_TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);

            TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
			ShowInfoDraw(SpeedSTR, 1000);
		    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
		    return 1;
		}
	    ProjectTD[EditIndex][ETextDrawTextY] += EditSizeSpeed;
	    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~sizeY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawTextX] -= EditSizeSpeed;
					new alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
					switch(alignment)
					{
						case 1, 3: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						case 2: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
					}
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawTextX] -= EditSizeSpeed;
	    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~sizeY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		if( (TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  ) format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawTextX] += EditSizeSpeed;
					new alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
					switch(alignment)
					{
						case 1, 3: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						case 2: TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
					}
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawTextX] += EditSizeSpeed;
	    new alignment = TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~sizeY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		if( (TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  ) format(SpeedSTR, 256, "~n~~n~~n~~y~sizeX~w~%.4f ~y~letterY~w~%.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
		ShowInfoDraw(SpeedSTR, 1000);
		EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(EditSizeTDTimer);
	EditSizeTDTimer = -1;
	return 1;
}

TDE_CALLBACK:MoveTextDrawEDITOR()
{
	if(EditMode != EDITMODE_POSITION) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawPosY] -= EditMoveSpeed;
					TDE_TextDrawSetPos(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawPosY] -= EditMoveSpeed;
	    TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~posX~w~%.4f ~y~posY~w~%.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawPosY] += EditMoveSpeed;
					TDE_TextDrawSetPos(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY]);
					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawPosY] += EditMoveSpeed;
	    TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~posX~w~%.4f ~y~posY~w~%.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawPosX] -= EditMoveSpeed;
					TDE_TextDrawSetPos(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY]);

					if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]))
					{
						if(TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]) != 2)
						{
							ProjectTD[i][ETextDrawTextX] -= EditMoveSpeed;
							TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						}
					}

					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawPosX] -= EditMoveSpeed;
	    TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);

	    if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
		    if(TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
			{
				ProjectTD[EditIndex][ETextDrawTextX] -= EditMoveSpeed;
		    	TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
			}
		}

	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~posX~w~%.4f ~y~posY~w~%.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
		if(moveselectedtds)
		{
			for(new i = 0; i < MAX_PROJECT_TEXTDRAWS; i ++)
			{
				if(ProjectTD[i][ItsFromTDE] == 1 && SelectedTextDraws[i])
				{
					ProjectTD[i][ETextDrawPosX] += EditMoveSpeed;
					TDE_TextDrawSetPos(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY]);

					if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]))
					{
						if(TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]) != 2)
						{
							ProjectTD[i][ETextDrawTextX] -= EditMoveSpeed;
							TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
						}
					}

					TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
				}
			}
			MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
			return 1;
		}
	    ProjectTD[EditIndex][ETextDrawPosX] += EditMoveSpeed;
	    TDE_TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);

	    if(TDE_TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
		    if(TDE_TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
			{
				ProjectTD[EditIndex][ETextDrawTextX] += EditMoveSpeed;
		    	TDE_TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
			}
		}

	    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
 		format(SpeedSTR, 256, "~n~~n~~n~~y~posX~w~%.4f ~y~posY~w~%.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
		ShowInfoDraw(SpeedSTR, 1000);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(MoveTDTimer);
	MoveTDTimer = -1;
	return 1;
}

stock ShowEditor()
{
	TogglePlayerControllable(ProjectEditor, false);

    Loop(0, sizeof(TDE_Menu))
    {
        switch(c)
        {
            case 0:
			{
                TDE_TextDrawColor(TDE_Menu[c], 0x000000FF);
        		TDE_TextDrawSetSelectable(TDE_Menu[c], false);
            }
            case 2:
            {
        		TDE_TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
        		TDE_TextDrawSetSelectable(TDE_Menu[c], true);
			}
			default:
			{
				TDE_TextDrawColor(TDE_Menu[c], 0x888888FF);
 				TDE_TextDrawSetSelectable(TDE_Menu[c], false);
			}
		}
        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
    }
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
    TDE_TextDrawShowForPlayer(ProjectEditor, TD_Status);
	SelectTextDraw(ProjectEditor, -1);
	return true;
}

stock ShowEditorEx()
{


    Loop(0, sizeof(TDE_Menu))
    {
        switch(c)
        {
            case 0:
			{
                TDE_TextDrawColor(TDE_Menu[c], 0x000000FF);
        		TDE_TextDrawSetSelectable(TDE_Menu[c], false);
            }
			default:
			{
				TDE_TextDrawColor(TDE_Menu[c], 0x888888FF);
 				TDE_TextDrawSetSelectable(TDE_Menu[c], false);
			}
		}
        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
    }
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
    TDE_TextDrawShowForPlayer(ProjectEditor, TD_Status);
	SelectTextDraw(ProjectEditor, -1);
	return true;
}

stock CreateMenuTextDraws()
{
    TDE_TextDrawCreate(TDE_Menu[0], 0.0, OffsetZ - 2.0, "LD_SPAC:white");
	TextdrawSettings(TDE_Menu[0], Float:{0.5, 1.0, 640.0, 37.0}, {0,0x000000FF,0,0,0,0,255,4,1,0});

	new Float:OffsetX = 0.01;
	TDE_TextDrawCreate(TDE_Menu[1], OffsetX, OffsetZ, "TDE:btn_manage"); OffsetX += 32.0;
	TDE_TextDrawCreate(TDE_Menu[4], OffsetX, OffsetZ, "TDE:btn_export"); OffsetX += 32.0;
	TDE_TextDrawCreate(TDE_Menu[2], OffsetX, OffsetZ, "TDE:btn_new"); OffsetX += 32.0;
	TDE_TextDrawCreate(TDE_Menu[3], OffsetX, OffsetZ, "TDE:btn_delete"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[8], OffsetX, OffsetZ, "TDE:btn_duplicate"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[24], OffsetX, OffsetZ, "TDE:btn_font0");
    TDE_TextDrawCreate(TDE_Menu[25], OffsetX, OffsetZ, "TDE:btn_font1");
    TDE_TextDrawCreate(TDE_Menu[26], OffsetX, OffsetZ, "TDE:btn_font2");
    TDE_TextDrawCreate(TDE_Menu[27], OffsetX, OffsetZ, "TDE:btn_font3");
    TDE_TextDrawCreate(TDE_Menu[12], OffsetX, OffsetZ, "TDE:btn_image");
    TDE_TextDrawCreate(TDE_Menu[13], OffsetX, OffsetZ, "TDE:btn_previews"); OffsetX += 32.0;
	TDE_TextDrawCreate(TDE_Menu[9], OffsetX, OffsetZ, "TDE:btn_pos"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[10], OffsetX, OffsetZ, "TDE:btn_size"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[11], OffsetX, OffsetZ, "TDE:btn_text");
	TDE_TextDrawCreate(TDE_Menu[35], OffsetX, OffsetZ, "TDE:btn_modelid"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[14], OffsetX, OffsetZ, "TDE:btn_color"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[15], OffsetX, OffsetZ, "TDE:btn_bgcolor"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[32], OffsetX, OffsetZ, "TDE:btn_boxcolor"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[16], OffsetX, OffsetZ, "TDE:btn_lettersize"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[17], OffsetX, OffsetZ, "TDE:btn_outline"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[18], OffsetX, OffsetZ, "TDE:btn_shadow"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[19], OffsetX, OffsetZ, "TDE:btn_useboxno");
    TDE_TextDrawCreate(TDE_Menu[20], OffsetX, OffsetZ, "TDE:btn_useboxyes");
	TDE_TextDrawCreate(TDE_Menu[34], OffsetX, OffsetZ, "TDE:btn_modeloptions"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[21], OffsetX, OffsetZ, "TDE:btn_alignmentleft");
    TDE_TextDrawCreate(TDE_Menu[22], OffsetX, OffsetZ, "TDE:btn_alignmentcenter");
    TDE_TextDrawCreate(TDE_Menu[23], OffsetX, OffsetZ, "TDE:btn_alignmentright"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[5], OffsetX, OffsetZ, "TDE:btn_global");
	TDE_TextDrawCreate(TDE_Menu[33], OffsetX, OffsetZ, "TDE:btn_player"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[28], OffsetX, OffsetZ, "TDE:btn_selectableno");
    TDE_TextDrawCreate(TDE_Menu[29], OffsetX, OffsetZ, "TDE:btn_selectableyes"); OffsetX += 32.0;
    TDE_TextDrawCreate(TDE_Menu[30], OffsetX, OffsetZ, "TDE:btn_proportionno");
    TDE_TextDrawCreate(TDE_Menu[31], OffsetX, OffsetZ, "TDE:btn_proportionyes"); OffsetX += 32.0;
    Loop(1, sizeof TDE_Menu)
	{
	    if(c == 6 || c == 7) continue;
		TextdrawSettings(TDE_Menu[c], Float:{0.5, 1.0, 32.0, 32.0}, {0,0xDDDDDDFF,0,0,0,0,0,4,1,0});
	}

	TDE_TextDrawCreate(TD_Status, 2.0, 404.86, "EDITMODE_NONE");
	TDE_TextDrawLetterSize(TD_Status, 0.179665, 0.857481);
	TDE_TextDrawAlignment(TD_Status, 1);
	TDE_TextDrawColor(TD_Status, -186);
	TDE_TextDrawSetShadow(TD_Status, 0);
	TDE_TextDrawSetOutline(TD_Status, 0);
	TDE_TextDrawBackgroundColor(TD_Status, 255);
	TDE_TextDrawFont(TD_Status, 1);
	TDE_TextDrawSetProportional(TD_Status, 1);

	TDE_TextDrawCreate(TDEditor_Helper[0], 322.000000, -6.000000, "_");
	TDE_TextDrawAlignment(TDEditor_Helper[0], 2);
	TDE_TextDrawBackgroundColor(TDEditor_Helper[0], 255);
	TDE_TextDrawFont(TDEditor_Helper[0], 1);
	TDE_TextDrawLetterSize(TDEditor_Helper[0], 0.000000, 24.000003);
	TDE_TextDrawColor(TDEditor_Helper[0], -1);
	TDE_TextDrawSetOutline(TDEditor_Helper[0], 0);
	TDE_TextDrawSetProportional(TDEditor_Helper[0], 1);
	TDE_TextDrawSetShadow(TDEditor_Helper[0], 1);
	TDE_TextDrawUseBox(TDEditor_Helper[0], 1);
	TDE_TextDrawBoxColor(TDEditor_Helper[0], -16776961);
	TDE_TextDrawTextSize(TDEditor_Helper[0], 0.000000, -2.000000);
	TDE_TextDrawSetSelectable(TDEditor_Helper[0], 0);

	TDE_TextDrawCreate(TDEditor_Helper[1], 324.000000, 150.000000, "_");
	TDE_TextDrawBackgroundColor(TDEditor_Helper[1], 255);
	TDE_TextDrawFont(TDEditor_Helper[1], 1);
	TDE_TextDrawLetterSize(TDEditor_Helper[1], 0.00000, -0.321204);
	TDE_TextDrawColor(TDEditor_Helper[1], -1);
	TDE_TextDrawSetOutline(TDEditor_Helper[1], 0);
	TDE_TextDrawSetProportional(TDEditor_Helper[1], 1);
	TDE_TextDrawSetShadow(TDEditor_Helper[1], 1);
	TDE_TextDrawUseBox(TDEditor_Helper[1], 1);
	TDE_TextDrawBoxColor(TDEditor_Helper[1], -16776961);
	TDE_TextDrawTextSize(TDEditor_Helper[1], -30.000000, 0.000000);
	TDE_TextDrawSetSelectable(TDEditor_Helper[1], 0);

	TDE_TextDrawCreate(TDELOGO, 215.000091, 182.933395, "TDE:TDELogo");
	TDE_TextDrawLetterSize(TDELOGO, 0.000000, 0.000000);
	TDE_TextDrawTextSize(TDELOGO, 190.0, 50.0);
	TDE_TextDrawAlignment(TDELOGO, 1);
	TDE_TextDrawColor(TDELOGO, -1);
	TDE_TextDrawSetShadow(TDELOGO, 0);
	TDE_TextDrawSetOutline(TDELOGO, 0);
	TDE_TextDrawFont(TDELOGO, 4);
	TDE_TextDrawSetSelectable(TDELOGO, 1);

    return 1;
}

stock DestroyMenuTextDraws()
{
    Loop(0, sizeof TDE_Menu)
	{
		TDE_TextDrawDestroy(TDE_Menu[c]);
		TDE_Menu[c] = Text:INVALID_TEXT_DRAW;
	}
	TDE_TextDrawDestroy(TD_Status);
	TD_Status = Text:INVALID_TEXT_DRAW;
	TDE_TextDrawDestroy(TDEditor_Helper[0]);
	TDEditor_Helper[0] = Text:INVALID_TEXT_DRAW;
	TDE_TextDrawDestroy(TDEditor_Helper[1]);
	TDEditor_Helper[1] = Text:INVALID_TEXT_DRAW;
	TDE_TextDrawDestroy(TDELOGO);
	TDELOGO = Text:INVALID_TEXT_DRAW;
	return 1;
}

stock TextdrawSettings(Text:textid, Float:Sizes[4], Options[10]) //By iPleomax
{
	TDE_TextDrawLetterSize		(textid, Sizes[0], Sizes[1]);
	TDE_TextDrawTextSize    	(textid, Sizes[2], Sizes[3]);
	TDE_TextDrawAlignment   	(textid, Options[0] ? Options[0] : 1);
	TDE_TextDrawColor   		(textid, Options[1]);
	TDE_TextDrawUseBox   		(textid, Options[2]);
	TDE_TextDrawBoxColor   		(textid, Options[3]);
	TDE_TextDrawSetShadow   	(textid, Options[4]);
	TDE_TextDrawSetOutline  	(textid, Options[5]);
	TDE_TextDrawBackgroundColor (textid, Options[6]);
	TDE_TextDrawFont   			(textid, Options[7]);
	TDE_TextDrawSetProportional	(textid, Options[8]);
	TDE_TextDrawSetSelectable   (textid, Options[9]);
}

stock GetAvailableIndex()
{
	for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == -1)
	    {
			if(ProjectTD[i][ETextDrawID] == Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}
	return INVALID_INDEX_ID;
}

stock KeyToString(key)
{
	new LETTER[4] = "";
	if((GetKeyState(VK_CAPSLOCK) & 0x0001) != 0)
	{
	    if(VirtualKeys[41][KEY_PRESSED]) //Shift
	    {
	        switch(key)
	        {
	        	case VK_KEY_A: LETTER = "a";//41
				case VK_KEY_B: LETTER = "b";//42
				case VK_KEY_C: LETTER = "c";//43
				case VK_KEY_D: LETTER = "d";//44
				case VK_KEY_E: LETTER = "e";//45
				case VK_KEY_F: LETTER = "f";//46
				case VK_KEY_G: LETTER = "g";//47
				case VK_KEY_H: LETTER = "h";//48
				case VK_KEY_I: LETTER = "i";//49
				case VK_KEY_J: LETTER = "j";//4A
				case VK_KEY_K: LETTER = "k";//4B
				case VK_KEY_L: LETTER = "l";//4C
				case VK_KEY_M: LETTER = "m";//4D
				case VK_KEY_N: LETTER = "n";//4E
				case VK_KEY_O: LETTER = "o";//4F
				case VK_KEY_P: LETTER = "p";//50
				case VK_KEY_Q: LETTER = "q";//51
				case VK_KEY_R: LETTER = "r";//52
				case VK_KEY_S: LETTER = "s";//53
				case VK_KEY_T: LETTER = "t";//54
				case VK_KEY_U: LETTER = "u";//55
				case VK_KEY_V: LETTER = "v";//56
				case VK_KEY_W: LETTER = "w";//57
				case VK_KEY_X: LETTER = "x";//58
				case VK_KEY_Y: LETTER = "y";//59
				case VK_KEY_Z: LETTER = "z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "=";//30
				case VK_KEYB1: LETTER = "!";//!
				case VK_KEYB2: LETTER = "\"";//32
				//case VK_KEYB3: LETTER = "·";//33
				case VK_KEYB4: LETTER = "$";//34
				case VK_KEYB5: LETTER = "%";//35
				case VK_KEYB6: LETTER = "&";//36
				case VK_KEYB7: LETTER = "/";//37
				case VK_KEYB8: LETTER = "(";//38
				case VK_KEYB9: LETTER = ")";//39
				case VK_OEM_PLUS: LETTER = "*";
				case VK_OEM_COMMA: LETTER = ";";
				case VK_OEM_MINUS: LETTER = "_";
				case VK_OEM_PERIOD: LETTER = ":";
				case VK_OEM_2: LETTER = "?";
				case VK_OEM_4: LETTER = "?";
				//case VK_OEM_5: LETTER = "ª";
				case VK_OEM_6: LETTER = "[";
				case VK_OEM_102: LETTER = ">";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";
	        }
	    }
	    else
	    {
	        switch(key)
	        {
		        case VK_KEY_A: LETTER = "A";//41
				case VK_KEY_B: LETTER = "B";//42
				case VK_KEY_C: LETTER = "C";//43
				case VK_KEY_D: LETTER = "D";//44
				case VK_KEY_E: LETTER = "E";//45
				case VK_KEY_F: LETTER = "F";//46
				case VK_KEY_G: LETTER = "G";//47
				case VK_KEY_H: LETTER = "H";//48
				case VK_KEY_I: LETTER = "I";//49
				case VK_KEY_J: LETTER = "J";//4A
				case VK_KEY_K: LETTER = "K";//4B
				case VK_KEY_L: LETTER = "L";//4C
				case VK_KEY_M: LETTER = "M";//4D
				case VK_KEY_N: LETTER = "N";//4E
				case VK_KEY_O: LETTER = "O";//4F
				case VK_KEY_P: LETTER = "P";//50
				case VK_KEY_Q: LETTER = "Q";//51
				case VK_KEY_R: LETTER = "R";//52
				case VK_KEY_S: LETTER = "S";//53
				case VK_KEY_T: LETTER = "T";//54
				case VK_KEY_U: LETTER = "U";//55
				case VK_KEY_V: LETTER = "V";//56
				case VK_KEY_W: LETTER = "W";//57
				case VK_KEY_X: LETTER = "X";//58
				case VK_KEY_Y: LETTER = "Y";//59
				case VK_KEY_Z: LETTER = "Z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "0";//30
				case VK_KEYB1: LETTER = "1";//31
				case VK_KEYB2: LETTER = "2";//32
				case VK_KEYB3: LETTER = "3";//33
				case VK_KEYB4: LETTER = "4";//34
				case VK_KEYB5: LETTER = "5";//35
				case VK_KEYB6: LETTER = "6";//36
				case VK_KEYB7: LETTER = "7";//37
				case VK_KEYB8: LETTER = "8";//38
				case VK_KEYB9: LETTER = "9";//39
				case VK_OEM_PLUS: LETTER = "+";
				case VK_OEM_COMMA: LETTER = ",";
				case VK_OEM_MINUS: LETTER = "-";
				case VK_OEM_PERIOD: LETTER = ".";
				case VK_OEM_2: LETTER = "]";
				case VK_OEM_4: LETTER = "'";
				case VK_OEM_5: LETTER = "|";
				case VK_OEM_6: LETTER = "¡";
				case VK_OEM_102: LETTER = "<";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";


			}
	    }
	}
	else
	{
 		if(VirtualKeys[41][KEY_PRESSED]) //Shift
	    {
	        switch(key)
	        {
				case VK_KEY_A: LETTER = "A";//41
				case VK_KEY_B: LETTER = "B";//42
				case VK_KEY_C: LETTER = "C";//43
				case VK_KEY_D: LETTER = "D";//44
				case VK_KEY_E: LETTER = "E";//45
				case VK_KEY_F: LETTER = "F";//46
				case VK_KEY_G: LETTER = "G";//47
				case VK_KEY_H: LETTER = "H";//48
				case VK_KEY_I: LETTER = "I";//49
				case VK_KEY_J: LETTER = "J";//4A
				case VK_KEY_K: LETTER = "K";//4B
				case VK_KEY_L: LETTER = "L";//4C
				case VK_KEY_M: LETTER = "M";//4D
				case VK_KEY_N: LETTER = "N";//4E
				case VK_KEY_O: LETTER = "O";//4F
				case VK_KEY_P: LETTER = "P";//50
				case VK_KEY_Q: LETTER = "Q";//51
				case VK_KEY_R: LETTER = "R";//52
				case VK_KEY_S: LETTER = "S";//53
				case VK_KEY_T: LETTER = "T";//54
				case VK_KEY_U: LETTER = "U";//55
				case VK_KEY_V: LETTER = "V";//56
				case VK_KEY_W: LETTER = "W";//57
				case VK_KEY_X: LETTER = "X";//58
				case VK_KEY_Y: LETTER = "Y";//59
				case VK_KEY_Z: LETTER = "Z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "=";//30
				case VK_KEYB1: LETTER = "!";//!
				case VK_KEYB2: LETTER = "\"";//32
				//case VK_KEYB3: LETTER = "·";//33
				case VK_KEYB4: LETTER = "$";//34
				case VK_KEYB5: LETTER = "%";//35
				case VK_KEYB6: LETTER = "&";//36
				case VK_KEYB7: LETTER = "/";//37
				case VK_KEYB8: LETTER = "(";//38
				case VK_KEYB9: LETTER = ")";//39
				case VK_OEM_PLUS: LETTER = "*";
				case VK_OEM_COMMA: LETTER = ";";
				case VK_OEM_MINUS: LETTER = "_";
				case VK_OEM_PERIOD: LETTER = ":";
				case VK_OEM_2: LETTER = "?";
				case VK_OEM_4: LETTER = "?";
				//case VK_OEM_5: LETTER = "ª";
				case VK_OEM_6: LETTER = "[";
				case VK_OEM_102: LETTER = ">";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";
	        }
	    }
	    else
	    {
	        switch(key)
	        {
		        case VK_KEY_A: LETTER = "a";//41
				case VK_KEY_B: LETTER = "b";//42
				case VK_KEY_C: LETTER = "c";//43
				case VK_KEY_D: LETTER = "d";//44
				case VK_KEY_E: LETTER = "e";//45
				case VK_KEY_F: LETTER = "f";//46
				case VK_KEY_G: LETTER = "g";//47
				case VK_KEY_H: LETTER = "h";//48
				case VK_KEY_I: LETTER = "i";//49
				case VK_KEY_J: LETTER = "j";//4A
				case VK_KEY_K: LETTER = "k";//4B
				case VK_KEY_L: LETTER = "l";//4C
				case VK_KEY_M: LETTER = "m";//4D
				case VK_KEY_N: LETTER = "n";//4E
				case VK_KEY_O: LETTER = "o";//4F
				case VK_KEY_P: LETTER = "p";//50
				case VK_KEY_Q: LETTER = "q";//51
				case VK_KEY_R: LETTER = "r";//52
				case VK_KEY_S: LETTER = "s";//53
				case VK_KEY_T: LETTER = "t";//54
				case VK_KEY_U: LETTER = "u";//55
				case VK_KEY_V: LETTER = "v";//56
				case VK_KEY_W: LETTER = "w";//57
				case VK_KEY_X: LETTER = "x";//58
				case VK_KEY_Y: LETTER = "y";//59
				case VK_KEY_Z: LETTER = "z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "0";//30
				case VK_KEYB1: LETTER = "1";//31
				case VK_KEYB2: LETTER = "2";//32
				case VK_KEYB3: LETTER = "3";//33
				case VK_KEYB4: LETTER = "4";//34
				case VK_KEYB5: LETTER = "5";//35
				case VK_KEYB6: LETTER = "6";//36
				case VK_KEYB7: LETTER = "7";//37
				case VK_KEYB8: LETTER = "8";//38
				case VK_KEYB9: LETTER = "9";//39
				case VK_OEM_PLUS: LETTER = "+";
				case VK_OEM_COMMA: LETTER = ",";
				case VK_OEM_MINUS: LETTER = "-";
				case VK_OEM_PERIOD: LETTER = ".";
				case VK_OEM_2: LETTER = "]";
				case VK_OEM_4: LETTER = "'";
				case VK_OEM_5: LETTER = "|";
				case VK_OEM_6: LETTER = "¡";
				case VK_OEM_102: LETTER = "<";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";


			}
	    }
	}
	return LETTER;
}

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
    r = (colour >> 24) & 0xFF;
    g = (colour >> 16) & 0xFF;
    b = (colour >> 8) & 0xFF;
    a = colour & 0xFF;
}

stock RGBAToHex(r, g, b, a) //By Betamaster
{
    return (r<<24 | g<<16 | b<<8 | a);
}

stock RemoveTextDrawTDE(Index)
{
	format(ProjectTD[Index][ETextDrawText], 800, "");
	ProjectTD[Index][ETextDrawPosX] = 0.0;
	ProjectTD[Index][ETextDrawPosY] = 0.0;
	ProjectTD[Index][ETextDrawLetterX] = 0.0;
	ProjectTD[Index][ETextDrawLetterY] = 0.0;
	ProjectTD[Index][ETextDrawTextX] = 0.0;
	ProjectTD[Index][ETextDrawTextY] = 0.0;
	ProjectTD[Index][ETextDrawOutline] = 0;
	ProjectTD[Index][ETextDrawShadow] = 0;
	ProjectTD[Index][ETextDrawModelid] = 0;
	ProjectTD[Index][ETextDrawRotX] = 0.0;
	ProjectTD[Index][ETextDrawRotY] = 0.0;
	ProjectTD[Index][ETextDrawRotZ] = 0.0;
	ProjectTD[Index][ETextDrawZoom] = 0.0;
	ProjectTD[Index][ETextDrawType] = 0;
	ProjectTD[Index][ETextDrawSelectable] = 0;
	ProjectTD[Index][ETextDrawColor] = 0;
	ProjectTD[Index][ETextDrawBGColor] = 0;
	ProjectTD[Index][ETextDrawBoxColor] = 0;
	ProjectTD[Index][ETextDrawVehCol1] = 0;
	ProjectTD[Index][ETextDrawVehCol2] = 0;
	TDE_TextDrawDestroy(ProjectTD[Index][ETextDrawID]);
	ProjectTD[Index][ItsFromTDE] = -1;
	ProjectTD[Index][ETextDrawID] = Text:INVALID_TEXT_DRAW;

	new NewIndex = GetAvailableIndexBack(EditIndex);
	EditIndex = NewIndex;
	if(EditIndex == -1)
	{
	    Loop(1, sizeof(TDE_Menu))
	    {
			TDE_TextDrawColor(TDE_Menu[c], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[c], false);
	        TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
	    }
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
	    TDE_TextDrawColor(TDE_Menu[2], 0xDDDDDDFF);
	    TDE_TextDrawSetSelectable(TDE_Menu[2], true);
	    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[2]);
	    TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
   		EditMode = EDITMODE_NONE;
	}
	else
	{
	    new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}Now you are editing TextDraw {e2b960}#%d.", EditIndex);
        SendClientMessage(ProjectEditor, -1, string);
        UpdateIcons(EditIndex);

        if(EditMode == EDITMODE_MODELS)
        {
            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
	}
	return 1;
}

stock RemoveTextDrawTDEOnly(Index)
{
	format(ProjectTD[Index][ETextDrawText], 800, "");
	ProjectTD[Index][ETextDrawPosX] = 0.0;
	ProjectTD[Index][ETextDrawPosY] = 0.0;
	ProjectTD[Index][ETextDrawLetterX] = 0.0;
	ProjectTD[Index][ETextDrawLetterY] = 0.0;
	ProjectTD[Index][ETextDrawTextX] = 0.0;
	ProjectTD[Index][ETextDrawTextY] = 0.0;
	ProjectTD[Index][ETextDrawOutline] = 0;
	ProjectTD[Index][ETextDrawShadow] = 0;
	ProjectTD[Index][ETextDrawModelid] = 0;
	ProjectTD[Index][ETextDrawRotX] = 0.0;
	ProjectTD[Index][ETextDrawRotY] = 0.0;
	ProjectTD[Index][ETextDrawRotZ] = 0.0;
	ProjectTD[Index][ETextDrawZoom] = 0.0;
	ProjectTD[Index][ETextDrawType] = 0;
	ProjectTD[Index][ETextDrawSelectable] = 0;
	ProjectTD[Index][ETextDrawColor] = 0;
	ProjectTD[Index][ETextDrawBGColor] = 0;
	ProjectTD[Index][ETextDrawBoxColor] = 0;
	ProjectTD[Index][ETextDrawVehCol1] = 0;
	ProjectTD[Index][ETextDrawVehCol2] = 0;
	TDE_TextDrawDestroy(ProjectTD[Index][ETextDrawID]);
	ProjectTD[Index][ItsFromTDE] = -1;
	ProjectTD[Index][ETextDrawID] = Text:INVALID_TEXT_DRAW;
	return 1;
}

stock GetAvailableIndexBack(start)
{
	for (new i = start; i != -1; i--)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}

	for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}
	return INVALID_INDEX_ID;
}

stock HexToInt(string[])//DracoBlue
{
   if (string[0] == 0) return 0;
   new i, cur=1, res = 0;
   for (i=strlen(string);i>0;i--) {
     if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
     cur=cur*16;
   }
   return res;
}

stock RGB( red, green, blue, alpha )
{
	return (red * 16777216) + (green * 65536) + (blue * 256) + alpha;
}

stock ShowManage(playerid)
{
	new d, c, dialog[310], str[31];
    for (d = PageStart; d < MAX_PROJECT_TEXTDRAWS; d++)
	{
	    if(ProjectTD[d][ItsFromTDE] == 1)
	    {
			BackManageDialog[c] = 0;
			c ++;
			if(c == 11)
			{
				if(PageStart >= 10)
			    {
					format(str, 30, ">>\n");
					strcat(dialog, str);
				}
				else
				{
				    format(str, 30, ">>");
				    strcat(dialog, str);
				}
				break;
			}
			if(TDE_TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
			else format(str, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);

			if(strlen(str) >= 30)
			{
				strdel(str, 28, 30);
				strcat(str, "\n");
			}
			strcat(dialog, str);
		}
	}
	if(PageStart >= 10)
	{
	    BackManageDialog[c] = 1;
		format(str, 30, "<<");
		strcat(dialog, str);
	}
	ShowPlayerDialog(playerid, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog, ">>", "X");
	IsPSel = false;
	return 1;
}

stock ShowSelectTDManage(playerid)
{
	new d, c, dialog[310], str[31];
    for (d = PageStart; d < MAX_PROJECT_TEXTDRAWS; d++)
	{
	    if(ProjectTD[d][ItsFromTDE] == 1)
	    {
			BackManageDialog[c] = 0;
			c ++;
			if(c == 11)
			{
				if(PageStart >= 10)
			    {
					format(str, 30, ">>\n");
					strcat(dialog, str);
				}
				else
				{
				    format(str, 30, ">>");
				    strcat(dialog, str);
				}
				break;
			}
			if(TDE_TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5)
			{
				if(SelectedTextDraws[d]) format(str, 31, "{33FF00}(%i)ModelPreview: %d\n", d, ProjectTD[d][ETextDrawModelid]);
				else format(str, 31, "{CCCCCC}(%i)ModelPreview: %d\n", d, ProjectTD[d][ETextDrawModelid]);
			}
			else
			{
				if(SelectedTextDraws[d]) format(str, 31, "{33FF00}(%i)%s\n", d, ProjectTD[d][ETextDrawText]);
				else format(str, 31, "{CCCCCC}(%i)%s\n", d, ProjectTD[d][ETextDrawText]);
			}

			if(strlen(str) >= 30)
			{
				strdel(str, 28, 30);
				strcat(str, "\n");
			}
			strcat(dialog, str);
		}
	}
	if(PageStart >= 10)
	{
	    BackManageDialog[c] = 1;
		format(str, 30, "<<");
		strcat(dialog, str);
	}
	ShowPlayerDialog(playerid, DIALOG_SELECTTDS, DIALOG_STYLE_LIST, "TDEditor - Select TEXTDRAWS", dialog, ">>", "X");
	IsPSel = false;
	return 1;
}

stock DuplicateTextDraw(Index, ToIndex)
{
	format(ProjectTD[ToIndex][ETextDrawText], 800, "%s", ProjectTD[Index][ETextDrawText]);
	ProjectTD[ToIndex][ETextDrawPosX] = ProjectTD[Index][ETextDrawPosX];
	ProjectTD[ToIndex][ETextDrawPosY] = ProjectTD[Index][ETextDrawPosY];
	ProjectTD[ToIndex][ETextDrawLetterX] = ProjectTD[Index][ETextDrawLetterX];
	ProjectTD[ToIndex][ETextDrawLetterY] = ProjectTD[Index][ETextDrawLetterY];
	ProjectTD[ToIndex][ETextDrawTextX] = ProjectTD[Index][ETextDrawTextX];
	ProjectTD[ToIndex][ETextDrawTextY] = ProjectTD[Index][ETextDrawTextY];
	ProjectTD[ToIndex][ETextDrawOutline] = ProjectTD[Index][ETextDrawOutline];
	ProjectTD[ToIndex][ETextDrawShadow] = ProjectTD[Index][ETextDrawShadow];
	ProjectTD[ToIndex][ETextDrawModelid] = ProjectTD[Index][ETextDrawModelid];
	ProjectTD[ToIndex][ETextDrawRotX] = ProjectTD[Index][ETextDrawRotX];
	ProjectTD[ToIndex][ETextDrawRotY] = ProjectTD[Index][ETextDrawRotY];
	ProjectTD[ToIndex][ETextDrawRotZ] = ProjectTD[Index][ETextDrawRotZ];
	ProjectTD[ToIndex][ETextDrawZoom] = ProjectTD[Index][ETextDrawZoom];
	ProjectTD[ToIndex][ETextDrawType] = ProjectTD[Index][ETextDrawType];
	ProjectTD[ToIndex][ETextDrawSelectable] = ProjectTD[Index][ETextDrawSelectable];
	ProjectTD[ToIndex][ETextDrawColor] = ProjectTD[Index][ETextDrawColor];
	ProjectTD[ToIndex][ETextDrawBGColor] = ProjectTD[Index][ETextDrawBGColor];
	ProjectTD[ToIndex][ETextDrawBoxColor] = ProjectTD[Index][ETextDrawBoxColor];
	ProjectTD[ToIndex][ETextDrawVehCol1] = ProjectTD[Index][ETextDrawVehCol1];
	ProjectTD[ToIndex][ETextDrawVehCol2] = ProjectTD[Index][ETextDrawVehCol2];
	TDE_TextDrawGetFontSize(ProjectTD[Index][ETextDrawID], ProjectTD[ToIndex][ETextDrawLetterX], ProjectTD[ToIndex][ETextDrawLetterY]);
	new alignment = TDE_TextDrawGetAlignment(ProjectTD[Index][ETextDrawID]);
	new usebox = TDE_TextDrawIsBox(ProjectTD[Index][ETextDrawID]);
	new font = TDE_TextDrawGetFont(ProjectTD[Index][ETextDrawID]);
	new proportional = TDE_TextDrawIsProportional(ProjectTD[Index][ETextDrawID]);
		
	TDE_TextDrawCreate(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawPosX], ProjectTD[ToIndex][ETextDrawPosY], ProjectTD[ToIndex][ETextDrawText]);
	TDE_TextDrawLetterSize(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawLetterX], ProjectTD[ToIndex][ETextDrawLetterY]);
	TDE_TextDrawAlignment(ProjectTD[ToIndex][ETextDrawID], alignment);
	TDE_TextDrawColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawColor]);
	TDE_TextDrawUseBox(ProjectTD[ToIndex][ETextDrawID], usebox);
	if(alignment == 2) TDE_TextDrawTextSize(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawTextY], ProjectTD[ToIndex][ETextDrawTextX]);
	else TDE_TextDrawTextSize(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawTextX], ProjectTD[ToIndex][ETextDrawTextY]);
	TDE_TextDrawBoxColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawBoxColor]);
	TDE_TextDrawSetShadow(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawShadow]);
	TDE_TextDrawSetOutline(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawOutline]);
	TDE_TextDrawBackgroundColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawBGColor]);
	TDE_TextDrawFont(ProjectTD[ToIndex][ETextDrawID], font);
	TDE_TextDrawSetProportional(ProjectTD[ToIndex][ETextDrawID], proportional);

	if(font == 5)
 	{
 	    TDE_TextDrawSetPreviewModel(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawModelid]);
		TDE_TextDrawSetPreviewRot(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawRotX], ProjectTD[ToIndex][ETextDrawRotY], ProjectTD[ToIndex][ETextDrawRotZ], ProjectTD[ToIndex][ETextDrawZoom]);
		if(IsVehicle(ProjectTD[ToIndex][ETextDrawModelid])) TDE_TextDrawSetPreviewVehCol(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawVehCol1], ProjectTD[ToIndex][ETextDrawVehCol2]);
 	}
 	else
 	{
 	    if(EditMode == EDITMODE_MODELS)
        {
            TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
  	}
	TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[ToIndex][ETextDrawID]);
	ProjectTD[ToIndex][ItsFromTDE] = ProjectTD[Index][ItsFromTDE];
	return 1;
}

stock UpdateIcons(Index)
{
    switch(TDE_TextDrawGetFont(ProjectTD[Index][ETextDrawID]))
    {
        case 0:
        {
            TDE_TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[24]);
        }
        case 1:
        {
            TDE_TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

            TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[25]);
        }
        case 2:
        {
            TDE_TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[26]);
        }
        case 3:
        {
			TDE_TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[27]);
        }
        case 4:
        {
			TDE_TextDrawColor(TDE_Menu[12], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);

        }
        case 5:
        {
            TDE_TextDrawColor(TDE_Menu[12], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[12], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TDE_TextDrawSetSelectable(TDE_Menu[15], true);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TDE_TextDrawColor(TDE_Menu[32], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[32], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TDE_TextDrawColor(TDE_Menu[16], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[16], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TDE_TextDrawColor(TDE_Menu[17], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[17], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TDE_TextDrawColor(TDE_Menu[18], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[18], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TDE_TextDrawColor(TDE_Menu[19], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[19], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TDE_TextDrawColor(TDE_Menu[20], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[20], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TDE_TextDrawColor(TDE_Menu[34], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[34], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TDE_TextDrawColor(TDE_Menu[21], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[21], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TDE_TextDrawColor(TDE_Menu[22], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[22], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TDE_TextDrawColor(TDE_Menu[23], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[23], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TDE_TextDrawColor(TDE_Menu[30], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[30], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TDE_TextDrawColor(TDE_Menu[31], 0x888888FF);
			TDE_TextDrawSetSelectable(TDE_Menu[31], false);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);

			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[13]);
			TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[11]);
			TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[35]);
        }
    }

    if(TDE_TextDrawIsBox(ProjectTD[Index][ETextDrawID]))
	{
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[34]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
	}
	else
	{
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[34]);
	    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
	}



    switch(TDE_TextDrawGetAlignment(ProjectTD[Index][ETextDrawID]))
    {
    	case 1:
		{
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
		}
    	case 2:
    	{
    	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
    	}
    	case 3:
    	{
    	    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
    	}
	}

	switch(ProjectTD[Index][ETextDrawType])
	{
	    case 0:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[5]);
	    }
	    case 1:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[33]);
	    }
	}

	switch(ProjectTD[Index][ETextDrawSelectable])
	{
	    case 0:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[28]);
	    }
	    case 1:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[29]);
	    }
	}

	switch(TDE_TextDrawIsProportional(ProjectTD[Index][ETextDrawID]))
	{
	    case 0:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
	    }
	    case 1:
	    {
	        TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
		    TDE_TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
		    TDE_TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
	    }
	}
    return 1;
}

stock IsVehicle(modelid)
{
	if(modelid >= 400 && modelid <= 611) return true;
	return false;
}


stock SaveProject()
{
	if(!strlen(ProjectFile)) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Load the project first.");
    if(fexist(ProjectFile)) fremove(ProjectFile);
	Handler = fopen(ProjectFile, io_append);
    if(!Handler) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldn't save the project.");

	new alignment, usebox, font, proportional;
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {

            alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
            usebox = TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]);
            font = TDE_TextDrawGetFont(ProjectTD[i][ETextDrawID]);
            proportional = TDE_TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
		    format(Pro_Str, sizeof(Pro_Str),
			"%f|%f|%f|%f|%f|%f|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%s|%d|%f|%f|%f|%f|%d|%d\r\n",
		    ProjectTD[i][ETextDrawPosX], 				ProjectTD[i][ETextDrawPosY],
			ProjectTD[i][ETextDrawLetterX], 			ProjectTD[i][ETextDrawLetterY],
			ProjectTD[i][ETextDrawTextX], 				ProjectTD[i][ETextDrawTextY],
			alignment, 									ProjectTD[i][ETextDrawColor],
			usebox, 									ProjectTD[i][ETextDrawBoxColor],
			ProjectTD[i][ETextDrawShadow], 				ProjectTD[i][ETextDrawOutline],
			ProjectTD[i][ETextDrawBGColor], 			font,
			proportional, 								ProjectTD[i][ETextDrawSelectable],
			ProjectTD[i][ETextDrawType], 				ProjectTD[i][ETextDrawText],
			ProjectTD[i][ETextDrawModelid],
			ProjectTD[i][ETextDrawRotX],				ProjectTD[i][ETextDrawRotY],				ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom],
			ProjectTD[i][ETextDrawVehCol1], 			ProjectTD[i][ETextDrawVehCol2]);
			fwrite(Handler, Pro_Str);
		}
	}
    fclose(Handler);
	return true;
}

stock LoadProject()
{
    if(!strlen(ProjectFile)) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldnt load the project.");
    Handler = fopen(ProjectFile, io_read);
	if(!Handler) return false;
    new i, alignment, usebox, font, proportional;
    while(fread(Handler, Pro_Str))
    {
        StripNewLine(Pro_Str);
		if(!sscanf(Pro_Str, "p<|>ffffffiiiiiiiiiiis[128]dffffdd",
		ProjectTD[i][ETextDrawPosX], 				ProjectTD[i][ETextDrawPosY],
		ProjectTD[i][ETextDrawLetterX], 			ProjectTD[i][ETextDrawLetterY],
		ProjectTD[i][ETextDrawTextX], 				ProjectTD[i][ETextDrawTextY],
		alignment, 									ProjectTD[i][ETextDrawColor],
		usebox, 									ProjectTD[i][ETextDrawBoxColor],
		ProjectTD[i][ETextDrawShadow], 				ProjectTD[i][ETextDrawOutline],
		ProjectTD[i][ETextDrawBGColor], 			font,
		proportional, 								ProjectTD[i][ETextDrawSelectable],
		ProjectTD[i][ETextDrawType], 				ProjectTD[i][ETextDrawText],
		ProjectTD[i][ETextDrawModelid],
		ProjectTD[i][ETextDrawRotX],				ProjectTD[i][ETextDrawRotY],				ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom],
		ProjectTD[i][ETextDrawVehCol1], 			ProjectTD[i][ETextDrawVehCol2]))
		{
		    EditIndex = i;

		    TDE_TextDrawCreate(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]);
			TDE_TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
			TDE_TextDrawAlignment(ProjectTD[i][ETextDrawID], alignment);
			TDE_TextDrawColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawColor]);
			TDE_TextDrawUseBox(ProjectTD[i][ETextDrawID], usebox);
			TDE_TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
			TDE_TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
			TDE_TextDrawBackgroundColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawBGColor]);
			TDE_TextDrawFont(ProjectTD[i][ETextDrawID], font);
			TDE_TextDrawSetProportional(ProjectTD[i][ETextDrawID], proportional);
			if(alignment == 2) TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
			else TDE_TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
			TDE_TextDrawBoxColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawBoxColor]);
			if(font == 5)
		    {
		        TDE_TextDrawSetPreviewModel(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawModelid]);
				TDE_TextDrawSetPreviewRot(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]);
				if(IsVehicle(ProjectTD[i][ETextDrawModelid])) TDE_TextDrawSetPreviewVehCol(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]);
		    }
		    ProjectTD[i][ItsFromTDE] = 1;
		    TDE_TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
		    i++;
		}
    }

    fclose(Handler);
    PageStart = 0;
//	UpdateIcons(EditIndex);
	return true;
}

stock StripNewLine(string[]) //DracoBlue (bugfix idea by Y_Less)
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

stock CheckProject(name[])
{
    if(!fexist("tdelist.txt")) return false;

    Handler = fopen("tdelist.txt", io_read);
    if(!Handler) return -1;

	while(fread(Handler, Pro_Str))
	{
		if(!strcmp(Pro_Str, name, true, strlen(name)))
		{
		    fclose(Handler);
		    return true;
		}
	}
	fclose(Handler);
	return false;
}

stock AddProject(name[])
{
    Handler = fopen("tdelist.txt", io_append);
    if(!Handler) return false;

    fwrite(Handler, name);
    fwrite(Handler, "\r\n");
    fclose(Handler);
    return true;
}

stock CloseProject()
{
    if(!strlen(ProjectFile)) return false;

    SaveProject();
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);

	EditIndex = INVALID_INDEX_ID;
	TDE_TextDrawSetString(TD_Status, "EDITMODE_NONE");
	EditMode = EDITMODE_NONE;
	ColorMode = COLORMODE_NONE;
	EmptyString(ProjectFile);
	ShowEditorEx();
	IsPSel = false;
	KillTimer(EditorUpdateTimer);
	EmptyString(ProjectFile);
    return true;
}

stock IsValidProjectName(name[])
{
	Loop(0, strlen(name))
	{
	    switch(name[c])
	    {
	        case 'A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '(', ')': continue;
	        default: return false;
	    }
	}
	return true;
}

stock ExportProject()
{
	if(!strlen(ProjectFile)) return false;

    new ExportFile[64];
    format(ExportFile, sizeof(ExportFile), "%s", ProjectFile);
    strins(ExportFile, "TDE_", 0);
    new len = strlen(ExportFile);
	strdel(ExportFile, len - 3, len);
	strcat(ExportFile, "txt");

    if(fexist(ExportFile)) fremove(ExportFile);

	new File:ExportIO = fopen(ExportFile, io_append);
	if(!ExportIO) return false;

	new Index, global, player;
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
			    if(ProjectTD[i][ETextDrawType] == 0)
			    {
			    	Index++;
			    	global++;
				}
			}
		}
	}

	if(Index != 0)
	{
	    fwrite(ExportIO, "//Global TextDraws: \r\n\r\n\r\n");
	    format(line, sizeof(line), "new Text:TDEditor_TD[%i];\r\n", Index); fwrite(ExportIO, line);
	    Index = 0;
	    new alignment, font, proportion;
	    fwrite(ExportIO, "\r\n");
	    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
		{
		    if(ProjectTD[i][ItsFromTDE] == 1)
		    {
				if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
				{
				    if(ProjectTD[i][ETextDrawType] == 0)
				    {
				        alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
				        font = TDE_TextDrawGetFont(ProjectTD[i][ETextDrawID]);
				        proportion = TDE_TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
				        format(line, sizeof(line), "TDEditor_TD[%i] = TextDrawCreate(%f, %f, \"%s\");\r\n", Index, ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]); fwrite(ExportIO, line);
                        format(line, sizeof(line), "TextDrawLetterSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]); fwrite(ExportIO, line);
	                    if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]) || font == 4 || font == 5)
	                    {
	                    	if(alignment == 2)
							{
								format(line, sizeof(line), "TextDrawTextSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
								fwrite(ExportIO, line);
							}
							else
							{
								format(line, sizeof(line), "TextDrawTextSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "TextDrawAlignment(TDEditor_TD[%i], %d);\r\n", Index, alignment); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawColor(TDEditor_TD[%i], %i);\r\n", Index, ProjectTD[i][ETextDrawColor]); fwrite(ExportIO, line);
						if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]))
	                    {
							format(line, sizeof(line), "TextDrawUseBox(TDEditor_TD[%i], 1);\r\n", Index); fwrite(ExportIO, line);
                            format(line, sizeof(line), "TextDrawBoxColor(TDEditor_TD[%i], %i);\r\n", Index, ProjectTD[i][ETextDrawBoxColor]); fwrite(ExportIO, line);
						}
						format(line, sizeof(line), "TextDrawSetShadow(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetOutline(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawOutline]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawBackgroundColor(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawBGColor]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawFont(TDEditor_TD[%i], %d);\r\n", Index, font); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetProportional(TDEditor_TD[%i], %d);\r\n", Index, proportion); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetShadow(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);

                        if(ProjectTD[i][ETextDrawSelectable])
						{
						    format(line, sizeof(line), "TextDrawSetSelectable(TDEditor_TD[%i], true);\r\n", Index); fwrite(ExportIO, line);
						}

						if(font == 5)
						{
						    format(line, sizeof(line), "TextDrawSetPreviewModel(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawModelid]); fwrite(ExportIO, line);
						    format(line, sizeof(line), "TextDrawSetPreviewRot(TDEditor_TD[%i], %f, %f, %f, %f);\r\n", Index, ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]); fwrite(ExportIO, line);
							if(IsVehicle(ProjectTD[i][ETextDrawModelid]))
							{
							    format(line, sizeof(line), "TextDrawSetPreviewVehCol(TDEditor_TD[%i], %d, %d);\r\n", Index, ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]); fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "\r\n"); fwrite(ExportIO, line);
						Index ++;
				    }
				}
			}
		}
	}

    Index = 0;

    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
			    if(ProjectTD[i][ETextDrawType] == 1)
			    {
			    	Index++;
			    	player++;
				}
			}
		}
	}

	if(Index != 0)
	{
	    if(global > 0) fwrite(ExportIO, "\r\n\r\n");
		fwrite(ExportIO, "//Player TextDraws: \r\n\r\n\r\n");
	    format(line, sizeof(line), "new PlayerText:TDEditor_PTD[MAX_PLAYERS][%i];\r\n", Index); fwrite(ExportIO, line);
	    Index = 0;
	    new alignment, font, proportion;
	    fwrite(ExportIO, "\r\n");
	    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
		{
		    if(ProjectTD[i][ItsFromTDE] == 1)
		    {
				if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
				{
				    if(ProjectTD[i][ETextDrawType] == 1)
				    {
				        alignment = TDE_TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
				        font = TDE_TextDrawGetFont(ProjectTD[i][ETextDrawID]);
				        proportion = TDE_TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
				        format(line, sizeof(line), "TDEditor_PTD[playerid][%i] = CreatePlayerTextDraw(playerid, %f, %f, \"%s\");\r\n", Index, ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]); fwrite(ExportIO, line);
	                    format(line, sizeof(line), "PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]); fwrite(ExportIO, line);
	                    if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]) || font == 4 || font == 5)
	                    {
	                    	if(alignment == 2)
							{
								format(line, sizeof(line), "PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
								fwrite(ExportIO, line);
							}
							else
							{
								format(line, sizeof(line), "PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, alignment); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][%i], %i);\r\n", Index, ProjectTD[i][ETextDrawColor]); fwrite(ExportIO, line);
						if(TDE_TextDrawIsBox(ProjectTD[i][ETextDrawID]))
	                    {
							format(line, sizeof(line), "PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][%i], 1);\r\n", Index); fwrite(ExportIO, line);
	                        format(line, sizeof(line), "PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][%i], %i);\r\n", Index, ProjectTD[i][ETextDrawBoxColor]); fwrite(ExportIO, line);
						}
						format(line, sizeof(line), "PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawOutline]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawBGColor]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, font); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, proportion); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);

	                    if(ProjectTD[i][ETextDrawSelectable])
						{
						    format(line, sizeof(line), "PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][%i], true);\r\n", Index); fwrite(ExportIO, line);
						}

						if(font == 5)
						{
						    format(line, sizeof(line), "PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawModelid]); fwrite(ExportIO, line);
						    format(line, sizeof(line), "PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][%i], %f, %f, %f, %f);\r\n", Index, ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]); fwrite(ExportIO, line);
							if(IsVehicle(ProjectTD[i][ETextDrawModelid]))
							{
							    format(line, sizeof(line), "PlayerTextDrawSetPreviewVehCol(playerid, TDEditor_PTD[playerid][%i], %d, %d);\r\n", Index, ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]); fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "\r\n"); fwrite(ExportIO, line);
						Index ++;
				    }
				}
			}
		}
	}

	new Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	new Year, Month, Day;
	getdate(Year, Month, Day);

	format(line, sizeof(line), "\r\n\r\n\r\n//Total textdraws exported: %d (%d global textdraws / %d player textdraws) ~ %d/%d/%d ~ %d:%d:%d", (global+player), global, player, Day, Month, Year, Hour, Minute, Second); fwrite(ExportIO, line);
	format(line, sizeof(line), "\r\nTDEditor V1.17 BY ADRI1"); fwrite(ExportIO, line);
	fclose(ExportIO);

	new str[128];
	format(str, 128, "{e2b960}TDEditor: {FFFFFF}Project exported (%s, %d global textdraws, %d player textdraws).", ExportFile, global, player);
	SendClientMessage(ProjectEditor, -1, str);
	return 1;
}

static DelayShowInfoDrawTimer;
static PlayerText:InfoDraw = PlayerText:-1;


static CreateInfoDraws()
{
	InfoDraw = CreatePlayerTextDraw(ProjectEditor, 320.000000, 217.000000, "320.000,_320.000~n~");
	PlayerTextDrawLetterSize(ProjectEditor, InfoDraw, 0.659499, 2.686399);
	PlayerTextDrawAlignment(ProjectEditor, InfoDraw, 2);
	PlayerTextDrawColor(ProjectEditor, InfoDraw, -1);
	PlayerTextDrawSetShadow(ProjectEditor, InfoDraw, 0);
	PlayerTextDrawSetOutline(ProjectEditor, InfoDraw, 2);
	PlayerTextDrawBackgroundColor(ProjectEditor, InfoDraw, 255);
	PlayerTextDrawFont(ProjectEditor, InfoDraw, 2);
	PlayerTextDrawSetProportional(ProjectEditor, InfoDraw, 1);
	PlayerTextDrawSetShadow(ProjectEditor, InfoDraw, 0);
	return 1;
}

static DestroyInfoDraws()
{
	PlayerTextDrawDestroy(ProjectEditor, InfoDraw);
	InfoDraw = PlayerText:-1;
	return 1;
}

static ShowInfoDraw(text[], time)
{
	if(_:InfoDraw == -1) CreateInfoDraws();
	KillTimer(DelayShowInfoDrawTimer);
	PlayerTextDrawDestroy(ProjectEditor, InfoDraw);
	CreateInfoDraws();
	PlayerTextDrawSetString(ProjectEditor, InfoDraw, text);
    PlayerTextDrawShow(ProjectEditor, InfoDraw);
	DelayShowInfoDrawTimer = SetTimer("HideInfoDraw", time, false);
	return 1;
}

forward HideInfoDraw();
public HideInfoDraw()
{
	DestroyInfoDraws();
	return 1;
}


/*

	___ __  __
	 | |  \|_  _|.|_ _  _
	 | |__/|__(_|||_(_)|

	TDEditor 1.17 by adri1

*/
