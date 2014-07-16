package com.mindscriptact.logmaster.controller.errorHandling {
import com.mindscriptact.logmaster.model.storadge.StorageProxy;

import flash.events.UncaughtErrorEvent;

import mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class HandleUncaughtErrorCommand extends Command {

	[Inject]
	public var storageProxy:StorageProxy;

	public function execute(event:UncaughtErrorEvent):void {
//		if (event.error is Error) {
//			var error:Error = event.error as Error;
//			// do something with the error
//			storageProxy.showDebugAppMessage(error.message, 1);
//		} else if (event.error is ErrorEvent) {
//			var errorEvent:ErrorEvent = event.error as ErrorEvent;
//			// do something with the error
//			storageProxy.showDebugAppMessage(errorEvent.toString(), 1);
//		} else {
//			// a non-Error, non-ErrorEvent type was thrown and uncaught
//			storageProxy.showDebugAppMessage(event.error.toString(), 1);
//		}
		// trace stack..
		var stackTrace:String = event.error.getStackTrace();
		storageProxy.showDebugAppMessage(stackTrace, 1);
	}

}
}
