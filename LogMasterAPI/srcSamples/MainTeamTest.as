package {
import flash.display.Sprite;
import teamTest.TeamLoger;


/**
 * ...
 * @author Deril
 */
public class MainTeamTest extends Sprite {


	static private var log:TeamLoger = new TeamLoger("MainTeamTest");

	public function MainTeamTest() {
		
		log.debugRB("Debug my text!", 5.554, this);
		log.fatalRB(new Error("once upon a time.. there was an error.."));
		
		
		log.debugTo(TeamLoger.MailSystem, "test");
		
		
		
		
		
		//log.debug1("Debug");
		//log.debug2("Debug");
		//log.debug3("Debug");
		//log.debug4("Debug");
		//log.debug5("Debug");
		//log.debug6("Debug");
		//log.debug7("Debug");
		//log.debug8("Debug");
		//log.debug9("Debug");
		//log.debugCOM("Debug");
		//log.debugERROR("Debug");
		//log.debugFATAL("Debug");		
		
	}

}

}