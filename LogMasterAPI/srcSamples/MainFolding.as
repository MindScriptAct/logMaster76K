package {
import mindscriptact.logmaster.DebugMan;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


/**
 * show diferent message types - 5 defalt + custom..
 * @author Deril
 */
public class MainFolding extends Sprite {

	private var messageId:int = 0;

	public function MainFolding(){

		this.stage.addEventListener(MouseEvent.CLICK,testTrace)

		testTrace();
	}

	private function testTrace(event:Event = null):void {
		messageId++;
		DebugMan.info(messageId+":Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ut aliquam diam. Aenean viverra ultrices nisi eget vulputate. Cras feugiat massa ut est aliquam pharetra non sed nibh. Curabitur aliquam ultrices ante at scelerisque. Suspendisse convallis mauris eu ante malesuada at pellentesque orci pulvinar. Fusce sed lectus eget augue fermentum aliquet sed ac diam. Vivamus urna lacus, semper a fringilla et, interdum eget justo. Donec ac massa lorem. Proin nec nibh at est placerat rhoncus. Nam sit amet metus mi, sit amet rutrum felis. Curabitur bibendum dolor sed lectus auctor quis scelerisque elit viverra.\nDonec purus massa, condimentum ac hendrerit vel, commodo in lectus. Donec sit amet viverra elit. Mauris elementum nibh ut velit consectetur porta. Sed facilisis, mauris eu condimentum accumsan, nisl lacus adipiscing turpis, nec dignissim neque est in mi. Quisque eros tellus, elementum vitae malesuada id, lacinia ut sapien. Etiam imperdiet odio a nibh dictum sit amet ultricies lectus luctus. Mauris ac ullamcorper enim. Ut sit amet condimentum velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Quisque molestie dui in tellus blandit porta. Aenean condimentum ullamcorper velit. Mauris eleifend elit vitae orci pretium non commodo augue sagittis. Aenean faucibus congue mi sed elementum. Proin vitae tristique purus. Proin lacus massa, malesuada a aliquam eget, mollis vitae purus. Nullam fringilla magna a augue aliquet bibendum. Sed euismod neque vel nisl malesuada vulputate.");
		DebugMan.info(messageId+":##################\nWe aren't in an \ninformation age 1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,\n we are in an \nentertainment age..2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222");
	}
}

}