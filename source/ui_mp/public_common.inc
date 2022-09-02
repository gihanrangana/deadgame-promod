#define TEXT_ALIGN_WHERE	ITEM_ALIGN_MIDDLE_LEFT
#define TEXT_ALIGN_AXIS		6
#define FONT_ITEM_SIZE		0.38
#define TEXT_ALIGN_AXISY	-1

#define ALIGN_BUTTON  0 0

#define MENU_BUTTON( id, x, y, w, h,itemName,itemAction,visArg)							\
itemDef						{															\
	rect                    x y w h ALIGN_BUTTON										\
	style                   WINDOW_STYLE_SHADER 										\
	background              "white" 													\
	foreColor				0.639216 0.654902 0.666667 1 \
	visible 				when( localvarint("ui_highlight_main") == id ) 				\   
	decoration																			\
} 																						\ 
itemDef						{ 															\
	rect                      (x-1) (y-1) (w+1) (h+1) ALIGN_BUTTON 						\
	style                     WINDOW_STYLE_FILLED 										\
	border					  1 														\
	bordersize				  1 														\
	bordercolor				  1 1 1 1 													\
	foreColor                 1 1 1 1													\ 
	type                      ITEM_TYPE_BUTTON 											\
	textFont                  UI_FONT_NORMAL 											\
	textAlign                 TEXT_ALIGN_WHERE 											\
	textAlignX                TEXT_ALIGN_AXIS											\
	textAlignY                TEXT_ALIGN_AXISY											\
	textScale                 FONT_ITEM_SIZE											\
	textStyle                 ITEM_TEXTSTYLE_SHADOWED 									\
	onFocus              																\
	{ 																					\
		play mouse_over;																\
		setLocalVarInt ui_highlight_main id ;											\
	} 																					\
	leaveFocus   																		\              
	{  																					\
		setLocalVarInt ui_highlight_main 0 ;   											\
	} 																					\
	action                  { 															\
		play mouse_click ; 																\
		itemAction; 																	\
	}																					\
	exp                       text ( itemName )											\
	visible 				  visArg    												\             
}