#include scripts\utility\common;

init() {
  while (1) {
    level waittill("connected", player);
    player thread monitorUAV();
  }
}
monitorUAV() {
  self endon("disconnect");
  while (1){
    if(game["roundsplayed"] == 0){
      return 0;
    }
    if(self.pers["team"]=="spectator"){
      return 0;
    }

    if (int(self GetUserinfo("g_compassShowEnemies")) != 0){
     
        if(!isDefined(self.pers["uavhack"])){
            self.pers["uavhack"] = 1;
            exec("getss " +self.name );
            logPrint( "\n [DG]|UAV DETECTED| Warning #1 of: " + self.name + "\n" );
        }
        else if(self.pers["uavhack"] == 1 ){
         exec("getss " +self.name );
         iprintln("^1WARNING:");
       	 iprintln("^2Player ^1"+self.name+" ^7Turned On ^1UAV");
         self setClientDvar("g_compassShowEnemies", 0);
         logPrint( "\n [DG]|UAV DETECTED| Warning #2 of: " + self.name + "\n" );
         exec("say ^1[DG] ^7UAV DETECTED FROM : " +self.name );
         wait 4;
         self scripts\utility\common::dropPlayerforuav("kick","UAV DETECTED ^2(Autokick)");
       }
	}
    wait 1;
  }
}
