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
package com.mindscriptact.logmaster.viewOld {
import com.mindscriptact.logmaster.core.StageMediator;
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.viewOld.components.LeverFilters;
import com.mindscriptact.logmaster.viewOld.components.TabButton;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Visual element to handle tabs.
 * @author Derilas
 */
public class TabPane extends Sprite {
	private var posShift:int = 0;

	private var dataStore:Storadge;

	private var titleBar:WindowTitleBarSPR = new WindowTitleBarSPR();

	private var closeTabButton:TabCloseUpSPR;

	private var levelFilters:LeverFilters;

	private var tabs:Vector.<TabButton> = new Vector.<TabButton>();

	private var closeButton:CloseBTN = new CloseBTN();

	CONFIG::debug
	private var debugButton:CloseBTN = new CloseBTN();

	public var paneWidth:int = 800;

	public var paneHeight:int = 30;

	public function TabPane(dataStore:Storadge) {
		this.dataStore = dataStore;

		this.addChild(titleBar);
		titleBar.addEventListener(MouseEvent.MOUSE_DOWN, handleWindowMove);


		closeTabButton = new TabCloseUpSPR();
		this.addChild(closeTabButton);
		closeTabButton.visible = false;
		closeTabButton.mouseEnabled = false;
		closeTabButton.useHandCursor = true;
		//
		addChild(closeButton);
		closeButton.addEventListener(MouseEvent.CLICK, handleCloseaApp);


		CONFIG::debug {
			addChild(debugButton);
			debugButton.addEventListener(MouseEvent.CLICK, handleDebugSocket);
		}

		levelFilters = new LeverFilters();
		addChild(levelFilters);

	}

	private function handleWindowMove(event:MouseEvent):void {
		StageMediator.startMove();
	}

	/**
	 * Handle app resize.
	 * @param    windowWidth
	 * @param    windowHeigth
	 */
	public function resize(windowWidth:int, windowHeight:int):void {
		this.paneWidth = windowWidth;
		//implement
		titleBar.width = paneWidth;
		//
		closeButton.x = windowWidth - 20 - 5;
		closeButton.y = 5;
		//
		CONFIG::debug {
			debugButton.rotation = 45;
			debugButton.x = closeButton.x - 20;
			debugButton.y = 5;
		}

		//
		levelFilters.x = windowWidth - 20 - 5 - 10 - levelFilters.width;
		levelFilters.y = 14;

	}

	/**
	 * Create now tab.
	 */
	public function createTab(tabId:int, titleName:String):void {
		////trace("TabPane.createTab > tabId : " + tabId + ", titleName : " + titleName);
		var tab:TabButton = new TabButton(tabId, titleName);
		this.addChild(tab);
		tabs.push(tab);
		this.setChildIndex(closeTabButton, this.numChildren - 1);
		// TODO : refactor
		tab.x = posShift;
		tab.y = 10;
		posShift += 100;
		tab.mouseChildren = false;
		tab.addEventListener(MouseEvent.CLICK, handleTabClick);
		tab.addEventListener(MouseEvent.MOUSE_OVER, handleTabMouseOver);
		tab.addEventListener(MouseEvent.MOUSE_OUT, handleTabMouseOut);
		// TODO : add mouse like behaviour.
	}

	/**
	 * rename tab.
	 */
	public function renameTab(tabId:int, titleName:String):void {
		////trace("TabPane.renameTab > tabId : " + tabId + ", titleName : " + titleName);

		for each (var value:TabButton in tabs) {
			if (value.id == tabId) {
				value.setTitle(titleName);
			}
		}
	}

	private function handleTabClick(event:Event):void {
		//trace("TabPane.handleTabClick > id : " + (event.target as TabButton).id);
		var tabId:int = (event.target as TabButton).id

		if ((tabId == dataStore.activeTabId) && closeTabButton.hitTestPoint(this.mouseX, this.mouseY)) {
			dataStore.closeTab(tabId);
		} else {
			dataStore.openTab(tabId);

			if (tabId != 0) {
				showTabcloseTabButtonAt(event.target as TabButton);
			}
		}
	}

	private function handleTabMouseOut(event:MouseEvent):void {
		////trace("TabPane.handleTabMouseOut > event : " + event);
		closeTabButton.visible = false;
		closeTabButton.x = -1000;
	}

	private function handleTabMouseOver(event:MouseEvent):void {
		////trace("TabPane.handleTabMouseOver > event : " + event);
		var tabId:int = (event.target as TabButton).id;

		if (tabId != 0 && tabId == dataStore.activeTabId) {
			showTabcloseTabButtonAt(event.target as TabButton);
		}
	}

	/**
	 *
	 */
	public function showTabcloseTabButtonAt(tabButton:TabButton):void {
		closeTabButton.x = tabButton.x + tabButton.width - 20;
		closeTabButton.y = tabButton.y + tabButton.height - 20;
		closeTabButton.visible = true;
	}

	/**
	 * Removes tab.
	 */
	public function removeTab(tabId:int):void {
		//trace("TabPane.removeTab > tabId : " + tabId);
		// TODO : implement
		var tabDeleted:Boolean = false;

		for (var i:int = 0; i < tabs.length; i++) {
			if (!tabDeleted) {
				if (tabs[i].id == tabId) {
					this.removeChild(tabs[i]);
					tabs[i].dispose();
					tabs.splice(i, 1);
					tabDeleted = true;
					posShift -= 100;
					i--;
				}
			} else {
				tabs[i].x -= 100;
			}
		}
	}

	private function handleCloseaApp(event:MouseEvent):void {
		//this.stage.root
		StageMediator.closeApp();
	}

	/**
	 * Make tab active.
	 */
	public function activateTab(tabId:int):void {
		for (var i:int = 0; i < tabs.length; i++) {
			if (tabs[i].id == tabId) {
				tabs[i].changeState(TabButton.STATE_ACTIVE);
			} else {
				tabs[i].changeState(TabButton.STATE_PASSIVE);
			}
		}
	}

	CONFIG::debug
	private function handleDebugSocket(event:MouseEvent):void {
		StageMediator.debugSocketStatus();

		//throw Error("uncaught error test...");
	}
}
}