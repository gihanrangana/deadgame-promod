init(){ 
	for(;;){
		level waittill("connected",player);
		player thread blashmaphony();
	}
}
	
blashmaphony() {
	self endon( "disconnect" );
	for(;;) {
		self.spectators = [];
		players_ = getEntArray( "player", "classname" );
		for( i = 0; i < players_.size; i++ ) {
			if( self getEntityNumber() == players_[i].spectatorClient )
			self.spectators[ self.spectators.size ] = players_[i].name;
		}
		if( self.spectators.size > 0 ) {
			if( !isDefined( self.spectatorList ) ) {
				self.spectatorList = newClientHudElem( self );
				self.spectatorList.horzAlign = "right";
				self.spectatorList.vertAlign = "top";
				self.spectatorList.alignX = "right";
				self.spectatorList.alignY = "middle";
				self.spectatorList.x = -5;
				self.spectatorList.y = 100;
				self.spectatorList.font = "default";	
				self.spectatorList.fontscale = 1.4;	
				self.spectatorList.hidewheninmenu = true;
			}
			spectatorString = "";
			for( i = 0; i < self.spectators.size; i++ ){
				spectatorString += self.spectators[i];
				if( i < self.spectators.size - 1 )
				spectatorString += "\n^7";
			}
			self.spectatorList setText( "Spectators:\n^7" + spectatorString );
		} 
		else if( isDefined( self.spectatorList ) )
			self.spectatorList destroy();
		wait 1;
	}
}