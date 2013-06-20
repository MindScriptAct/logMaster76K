/*
   Simple Command - PureMVC
 */
package com.mindscriptact.logmaster.controller.core {
import com.mindscriptact.logmaster.controller.app.SaveToClipboardCommand;
import com.mindscriptact.logmaster.core.AppManager;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.model.storadge.StoradgeProxy;
import com.mindscriptact.logmaster.net.ConnectionManager;
import com.mindscriptact.logmaster.Note;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;
import org.puremvc.as3.patterns.observer.Notification;

/**
 * SimpleCommand
 */
public class StartupCommand extends SimpleCommand {
	private var connectionMan:ConnectionManager;
	private var appStage:Stage;
	private var myTextField:TextField;

	override public function execute(note:INotification):void {
		
		//trace("StartupCommand.execute");
		
		appStage = note.getBody() as Stage;
		
		// Register proxies.
		facade.registerProxy(new AppProxy());
		facade.registerProxy(new StoradgeProxy());
		
		
		// Register mediators.
		
		AppManager
		
		
		// init application.
		
		
		
		/** Aplication state and data holder. */
		// create data storadge.
		var dataStore:Storadge = new Storadge();

		/** Aplication manager, (OS stuff..) */
		// init app handling..
		var appMan:AppManager = new AppManager(appStage, dataStore);
		facade.registerMediator(appMan);
		// init storadge;
		dataStore.init();

		/** Socket conection handling */
		// establish connection manager.
		connectionMan = new ConnectionManager(dataStore);
		//
		
		myTextField = new TextField();
		appStage.addChild(myTextField);
		myTextField.text = 'CLICK ANYTHERE TO START!!!!';
		myTextField.x = (appStage.stageWidth >> 1) - 200;
		myTextField.y = (appStage.stageHeight >> 1) - (myTextField.height >> 1);
		myTextField.mouseEnabled = false;
		myTextField.width = 400;
		
		var newFormat:TextFormat = new TextFormat();
		newFormat.size = 20;
		newFormat.font = 'Verdana';
		
		myTextField.setTextFormat(newFormat);
		
		
		facade.registerCommand(Note.SEND_TO_CLIPBOARD, SaveToClipboardCommand);
		
		appStage.addEventListener(MouseEvent.CLICK, startServer);
	}
	
	private function startServer(e:MouseEvent):void {
		connectionMan.startIt();
		appStage.removeEventListener(MouseEvent.CLICK, startServer);
		appStage.removeChild(myTextField);
		appStage = null;
		myTextField = null;
		connectionMan = null;
	}

}
}