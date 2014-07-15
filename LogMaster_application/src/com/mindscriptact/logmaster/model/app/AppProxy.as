package com.mindscriptact.logmaster.model.app {
import com.mindscriptact.logmaster.messages.Message;

import mvcexpress.mvc.Proxy;

/**
 * A proxy
 */
public class AppProxy extends Proxy {

	public static const NAME:String = "AppProxy";


	private var _appWidth:int = 0;
	private var _appHeight:int = 0;


	//----------------------------------
	//     App size
	//----------------------------------

	public function changeWindowSize(appWidth:int, appHeight:int):void {
		_appWidth = appWidth;
		_appHeight = appHeight;
		sendMessage(Message.RESIZE_APP);
	}

	public function get appWidth():int {
		return _appWidth;
	}

	public function get appHeight():int {
		return _appHeight;
	}

}
}