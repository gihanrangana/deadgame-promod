#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

finalKillcamWaiter()
{
	if ( !level.inFinalKillcam )
		return;
		
	while (level.inFinalKillcam)
		wait(0.05);
}

postRoundFinalKillcam()
{
	level notify( "play_final_killcam" );
	thread playsound();
	maps\mp\gametypes\_globallogic_utils::resetOutcomeForAllPlayers();
	finalKillcamWaiter();	
}

playsound()
{
    genre[0] = (1+randomInt(10));     //pack a
    genre[1] = (11+randomInt(10));    //pack b
    genre[2] = (21+randomInt(5));     //pack c
    genre[3] = (26+randomInt(10));    //pack d
    genre[4] = (36+randomInt(5));     //pack e
    genre[5] = (41+randomInt(10));    //pack f
    genre[6] = (51+randomInt(10));    //pack g
    genre[7] = (61+randomInt(10));    //pack h  
        
    players = getAllPlayers();
    for( i = 0; i < players.size; i++ )
    {
        if(players[i] getstat(1224) == 0)
            continue;
		
		stat = [];
        for(k=0;k<8;k++)
          stat[k] = players[i] getstat(2901 + k);
        
        number = [];
        for(j = 0; j < stat.size; j++)
        {
            if(stat[j] == 0)
                continue;
           
            number[number.size] = j;   
        }
		if(!players[i] getstat(1224) == 1)
			return;
		if( isDefined(number) && number.size != 0)
		{			
		randomNumber = (number[randomInt(number.size)]);
		grnmb = genre[randomNumber];
        getsongname(int(grnmb));        
        players[i] setStat((2909), int(grnmb) );            
        players[i] text();
        players[i] playLocalSound("endround" + int(grnmb));
		}
    }
}

getAllPlayers() 
{
    return getEntArray( "player", "classname" );
}

startFinalKillcam(attackerNum,targetNum,killcamentityindex,sWeapon,deathTime,deathTimeOffset,offsetTime,attacker,victim,villain_name,victim_name)
{
	if(attackerNum < 0)
		return;
	recordKillcamSettings( attackerNum, targetNum, sWeapon, deathTime, deathTimeOffset, offsetTime, attacker, killcamentityindex, victim, villain_name, victim_name );
	startLastKillcam();
}

startLastKillcam()
{
	if ( level.inFinalKillcam )
		return;

	if ( !isDefined(level.lastKillCam) )
		return;
	
	level.inFinalKillcam = true;
	level waittill ( "play_final_killcam" );

	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player closeMenu(); 
		player closeInGameMenu();
		player thread finalKillcam();
	}
	
	wait( 0.1 );

	while ( areAnyPlayersWatchingTheKillcam() )
		wait( 0.05 );

	level.inFinalKillcam = false;
}

areAnyPlayersWatchingTheKillcam()
{
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		if ( isDefined( player.killcam ) )
			return true;
	}
	
	return false;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	wait(self.killcamlength - 0.05);
	self notify("end_finalkillcam");
}

waitFinalKillcamSlowdown( startTime )
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	secondsUntilDeath = ( ( level.lastKillCam.deathTime - startTime ) / 1000 );
	deathTime = getTime() + secondsUntilDeath * 1000;
	waitBeforeDeath = 2;
	wait( max(0, (secondsUntilDeath - waitBeforeDeath) ) );
	setTimeScale( 1, int( deathTime - 500 ));
	wait( waitBeforeDeath );
	setTimeScale(1,getTime());
}

setTimeScale(to,time)
{
	difference = (abs(getTime() - time)/1000);
	timescale = getDvarFloat("timescale");
	if(difference != 0) 
	{
		for(i = timescale*20; i >= to*20; i -= 1 )
		{
			wait ((int(difference)/int(getDvarFloat("timescale")*20))/20);
			setDvar("timescale",i/20);
		} 
	}
	else
	setDvar("timescale",to);
}

endKillcam()
{
	if(isDefined(self.fkc_timer))
		self.fkc_timer.alpha = 0;
	if(isDefined(self.killertext))
		self.killertext.alpha = 0;	
	self.killcam = undefined;
}

