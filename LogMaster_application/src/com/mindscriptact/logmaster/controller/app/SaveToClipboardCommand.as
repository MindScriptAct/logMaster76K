package com.mindscriptact.logmaster.controller.app {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;
import org.puremvc.as3.patterns.observer.Notification;

/**
 * COMMENT
 * @author Deril
 */
public class SaveToClipboardCommand extends SimpleCommand {
	
	override public function execute(note:INotification):void {
		var messageId:int = note.getBody() as int;
		
		
	}
	
}
}