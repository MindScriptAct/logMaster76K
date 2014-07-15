/*********************************************************************
 *  Copyright (C) 2010 by Raimundas Banevicius (raima156@yahoo.com)
 *
 *
 *    This file is part of LogMaster76K.
 *
 *    LogMaster76K is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    LogMaster76K is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with LogMaster76K.  If not, see <http://www.gnu.org/licenses/>.
 *
 *********************************************************************/
package com.mindscriptact.logmaster.core {
import com.mindscriptact.logmaster.Note;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.net.ConnectionManager;

import flash.desktop.NativeApplication;
import flash.display.Stage;
import flash.events.InvokeEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.System;
import flash.ui.Keyboard;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * Manages aplication actions. (os specific - resize, close and such. )
 * @author Deril
 */
public class AppManager extends Mediator {

	public static const NAME:String = "AppManager";
	//
	private var appProxy:AppProxy;

	/** */
	static private var app:NativeApplication;

	static private var dataStore:Storadge;

	static private var render:Render;


	public function AppManager(appStage:Stage, dataStore:Storadge):void {
		super(NAME);
		if (AppManager.render) {
			throw new Error("Error: Instantiation failed: Create AppManager only once.");
		}

		// init renderer
		AppManager.render = new Render(appStage, dataStore);
		facade.registerMediator(AppManager.render);

		AppManager.dataStore = dataStore;
		AppManager.app = NativeApplication.nativeApplication;
		AppManager.app.addEventListener(InvokeEvent.INVOKE, handleResize);

		appStage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		appStage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		appStage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheelEvent);
	}

	override public function listNotificationInterests():Array {
		return [];
	}

	override public function handleNotification(note:INotification):void {
		switch (note.getName()) {
			default:
				break;
		}
	}

	override public function onRegister():void {
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
	}

	private function handleResize(event:InvokeEvent):void {
		if (app.activeWindow) {
			appProxy.changeWindowSize(app.activeWindow.width, app.activeWindow.height);
		}
	}

	/**
	 * Handle closing.
	 */
	static public function closeApp():void {
		AppManager.app.exit();
	}

	/**
	 * Handle resize.
	 * @param    resizeMode
	 */
	static public function startResize(resizeMode:String):void {
		AppManager.app.activeWindow.startResize(resizeMode);
	}

	/**
	 * Handle app window move.
	 */
	static public function startMove():void {
		AppManager.app.activeWindow.startMove();
	}

	static public function sendToClipboard(text:String):void {
		System.setClipboard(text);
	}

	// TODO : think about better place for key handling.
	private function handleKeyUp(event:KeyboardEvent):void {
		// TODO : add option to trace key codes, as an option, available for activation from menu.
		//trace(event.keyCode);
		switch (event.keyCode) {
			case Keyboard.A:
				if (event.ctrlKey) {
					sendToClipboard(dataStore.getActiveTabText());
				}
				break;
			case Keyboard.DELETE:
				dataStore.clearCurrentTab();
				break;
				break;
		}
	}

	private function handleKeyDown(event:KeyboardEvent):void {
		// TODO : add option to trace key codes, as an option, available for activation from menu.
		//trace(event.keyCode);
		switch (event.keyCode) {
			case Keyboard.UP:
				if (event.shiftKey) {
					sendNotification(Note.SCROLL_THIRD_UP);
				} else if (event.ctrlKey) {
					sendNotification(Note.SCROLL_LINE_UP);
				} else {
					sendNotification(Note.SCROLL_FAST_SCROLL_UP);
				}
				break;
			case Keyboard.DOWN:
				if (event.shiftKey) {
					sendNotification(Note.SCROLL_THIRD_DOWN);
				} else if (event.ctrlKey) {
					sendNotification(Note.SCROLL_LINE_DOWN);
				} else {
					sendNotification(Note.SCROLL_FAST_SCROLL_DOWN);
				}
				break;
		}
	}

	private function handleMouseWheelEvent(event:MouseEvent):void {
		if (event.delta > 0) {
			if (event.shiftKey) {
				sendNotification(Note.SCROLL_THIRD_UP);
			} else if (event.ctrlKey) {
				sendNotification(Note.SCROLL_LINE_UP);
			} else {
				sendNotification(Note.SCROLL_FAST_SCROLL_UP);
			}
		} else {
			if (event.shiftKey) {
				sendNotification(Note.SCROLL_THIRD_DOWN);
			} else if (event.ctrlKey) {
				sendNotification(Note.SCROLL_LINE_DOWN);
			} else {
				sendNotification(Note.SCROLL_FAST_SCROLL_DOWN);
			}
		}
	}


	CONFIG::debug
	static private var connectionMan:ConnectionManager;

	CONFIG::debug
	public function debug_setConnectionMan(connectionMan:ConnectionManager):void {
		AppManager.connectionMan = connectionMan;
	}

	CONFIG::debug
	public static function debugSocketStatus():void {
		var socketStatus:String = connectionMan.getSocketStatus()
		var statusSplit:Array = socketStatus.split("\n");
		for (var i:int = 0; i < statusSplit.length; i++) {
			dataStore.showDebugAppMessage(statusSplit[i]);
		}
	}
}
}