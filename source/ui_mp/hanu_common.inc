#define HANU_BUTTON_FORECOLOR 			1 1 1 1
#define HANU_BUTTON_BACKCOLOR 			0.4 0.4 0.4 0.4
#define HANU_BUTTON_BACKCOLOR_FOCUSED 	0.4 0.4 0.4 0.3
#define HANU_BUTTON_BORDERCOLOR 			0.5 0.5 0.5 0.15
#define HANU_BUTTON_ALIGN 				0 0 


#define ADD_BUTTON( id, x, y, w, h, itemName, itemAction, visArg ) \
itemDef \
{ \
	visible			visArg \
	name			"button_default"id \
	rect			x y w h HANU_BUTTON_ALIGN \
	style			WINDOW_STYLE_FILLED \
	border			1 \
	bordercolor		HANU_BUTTON_BORDERCOLOR \ 
	backcolor		HANU_BUTTON_BACKCOLOR \
	mouseEnter \
	{ \
		setitemcolor "button_default"id backcolor	HANU_BUTTON_BACKCOLOR_FOCUSED \
	} \
	mouseExit \
	{ \
		setitemcolor "button_default"id backcolor	HANU_BUTTON_BACKCOLOR \
	} \
} \
itemDef \
{ \
	style		WINDOW_STYLE_FILLED \
	rect		x y w h HANU_BUTTON_ALIGN \
	forecolor	1 1 1 0.85 \
	exp			text( itemName ) \
	type		ITEM_TYPE_BUTTON \
	textfont	UI_FONT_NORMAL \
	textstyle	ITEM_TEXTSTYLE_SHADOWED \
	textalign	ITEM_ALIGN_LEFT \
	textscale	0.4 \
	textalignx	8 \
	textaligny	(h-1) \
	visible		visArg \
	mouseEnter \
	{ \
		play "mouse_over"; \
		onItemEnter \
	} \
	mouseExit \
	{ \
		onItemExit \
	} \
	action \
	{ \
		play "mouse_click"; \
		itemAction \
	} \
} 