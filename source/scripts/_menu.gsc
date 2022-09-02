init()
{
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connecting", player);		
        player thread onConnected();
    }
}

onConnected()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread setVars();
	}
}

setVars()
{
	self.selectedPlayer = 0;
	self thread onMenuResponse();
}

onMenuResponse()
{	
    self endon("disconnect");
	
	self.f1 = false;
	self.f2 = false;
	self.f3 = false;
	self.f4 = false;
	
	self.pers["Saved_origin"] = 0;
	self.pers["Saved_angles"] = 0;
	
    for (;;)
    {
        self waittill("menuresponse", menu, response);
				
		switch( response )
		{	
			case "hanu_public":
				self closeMenus();
				self openMenu("hanu_public");
				continue;
				
			case "tweak_1":
			case "tweak_2":
			case "tweak_3":
			case "tweak_4":
			case "tweak_5":
			case "tweak_6":
			case "tweak_7":
			case "tweak_8":
			case "tweak_9":
				self closeMenus();
				if		( response == "tweak_1" )
					self thread f1();
				else if	( response == "tweak_2" )
					self thread f2();
				else if	( response == "tweak_3" )
					self thread f3();
				else if	( response == "tweak_4" )
					self thread uni3();
				else if	( response == "tweak_5" )
					self thread f5();
				else if	( response == "tweak_6" )
					self thread uni();
				else if	( response == "tweak_7" )
					self thread f7();
				else if	( response == "tweak_8" )
					self thread f8();
				else if	( response == "tweak_9" )
					self thread coff();
				continue;
				
			case "svrtweak":
				self closeMenus();
				if (self.f1 == false && self.f2 == false && self.f3 == false && self.f4 == false)
				{
					self iPrintln("^3Filmtweaks Pack 1 ^2Applied!");
					self thread uni();
					self.f1 = true;
					self.f2 = false;
					self.f3 = false;
					self.f4 = false;
				}
				else if (self.f1 == true && self.f2 == false && self.f3 == false && self.f4 == false)
				{
					self iPrintln("^3Filmtweaks Pack 2 ^2Applied!");
					self thread uni2();
					self.f1 = false;
					self.f2 = true;
					self.f3 = false;
					self.f4 = false;
				}
				else if (self.f1 == false && self.f2 == true && self.f3 == false && self.f4 == false)
				{
					self iPrintln("^3Filmtweaks Pack 3 ^2Applied!");
					self thread uni3();
					self.f1 = false;
					self.f2 = false;
					self.f3 = true;
					self.f4 = false;
				}
				else if (self.f1 == false && self.f2 == false && self.f3 == true && self.f4 == false)
				{
					self iPrintln("^3Filmtweaks ^1[OFF]!");
					self thread coff();
					self.f1 = false;
					self.f2 = false;
					self.f3 = false;
					self.f4 = false;
				}
				continue;
			
		}
		
	}
	
}



closeMenus()
{
	self closeMenu();
	self closeInGameMenu();
}




uni()
{
	self setClientDvar("r_lighttweaksunlight", 0.6);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.6 1.5 1.6");
	self setClientDvar("r_filmtweaklighttint", "0.4 0.6 1");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.31");
	self setClientDvar("r_filmTweakBrightness", "0.4");
	self setClientDvar("r_filmTweakContrast", "2.18");
}

coff()
{

	self setClientDvar("r_filmtweakenable", "0");
	self setClientDvar("r_filmusetweaks", "0");
}

uni2()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.75 1.65 1.85");
	self setClientDvar("r_filmtweaklighttint", "0.5 0.7 0.7");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.1");
	self setClientDvar("r_filmTweakBrightness", "0.40");
	self setClientDvar("r_filmTweakContrast", "2.9");
}

uni3()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.35 1.4 2");
	self setClientDvar("r_filmtweaklighttint", "0.65 0.8 0.65");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.1");
	self setClientDvar("r_filmTweakBrightness", "0.35");
	self setClientDvar("r_filmTweakContrast", "2.25");
}
f1()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.75 1.65 1.85");
	self setClientDvar("r_filmtweaklighttint", "0.5 0.7 0.7");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.1");
	self setClientDvar("r_filmTweakBrightness", "0.17");
	self setClientDvar("r_filmTweakContrast", "2.6");
}

f2()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.75 1.65 1.85");
	self setClientDvar("r_filmtweaklighttint", "0.5 0.7 0.7");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.1");
	self setClientDvar("r_filmTweakBrightness", "0.40");
	self setClientDvar("r_filmTweakContrast", "2.9");
}
f3()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.75 1.65 1.85");
	self setClientDvar("r_filmtweaklighttint", "0.5 0.7 0.7");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "1.1");
	self setClientDvar("r_filmTweakBrightness", "0.40");
	self setClientDvar("r_filmTweakContrast", "2.9");
}

f5()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "2.70 2.90 2.80");
	self setClientDvar("r_filmtweaklighttint", "1.60 1.65 1.65");
	self setClientDvar("r_filmtweakdesaturation", "1");
	self setClientDvar("r_gamma", "1.5");
	self setClientDvar("r_filmTweakBrightness", "0.20");
	self setClientDvar("r_filmTweakContrast", "3");
}
f7()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.8 1.8 2");
	self setClientDvar("r_filmtweaklighttint", "0.3 0.4 0.7");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "0.99");
	self setClientDvar("r_filmTweakBrightness", "0.4");
	self setClientDvar("r_filmTweakContrast", "2.5");
}
f8()
{
	self setClientDvar("r_lighttweaksunlight", 0.82);
	self setClientDvar("r_fullbright", 0);
	self setClientDvar("r_filmtweakenable", "1");
	self setClientDvar("r_filmusetweaks", "1");
	self setClientDvar("r_filmtweakdarktint", "1.45 1.45 1.65");
	self setClientDvar("r_filmtweaklighttint", "0 0.1 0.3");
	self setClientDvar("r_filmtweakdesaturation", "0");
	self setClientDvar("r_gamma", "0.9");
	self setClientDvar("r_filmTweakBrightness", "0.55");
	self setClientDvar("r_filmTweakContrast", "2.45");
}