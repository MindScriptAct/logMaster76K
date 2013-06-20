package com.mindscriptact.logmaster {
import com.mindscriptact.logmaster.controller.core.StartupCommand;
import org.puremvc.as3.interfaces.IFacade;
import org.puremvc.as3.patterns.facade.Facade;

/**
 * ...
 * @author Deril
 */
public class ApplicationFacade extends Facade implements IFacade {


	public static function getInstance():ApplicationFacade {
		if (instance == null)
			instance = new ApplicationFacade();
		return instance as ApplicationFacade;
	}

	// Register commands with the controller
	override protected function initializeController():void {
		super.initializeController();
		registerCommand(Note.STARTUP, StartupCommand);
	}

	/**
	 * Starts application.
	 * @param	stage
	 */
	public function startup(stage:Object):void {
		sendNotification(Note.STARTUP, stage);
		removeCommand(Note.STARTUP);
	}
}
}