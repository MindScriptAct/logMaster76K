/*
 Simple Command - PureMVC
 */
package com.mindscriptact.logmaster.controller.core {
import com.mindscriptact.logmaster.core.StageMediator;
import com.mindscriptact.logmaster.core.StageRenderMediator;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.model.storadge.StorageProxy;
import com.mindscriptact.logmaster.net.ConnectionManager;

import flash.display.Stage;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import mvcexpress.mvc.Command;

/**
 * SimpleCommand
 */
public class StartupCommand extends Command {
	private var connectionMan:ConnectionManager;
	private var appStage:Stage;
	private var myTextField:TextField;

	public function execute(appStage:Stage):void {

		//trace("StartupCommand.execute");

		this.appStage = appStage;


		/** Aplication state and data holder. */
		// create data storadge.
		var dataStore:Storadge = new Storadge();

		// Register proxies.
		proxyMap.map(new AppProxy());
		proxyMap.map(new StorageProxy(dataStore));


		// Register mediators.
		//mediatorMap.map(AppManager, );

		//mediatorMap.map(Stage, StageMediator);

		// init application.


		/** Aplication manager, (OS stuff..) */
			// init app handling..
		mediatorMap.mediateWith(appStage, StageMediator);
		mediatorMap.mediateWith(appStage, StageRenderMediator);

		// init storadge;
		dataStore.init();

		/** Socket connection handling */
			// establish connection manager.
		connectionMan = new ConnectionManager(dataStore);
		//

		CONFIG::debug {
			StageMediator.debug_connectionMan = connectionMan;
		}

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