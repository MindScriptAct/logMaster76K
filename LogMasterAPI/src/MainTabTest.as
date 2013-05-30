package {
import com.mindscriptact.logmaster.DebugMan;
import com.mindscriptact.logmaster.LogMan;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


/**
 * ...
 * @author ...
 */
public class MainTabTest extends Sprite {
	private var testVar:int = 0;
	
	static private var log:LogMan = new LogMan("TabTest",2);

	public function MainTabTest() {		
		
		DebugMan.disableTabs([1, 3, 4, 5]);
		
		DebugMan.enableTabs([4]);
		
		// enable these only.
		//DebugMan.useTabs([1, 3, 4, 5]);
		
		
		
		DebugMan.renameTab(1, "Tab 1!!");
		DebugMan.renameTab(2, "Tab 2!!");
		DebugMan.renameTab(3, "Tab 3!!");
		DebugMan.renameTab(4, "Tab 4!!");
		DebugMan.renameTab(5, "Tab 5!!");
		DebugMan.renameTab(6, "Tab 6!!");
		
		log.debugTo(1, "Imagine trace message here...  [1] ");
		log.debugTo(2, "Imagine trace message here...  [2] ");
		log.debugTo(3, "Imagine trace message here...  [3] ");
		log.debugTo(4, "Imagine trace message here...  [4] ");
		log.debugTo(5, "Imagine trace message here...  [5] ");
		log.debugTo(6, "Imagine trace message here...  [6] ");
		
	}

}

}