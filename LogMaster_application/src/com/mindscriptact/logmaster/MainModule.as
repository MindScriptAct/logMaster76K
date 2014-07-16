package com.mindscriptact.logmaster {
import com.mindscriptact.logmaster.controller.errorHandling.HandleUncaughtErrorCommand;
import com.mindscriptact.logmaster.core.StageMediator;
import com.mindscriptact.logmaster.core.StageRenderMediator;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.messages.Message;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.model.storadge.StorageProxy;
import com.mindscriptact.logmaster.net.ConnectionManager;

import flash.display.Stage;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import mvcexpress.modules.ModuleCore;

/**
 * ...
 * @author Deril
 */
public class MainModule extends ModuleCore {

	private var connectionMan:ConnectionManager;
	private var appStage:Stage;
	private var myTextField:TextField;

	override protected function onInit():void {

		// setUp controller
		commandMap.map(Message.UNCAUGHT_ERROR, HandleUncaughtErrorCommand);

	}

	public function start(main:Main):void {

		//trace("StartupCommand.execute");
		this.appStage = main.stage;

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
		mediatorMap.mediateWith(main, StageMediator);
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
		myTextField.text = 'CLICK ANYWHERE TO START!!!!';
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

	private function startServer(event:MouseEvent):void {
		connectionMan.startIt();
		appStage.removeEventListener(MouseEvent.CLICK, startServer);
		appStage.removeChild(myTextField);
		appStage = null;
		myTextField = null;
		connectionMan = null;
	}
}
}