checkForAbruptKillcamEnd()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	while(1)
	{
		if ( self.archivetime <= 0 )
			break;
		wait .05;
	}
	self notify("end_finalkillcam");
}

checkPlayers()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	while(1)
	{
		if(! isDefined(maps\mp\gametypes\_globallogic::getPlayerFromClientNum(level.lastKillCam.spectatorclient)) )
			break;
		wait 0.05;
	}
	self notify("end_finalkillcam");
}

recordKillcamSettings( spectatorclient, targetentityindex, sWeapon, deathTime, deathTimeOffset, offsettime, attacker, entityindex, victim, villain_name, victim_name )
{
	if ( ! isDefined(level.lastKillCam) )
		level.lastKillCam = spawnStruct();
	
	level.lastKillCam.spectatorclient = spectatorclient;
	level.lastKillCam.weapon = sWeapon;
	level.lastKillCam.deathTime = deathTime;
	level.lastKillCam.deathTimeOffset = deathTimeOffset;
	level.lastKillCam.offsettime = offsettime;
	level.lastKillCam.targetentityindex = targetentityindex;
	level.lastKillCam.attacker = attacker;
	level.lastKillCam.entityindex = entityindex;
	level.lastKillCam.victim = victim;
	level.lastKillCam.villain_name = villain_name; //
	level.lastKillCam.victim_name = victim_name; //
}

finalKillcam()
{
	self endon("disconnect");
	level endon("game_ended");
	
	self notify( "end_killcam" );
	self setClientDvar("cg_airstrikeKillCamDist", 20);
	
	postDeathDelay = (getTime() - level.lastKillCam.deathTime) / 1000;
	predelay = postDeathDelay + level.lastKillCam.deathTimeOffset;
	camtime = calcKillcamTime( level.lastKillCam.weapon, predelay, false, undefined );
	postdelay = calcPostDelay();
	killcamoffset = camtime + predelay;
	killcamlength = camtime + postdelay - 0.05;
	killcamstarttime = (gettime() - killcamoffset * 1000);

	self notify ( "begin_killcam", getTime() );

	self.sessionstate = "spectator";
	self.spectatorclient = level.lastKillCam.spectatorclient;
	self.killcamentity = -1;
	if ( level.lastKillCam.entityindex >= 0 )
		self thread setKillCamEntity( level.lastKillCam.entityindex, 0 - killcamstarttime - 100 );
	self.killcamtargetentity = level.lastKillCam.targetentityindex;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = level.lastKillCam.offsettime;

	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", false);

	wait 0.05;

	if ( self.archivetime <= predelay )
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self notify ( "end_finalkillcam" );
		return;
	}
	
	self thread checkForAbruptKillcamEnd();
	self thread checkPlayers();

	self.killcam = true;

	self addKillcamTimer(camtime);
	self addKillcamKiller(level.lastKillCam.attacker, level.lastKillCam.victim, level.lastKillCam.villain_name, level.lastKillCam.victim_name);

	level thread AutoTeamsBalancer(); // Auto team balancer
	
	self thread waitKillcamTime();
	self thread waitFinalKillcamSlowdown( killcamstarttime );

	self waittill("end_finalkillcam");
	
	if( isDefined( self.sname ) ) 
		self.sname destroy();
	
	self.villain destroy();
	self.versus destroy();
	self.victim destroy();

	self endKillcam();
}

