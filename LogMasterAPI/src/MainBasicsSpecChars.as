package {
import com.mindscriptact.logmaster.DebugMan;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


/**
 * show diferent message types - 5 defalt + custom..
 * @author Deril
 */
public class MainBasicsSpecChars extends Sprite {

	public function MainBasicsSpecChars(){

		this.stage.addEventListener(MouseEvent.CLICK,testTrace)
		
		testTrace();
				
				
		DebugMan.debugTo(5,"!@#$%^&*(){}[]<><hi>/\\\"\'\"\'");
		DebugMan.infoTo(5,"!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.warnTo(5,"!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.errorTo(5,"!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.fatalTo(5,"!@#$%^&*(){}[]<><hi>/\\\"\'");
				
	}
	
	private function testTrace(event:Event = null):void {
		DebugMan.debug("!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.info("!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.warn("!@#$%^&*(){}[]<><hi>/\\\"\'”");
		DebugMan.error("!@#$%^&*(){}[]<><hi>/\\\"\'");
		DebugMan.fatal("!@#$%^&*(){}[]<><hi>/\\\"\'");
	
		DebugMan.log("!@#$%^&*(){}[]<><hi>/\\\"\'",
				DebugMan.LEVEL_INFO,
				0, 
				DebugMan.TEXT_STYLE_BOLD_ITALIC_UNDERLINE, 
				0x0000FF, 
				[0xFF8080,0xFFFF00,0x00FF00]);
	}
	
	
	
	

}

}