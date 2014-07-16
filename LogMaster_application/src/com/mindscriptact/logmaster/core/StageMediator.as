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
import com.mindscriptact.logmaster.Main;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.messages.Message;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.model.storadge.StorageProxy;
import com.mindscriptact.logmaster.net.ConnectionManager;

import flash.desktop.NativeApplication;
import flash.display.Stage;
import flash.events.InvokeEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.UncaughtErrorEvent;
import flash.system.System;
import flash.ui.Keyboard;

import mvcexpress.mvc.Mediator;

/**
 * Manages aplication actions. (os specific - resize, close and such. )
 * @author Deril
 */
public class StageMediator extends Mediator {

	[Inject]
	public var view:Main;

	[Inject]
	public var appProxy:AppProxy;

	/** */
	static private var app:NativeApplication;

	static private var dataStore:Storadge;

	CONFIG::debug
	public static var debug_connectionMan:ConnectionManager;


	override protected function onRegister():void {

		dataStore = (proxyMap.getProxy(StorageProxy) as StorageProxy).getDataStore();

		StageMediator.dataStore = dataStore;
		StageMediator.app = NativeApplication.nativeApplication;
		StageMediator.app.addEventListener(InvokeEvent.INVOKE, handleResize);

		view.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		view.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		view.stage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheelEvent);

		view.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, handleUncaughtError);
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
		StageMediator.app.exit();
	}

	/**
	 * Handle resize.
	 * @param    resizeMode
	 */
	static public function startResize(resizeMode:String):void {
		StageMediator.app.activeWindow.startResize(resizeMode);
	}

	/**
	 * Handle app window move.
	 */
	static public function startMove():void {
		StageMediator.app.activeWindow.startMove();
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
					sendMessage(Message.SCROLL_THIRD_UP);
				} else if (event.ctrlKey) {
					sendMessage(Message.SCROLL_LINE_UP);
				} else {
					sendMessage(Message.SCROLL_FAST_SCROLL_UP);
				}
				break;
			case Keyboard.DOWN:
				if (event.shiftKey) {
					sendMessage(Message.SCROLL_THIRD_DOWN);
				} else if (event.ctrlKey) {
					sendMessage(Message.SCROLL_LINE_DOWN);
				} else {
					sendMessage(Message.SCROLL_FAST_SCROLL_DOWN);
				}
				break;
		}
	}

	private function handleMouseWheelEvent(event:MouseEvent):void {
		if (event.delta > 0) {
			if (event.shiftKey) {
				sendMessage(Message.SCROLL_THIRD_UP);
			} else if (event.ctrlKey) {
				sendMessage(Message.SCROLL_LINE_UP);
			} else {
				sendMessage(Message.SCROLL_FAST_SCROLL_UP);
			}
		} else {
			if (event.shiftKey) {
				sendMessage(Message.SCROLL_THIRD_DOWN);
			} else if (event.ctrlKey) {
				sendMessage(Message.SCROLL_LINE_DOWN);
			} else {
				sendMessage(Message.SCROLL_FAST_SCROLL_DOWN);
			}
		}
	}

	private function handleUncaughtError(event:UncaughtErrorEvent):void {
		sendMessage(Message.UNCAUGHT_ERROR, event);
	}

	CONFIG::debug
	public static function debugSocketStatus():void {
		var socketStatus:String = debug_connectionMan.getSocketStatus()
		var statusSplit:Array = socketStatus.split("\n");
		for (var i:int = 0; i < statusSplit.length; i++) {
			dataStore.showDebugAppMessage(statusSplit[i]);
		}
	}
}
}