//******************************
//	BACKGROUND
//******************************
itemDef
{
//	640-80 = 560-80 = 480
	style			WINDOW_STYLE_SHADER
	rect			79 29 480 420
	exp				material( "menu_background") 
	border			1
	bordercolor		0 0.600 1 1
	visible			1
	decoration
}
//******************************
//	MENU NAME
//******************************
itemDef
{
	visible			1
	origin			90 80
	forecolor		1 1 1 1
	exp				text( dvarString( "menuName" ) )
	textfont		UI_FONT_NORMAL
	textalign		ITEM_ALIGN_LEFT
	textscale		0.8
	decoration
}
//******************************
//	PLAYER NAME
//******************************
itemDef
{
	visible			1
	origin			510 68
	forecolor		1 1 1 1
	exp				text( dvarString( "name" ) )
	textfont		UI_FONT_NORMAL
	textalign		ITEM_ALIGN_RIGHT
	textscale		0.4
	decoration
}
//******************************
//	RANK ICON
//******************************
//itemDef 
//{
//	rect			518 37 32 32
//	style			WINDOW_STYLE_SHADER
//	exp				material( tablelookup( "mp/rankIconTable.csv", 0, stat(2350) , 1 ) )
//	visible			1
//	decoration
//}
//******************************
//	RANK NAME
//******************************
itemDef
{
	visible			1
	origin			550 82
	forecolor		0.95 0.95 0.95 1
	exp				text( dvarString( "ui_rankname" ) )
	textfont		UI_FONT_NORMAL
	textalign		ITEM_ALIGN_RIGHT
	textscale		0.32
	decoration
}
//******************************
//	MIDDLE LINE SEPERATOR
//******************************
itemDef 
{
	rect			319 90 2 210
	style			WINDOW_STYLE_FILLED
	backcolor		1 1 1 0.6
	visible			1
	decoration
}
//******************************
//	BOTTOM LINE SEPERATOR
//******************************
itemDef 
{
	rect			80 300 480 1.3
	style			WINDOW_STYLE_FILLED
	backcolor		1 1 1 0.6
	visible			1
	decoration
}
//******************************
//	BOTTOM SERVER MESSAGE
//******************************
itemDef
{
	name			"motd"
	visible			1
	rect			80 320 470 140
	forecolor		1 1 1 1
	autowrapped
	dvar			"ui_motd"
	textfont		UI_FONT_OBJECTIVE
	textscale		0.32
	textalignx		8
	textaligny		16
	textalign		ITEM_ALIGN_CENTER
	decoration
}
//******************************
//	MOD BY INFORMATION
//******************************
//itemDef
//{
//	rect			80 440 480 10
//	forecolor		1 1 1 1
//	text			"By [H]A[N]U"
//	textfont		UI_FONT_OBJECTIVE
//	textalign		ITEM_ALIGN_RIGHT
//	textalignx		-5
//	textscale		0.24
//	visible			1
//	decoration
//}
