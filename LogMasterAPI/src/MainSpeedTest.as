package {
//import com.hexagonstar.util.debug.Debug;
import com.mindscriptact.logmaster.DebugMan;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


/**
 * speed test.
 * @author Deril
 */
public class MainSpeedTest extends Sprite {

	private var tracePerFrame:int = 0;
	private var sheepCount:int = 0;

	public function MainSpeedTest(){
		this.stage.addEventListener(MouseEvent.CLICK, handleClick);
		this.stage.addEventListener(Event.ENTER_FRAME, handleTick)


	}

	private function handleTick(event:Event):void {

		for (var i:int = 0; i < tracePerFrame; i++){
			sheepCount++;
			trace(sheepCount + " white sheep jumped over " + sheepCount + " black wolves...");
			DebugMan.debug(sheepCount + " white sheep jumped over " + sheepCount + " black wolves...");
			//Debug.trace(sheepCount + " white sheep jumped over " + sheepCount + " black wolves...");
		}
	}

	private function handleClick(event:MouseEvent):void {
		tracePerFrame++;
		if (tracePerFrame > 5) {
			tracePerFrame = 5;
		}
	}

}

}