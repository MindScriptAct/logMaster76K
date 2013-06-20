package {
import mindscriptact.logmaster.DebugMan;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


/**
 * show diferent message types - 5 defalt + custom..
 * @author Deril
 */
public class MainBasics extends Sprite {

	public function MainBasics(){

		this.stage.addEventListener(MouseEvent.CLICK,testTrace)

		testTrace();


		DebugMan.debugTo(5,"...many people ask me how to use the secret debugging commands, apparently under the impression that I'll tell them.");
		DebugMan.infoTo(5,"We aren't in an information age, we are in an entertainment age..");
		DebugMan.warnTo(5,"If you can't be a good example, then you'll just have to serve as a horrible warning...”");
		DebugMan.errorTo(5,"Admitting Error clears the Score, And proves you Wiser than before.");
		DebugMan.fatalTo(5,"It is fatal to enter any war without the will to win it. ");

	}

	private function testTrace(event:Event = null):void {
		DebugMan.debug("...many people ask me how to use the secret debugging commands, apparently under the impression that I'll tell them.");
		DebugMan.info("We aren't in an information age, we are in an entertainment age..");
		DebugMan.warn("If you can't be a good example, then you'll just have to serve as a horrible warning...”");
		DebugMan.error("Admitting Error clears the Score, And proves you Wiser than before.");
		DebugMan.fatal("It is fatal to enter any war without the will to win it. ");

		DebugMan.log("Happiness is a choice that requires effort at times.",
				DebugMan.LEVEL_INFO,
				0,
				DebugMan.TEXT_STYLE_BOLD_ITALIC_UNDERLINE,
				0x0000FF,
				[0xFF8080,0xFFFF00,0x00FF00]);
	}





}

}