/*
______           __  _____  _____ 
| ___ \         /  ||  _  ||  _  |
| |_/ /_____  __`| || |/' || |_| |
|    // _ \ \/ / | ||  /| |\____ |
| |\ \  __/>  < _| |\ |_/ /.___/ /
\_| \_\___/_/\_\\___/\___/ \____/ 

*/

init(ver)
{
    thread onPlayerSpawn();
}

onPlayerSpawn()
{
    self endon("disconnect");
    while(1)
    {
        level waittill("player_spawn", player);
        player thread watchForFire();
		player thread resetCounter();
		player.shotsfired = 0;
		player.rapidfirewarn = 0;
    }
}

watchForFire()
{
	self endon("death");
    self endon("disconnect");

	while(1)
	{
		self waittill( "weapon_fired" );
		self.shotsfired++;

		if(self.shotsfired == 2 && self.rapidfirewarn < 2)
		{
			self.rapidfirewarn++;
			self freezeControls(1);
			self iPrintLnBold("^1Fast fire detected. Warnings: (^3" + self.rapidfirewarn + "/2^1)");
			wait 5;
			self freezeControls(0);
			self.shotsfired = 0;
		}
		else if(self.shotsfired == 2 && self.rapidfirewarn == 2)
		{
			self iPrintLnBold("^1Fast fire detected. No more warnings for you.");
			self suicide();
			self.shotsfired = 0;
		}
	}
}

resetCounter()
{
	self endon("death");
    self endon("disconnect");

	while(1)
	{
		weap = self getCurrentWeapon();
		if(weaponClass(weap) == "pistol")
		{
			self setClientDvar("cg_weaponcycledelay","0");
			wait 0.075;
		}
		else if(weap != "none")
		{
			self setClientDvar("cg_weaponcycledelay","100");
			wait 0.05;
		}
		else
		{
			self setClientDvar("cg_weaponcycledelay","0");
			wait 0.05;
		}
		
		if(self.shotsfired != 0)
		self.shotsfired--;
	}
}