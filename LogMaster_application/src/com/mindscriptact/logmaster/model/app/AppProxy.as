package com.mindscriptact.logmaster.model.app {
import com.mindscriptact.logmaster.Note;
import org.puremvc.as3.interfaces.IProxy;
import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * A proxy
 */
public class AppProxy extends Proxy implements IProxy {

	public static const NAME:String = "AppProxy";


	private var _appWidth:int = 0;
	private var _appHeight:int = 0;


	public function AppProxy(){
		super(NAME);
	}

	//----------------------------------
	//     App size
	//----------------------------------

	public function changeWindowSize(appWidth:int, appHeight:int):void {
		_appWidth = appWidth;
		_appHeight = appHeight;
		sendNotification(Note.RESIZE_APP);
	}
	
	public function get appWidth():int {
		return _appWidth;
	}

	public function get appHeight():int {
		return _appHeight;
	}
	
}
}