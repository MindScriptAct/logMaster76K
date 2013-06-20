package com.mindscriptact.logmaster.view.app {
import flash.display.Stage;
import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;
import com.mindscriptact.logmaster.view.app.*;

/**
 * COMMENT
 * @author Deril
 */
public class AppMediator extends Mediator implements IMediator {

	// Cannonical name of the Mediator
	public static const NAME:String = "AppMediator";
	
	public function AppMediator(viewComponent:Stage) {
		// pass the viewComponent to the superclass where 
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);
	}

	
	/**
	 * List all notifications this Mediator is interested in.
	 * <P>
	 * Automatically called by the framework when the mediator
	 * is registered with the view.</P>
	 * 
	 * @return Array the list of Nofitication names
	 */
	override public function listNotificationInterests():Array {
		return [];
	}

	/**
	 * Handle all notifications this Mediator is interested in.
	 * <P>
	 * Called by the framework when a notification is sent that
	 * this mediator expressed an interest in when registered
	 * (see <code>listNotificationInterests</code>.</P>
	 * 
	 * @param INotification a notification 
	 */
	override public function handleNotification(note:INotification):void {
		switch (note.getName()) {           
			default:
				break;		
		}
	}

}
}
