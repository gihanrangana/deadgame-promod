/*$$$$$$$$\                     
$$  _____|                    
$$ |      $$\   $$\  $$$$$$\  
$$$$$\    \$$\ $$  |$$  __$$\ 
$$  __|    \$$$$  / $$$$$$$$ |
$$ |       $$  $$<  $$   ____|
$$$$$$$$\ $$  /\$$\ \$$$$$$$\ 
\________|\__/  \__| \_______|*/

init(ver)
{        
    for (;;)
    {
        level waittill("connected", player);
        player thread spectating();
    }
}
spectating()
{
    self endon( "disconnect" );

    entity = undefined;
    
    for( ;; )
    {
        
        while( 1 )
        {   
            entity = self getSpectatorClient();

            if(!isAlive(self) && self.sessionstate == "spectator" && isDefined(entity) && entity.sessionstate == "playing")
            {

                if( !isDefined( self.keyshudspec ) )
                  self keyshud();
                thread keysThink( entity );
            }
            else
            {
                if( isDefined( self.keyshudspec ) )
                     for( i = 0; i < self.keyshudspec.size; i++ )
                    self.keyshudspec[ i ] destroy();
                
                    self.keyshudspec = undefined;
            } 
            wait .05; 
        }
         wait 0.1;
    }
 }

keysThink( a )
{
    self endon("disconnect");
    self endon( "disconnect" );
    a endon( "disconnect" );
    
    if(a forwardButtonPressed())
        self.keyshudspec[0].alpha = 1;
    else
        self.keyshudspec[0].alpha = 0.6;


    if(a moveLeftButtonPressed())
        self.keyshudspec[1].alpha = 1;
    else
        self.keyshudspec[1].alpha = 0.6;
    

    if(a backButtonPressed())
        self.keyshudspec[2].alpha = 1;
    else
        self.keyshudspec[2].alpha = 0.6;
    

    if(a moveRightButtonPressed())
        self.keyshudspec[3].alpha = 1;
    else
        self.keyshudspec[3].alpha = 0.6;
    
            

}

keyshud()
{
    self.keyshudspec = [];

    // w
    self.keyshudspec[0] = addHud(self, 320, 370, 0.6, "center", "bottom", 1.8 );
    self.keyshudspec[0].archived = false;
    self.keyshudspec[0] SetShader("key_w", 30,30);
    self.keyshudspec[0].hidewheninmenu = true;

    // a
    self.keyshudspec[1] = addHud(self, 285, 405, 0.6, "center", "bottom", 1.8 );
    self.keyshudspec[1].archived = false;
    self.keyshudspec[1] SetShader("key_a", 30,30);
    self.keyshudspec[1].hidewheninmenu = true;

    // s
    self.keyshudspec[2] = addHud(self, 320, 405, 0.6, "center", "bottom", 1.8 );
    self.keyshudspec[2].archived = false;
    self.keyshudspec[2] SetShader("key_s", 30,30);
    self.keyshudspec[2].hidewheninmenu = true;

    // d
    self.keyshudspec[3] = addHud(self, 355, 405, 0.6, "center", "bottom", 1.8 );
    self.keyshudspec[3].archived = false;
    self.keyshudspec[3] SetShader("key_d", 30,30);
    self.hidewheninmenu = true;
}

addHud(who, x, y, alpha, alignX, alignY, fontScale)
{
    if(isPlayer(who))
        hud = newClientHudElem(who);
    else
        hud = newHudElem();

    hud.x = x;
    hud.y = y;
    hud.alpha = alpha;
    hud.alignX = alignX;
    hud.alignY = alignY;
    hud.fontScale = fontScale;
    return hud;
}