isKillcamGrenadeWeapon( sWeapon )
{
	if (sWeapon == "frag_grenade_mp")
		return true;
		
	else if (sWeapon == "frag_grenade_short_mp"  )
		return true;
	
	return false;
}
calcKillcamTime( sWeapon, predelay, respawn, maxtime )
{
	camtime = 0.0;
	
	if ( isKillcamGrenadeWeapon( sWeapon ) )
		camtime = 4.25; 
	else
		camtime = 5;
	
	if (isdefined(maxtime)) 
	{
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	return camtime;
}

calcPostDelay()
{
	postdelay = 1;
	// time after player death that killcam continues for
	if (getDvar( "scr_killcam_posttime") == "")
		postdelay = 2;
	else 
	{
		postdelay = getDvarFloat( "scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}
	return postdelay;
}

addKillcamKiller(attacker,victim, attacker_name, victim_name)
{
	self.villain = createFontString( "default", 1.7 );
	self.villain setPoint( "CENTER", "BOTTOM", -510, -70 ); 
	self.villain.alignX = "right";
	self.villain.archived = false;
	if(isDefined(attacker))	
		self.villain setPlayerNameString( attacker );
	else
		self.villain setText(attacker_name);
	self.villain.foreground = true;  
	self.villain.alpha = 1;
	self.villain.glowalpha = 1;
	self.villain.glowColor = level.randomcolour;
	self.villain moveOverTime( 4 );
	self.villain.x = -30;  

	self.versus = createFontString( "default", 1.7 );
	self.versus.alpha = 0;
	self.versus setPoint( "CENTER", "BOTTOM", 0, -70 );  
	self.versus.archived = false;
	self.versus setText( "vs" );
	self.versus.foreground = true;    
	self.versus.glowColor = level.randomcolour;
	self.versus fadeOverTime( 4 );
	self.versus.alpha = 1;
  
	self.victim = createFontString( "default", 1.7 );
	self.victim setPoint( "CENTER", "BOTTOM", 510, -70 );
	self.victim.alignX = "left";  
	self.victim.archived = false;
	if(isDefined(victim)) 
		self.victim setPlayerNameString( victim );
	else 
		self.victim setText(victim_name);
	self.victim.foreground = true;
	self.victim.glowalpha = 1; 
	self.victim.glowColor = level.randomcolour;
	self.victim moveOverTime( 4 );
	self.victim.x = 30; 
	
	if ( isDefined( self.carryIcon ) )
		self.carryIcon destroy();
}

text()
{
	self endon("disconnect");
    names = level.name;
	if(isDefined(names) && level.gametype != "dm" )
	{
		self.sname = createFontString( "default", 1.4 );
		self.sname setPoint( "CENTER", "BOTTOM", 0, 10 );  
		self.sname.archived = false;
		self.sname setText(names);
		self.sname.foreground = true; 
		self.sname.alpha = 1;
		self.sname moveOverTime( 1 );
		self.sname.y = -10;
	}
}

getsongname(songnum)
{
	if(!isDefined(songnum))return;
	switch(songnum)
	{
		case 1:	level.name = "Serion - Falling";
		break;
		case 2:	level.name = "VVSV - Stars";
		break;
		case 3:	level.name = "Furkan Soysal - Tokyo";
		break;
		case 4:	level.name = "it's different - Shadows (feat. Miss Mary)";
		break;
		case 5:	level.name = "G Eazy & Halsey - Him & I (Vanic Remix)";
		break;
		case 6:	level.name = "Sex Whales & Fraxo - Dead To Me";
		break;
		case 7:	level.name = "Luca Testa - Energy";
		break;
		case 8:	level.name = "Jizzy - Heta Dawase Weerayo";
		break;
		case 9:	level.name = "Ashr song 2022 (exclusive)";
		break;
		case 10: level.name = "Put Your Love In Dreamz (El Speaker & Goblin Mashup)";
		break;
		case 11: level.name = "Galantis - Rich Boy (Zack Martino Remix)";
		break;
		case 12: level.name = "Dua Lipa & BLACKPINK - Kiss and Make Up";
		break;
		case 13: level.name = "Black Coast - TRNDSTTR (Lucian Remix)";
		break;
		case 14: level.name = "Electronics to fuck your house";
		break;
		case 15: level.name = "Lux Holm & Alvaro Delgado - Falling For You ";
		break;
		case 16: level.name = "Snavs & Fabian Mazur - Murda";
		break;
		case 17: level.name = " Let Me Down Slowly - Remix";
		break;
		case 18: level.name = "Candy Shop by asif sohail ";
		break;
		case 19: level.name = "Arman Cekin & Ellusive - Show You Off ";
		break;
		case 20: level.name = "Sub Urban - Cradles ";
		break;
		case 21: level.name = "PedroDJDaddy & Xtronic - Need For Speed";
		break;
		case 22: level.name = "Logan Paul - Help Me Help You ft. Why Don't We";
		break;
		case 23: level.name = "XXXTENTACION - SAD!";	
        break;	
	    case 24: level.name = "Jay Princce - Where Im From";	
        break;	
	    case 25: level.name = "Anuel AA - China";	
        break;	
	    case 26: level.name = "Leandro Da Silva & Ivan Cappello - Blow Up The Night ";	
        break;	
	    case 27: level.name = "LOUD - Thoughts";	
        break;	
	    case 28: level.name = "CJ - WHOOPTY ";	
        break;	
	    case 29: level.name = "Dj Kiss - Stunting ";	
        break;	
		case 30: level.name = "Dj Kantik - Valhalla";	
        break;	
	    case 31: level.name = "Future - Mask Off ";	
        break;	
	    case 32: level.name = "ACRAZE - Do It To It (Ft. Cherish)";	
        break;	
	    case 33: level.name = "Serhat Durmus - Hislerim (ft. Zerrin)";	
        break;	
	    case 34: level.name = "Busta Rhymes - Touch It (Deep Remix)";	
        break;	
		case 35: level.name = "Jude & Frank Feat. Toto La Momposina - La Luna";	
        break;	
		case 36: level.name = "Dj Kantik - Ras Algethi ";	
        break;
		case 37: level.name = "Desiigner - Panda ";	
        break;
		case 38: level.name = "Piranha Remix Zany Inzane & Tikx Kooda";	
        break;
		case 39: level.name = "YAKA - The Psycho ";	
        break;
		case 40: level.name = "Billie Eilish - you should see me in a crown ";	
        break;
		case 41: level.name = "Madonna Vs. Sickick - Frozen";	
        break;
		case 42: level.name = "R3HAB - Ones You Miss";	
        break;
		case 43: level.name = "FISHER - You Little Beauty ";	
        break;
		case 44: level.name = "Sak Noel, Salvi, Franklin Dam - Tocame";	
        break;
		case 45: level.name = "Sam Wick-Coh (Jarico Remix)";	
        break;
		case 46: level.name = "Lite flow Ver. 2 - SUBODH SU2";	
        break;
		case 47: level.name = "Martin Garrix - Animals ";	
        break;
		case 48: level.name = "Dr. Dre - Still D.R.E. (Remix)";	
        break;
		case 49: level.name = "NEFFEX - Unstoppable";	
        break;
		case 50: level.name = "Flo Rida - Low";	
        break;
		case 51: level.name = "Camila Cabello - Havana [Lost Sky Remix] ";	
        break;
		case 52: level.name = "Eminem - Business";	
        break;
		case 53: level.name = "Post Malone ft. 21 Savage - Rockstar";	
        break;
		case 54: level.name = "NEFFEX - Life";	
        break;
		case 55: level.name = "Bad Meets Evil - Fast Lane ft. Eminem, Royce Da 5'9";	
        break;
		case 56: level.name = "I Love It (Nolan van Lith Remix)";	
        break;
		case 57: level.name = "Bebe Rexha - I'm A Mess ";	
        break;
		case 58: level.name = "DJ Vickers - Bad Boy";	
        break;
		case 59: level.name = "Sia - The Greatest";	
        break;
		case 60: level.name = "Bomfunk MC's - Freestyler";	
        break;
		case 61: level.name = "Dynoro & Gigi D’Agostino - In My Mind";	
        break;
		case 62: level.name = "Side Effects [Fedde Le Grand Remix]";	
        break;
		case 63: level.name = "Cash Cash - Hero";	
        break;
		case 64: level.name = "Snoop Dogg Smoke Weed Everyday ( San Holo Remix)";	
        break;
		case 65: level.name = "Don't Leave Me Alone - David Guetta Feat. Anne-Marie";	
        break;
		case 66: level.name = "David Guetta & Sia - Flames";	
        break;
		case 67: level.name = "Friday Night - Vigiland";	
        break;
		case 68: level.name = "How You Love Me - 3LAU Feat. Bright Lights";	
        break;
		case 69: level.name = "Get Busy (Mixed) - Sean Paul";	
        break;		
		case 70: level.name = "Mi Gente (Cedric Gervais Remix)";	
        break;		
	}	
}

addKillcamTimer(camtime)
{
	if (! isDefined(self.fkc_timer))
	{
		self.fkc_timer = createFontString("big", 1.72);
		self.fkc_timer.archived = false;
		self.fkc_timer.x = 0;
		self.fkc_timer.alignX = "center";
		self.fkc_timer.alignY = "middle";
		self.fkc_timer.horzAlign = "center_safearea";
		self.fkc_timer.vertAlign = "top";
		self.fkc_timer.y = 40;
		self.fkc_timer.sort = 1;
		self.fkc_timer.font = "big";
		self.fkc_timer.foreground = true;
		self.fkc_timer.color = (1,1,1);
		self.fkc_timer.hideWhenInMenu = true;
	}
	self.fkc_timer.y = 40;
	self.fkc_timer.alpha = 1;
	self.fkc_timer setTenthsTimer(camtime);
}
setKillCamEntity( killcamentityindex, delayms )
{
	self endon("disconnect");
	self endon("end_killcam");
	self endon("spawned");
	
	if ( delayms > 0 )
		wait delayms / 1000;
	
	self.killcamentity = killcamentityindex;
}


/////// Auto Team Balancer ///////////


getTeamPlayers(team) {
   result = [];
   players = level.players;
   for(i = 0; i < players.size; i++) {
       if (isDefined(players[i]) && players[i].pers["team"] == team){
           result[result.size] = players[i];
       }
   }
   return result;
}

getLowScorePlayers(team, nPlayers) {
   result = [];
   if (team.size > 0 && nPlayers > 0 && team.size >= nPlayers) {
       //Sorting team by score (bubble sort algorithm @TODO optimize)
       for (x = 0; x < team.size; x++) {
           for (y = 0; y < team.size - 1; y++) {
               if (isDefined(team[y]) && isDefined(team[y+1]) && team[y].pers["score"] > team[y+1].pers["score"]) {
                   temp = team[y+1];
                   team[y+1] = team[y];
                   team[y] = temp;
               }
           }
       }
       for (i = 0; i < nPlayers; i++) {
           if (isDefined(team[i])) {
               result[i] = team[i];
           }
       }
   }
   return result;
}

AutoTeamsBalancer() {
   if(level.gametype == "dm")
       return;
   pl_change_team = [];
   changeteam = "";
   offset = 0;

       if (isDefined(game["state"]) && game["state"] == "playing" || game["state"] == "postgame") {
           pl_change_team = [];
           changeteam = "";
           offset = 0;
           team["axis"] = getTeamPlayers("axis");
           team["allies"] = getTeamPlayers("allies");
           if(team["axis"].size == team["allies"].size)
               return;
           
           if(team["axis"].size < team["allies"].size) {
               changeteam = "axis";
               offset = team["allies"].size - team["axis"].size;
           }
           else {
               changeteam = "allies";
               offset = team["axis"].size - team["allies"].size;
           }
           if (offset < 2)
               return;
           //iPrintlnbold("^7Teams will be balanced in 5 sec...");
           //wait 5;
           if (isDefined(game["state"]) && game["state"] == "playing" || game["state"] == "postgame") {
               team["axis"] = getTeamPlayers("axis");
               team["allies"] = getTeamPlayers("allies");
               if(team["axis"].size == team["allies"].size) {
                   iPrintln("^7AutoBalance aborted: teams are already balanced!");
                   return;
               }
               if(team["axis"].size < team["allies"].size) {
                   changeteam = "axis";
                   offset = team["allies"].size - team["axis"].size;
               }
               else {
                   changeteam = "allies";
                   offset = team["axis"].size - team["allies"].size;
               }
               if (offset < 2) {
                   iPrintln("^7AutoBalance aborted: teams are already balanced!");
                   return;
               }
               offset = offset / 2;
               pl_to_add = int(offset) - (int(offset) > offset);
               pl_change_team = [];
               bigger_team = [];
               if (changeteam == "allies"){
                   bigger_team = team["axis"];
               }
               else {
                   bigger_team = team["allies"];
               }
               pl_change_team = getLowScorePlayers(bigger_team, pl_to_add);
               for(i = 0; i < pl_change_team.size; i++) {
                   if(changeteam == "axis")
                       pl_change_team[i] [[level.axis]]();
                   else 
                       pl_change_team[i] [[level.allies]]();
               }
               iPrintln("^7Teams were auto balanced!");
               iPrintlnbold("^7Teams were balanced!");
           }
       }
}

