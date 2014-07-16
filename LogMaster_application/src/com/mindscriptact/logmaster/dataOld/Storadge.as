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
package com.mindscriptact.logmaster.dataOld {
import com.mindscriptact.logmaster.dataOld.message.MessageData;
import com.mindscriptact.logmaster.dataOld.settings.Settings;
import com.mindscriptact.logmaster.event.MessageEvent;
import com.mindscriptact.logmaster.event.TabEvent;

import flash.events.EventDispatcher;
import flash.utils.Dictionary;

/**
 * Data storadge for aplication.
 * Parses data units, stores state, store all messages, graf(if any), watch(if any) data.
 * Dispaches events on state change, on new data.
 * TODO : split state,parsing and all messages to separate classes? (evaluate porformance cost of this refactor.)
 * @author Deril
 */
public class Storadge extends EventDispatcher {
	static private var instance:Storadge;

	/** Number of active(alive) clients. */
	private var _clientCount:int = 0;


	/** Dictienary that contains tab data by id. */
	private var tabDataStore:Dictionary = new Dictionary();
	/** of TabData by int. */

	/** Stores tab id, witch is used for client outputs as fefault */
	private var clientTargetTab:Dictionary = new Dictionary();
	/** of int by int */

	/** Defines witch tabs is disabled. */
	private var disabledTabs:Dictionary = new Dictionary();
	/** of Boolean by int */

	/** App settings. */
	private var settings:Settings = Settings.getInstance();

	private var _activeTabId:int = 0;

	public function Storadge():void {
		if (instance) {
			throw Error("Error: Instantiation failed: this class ment to be initiated only once.(By main class.)");
		}
		instance = this;
	}

	/**
	 *
	 */
	public function init():void {
		createTab(0, "LogMaster76K");
	}

	/**
	 *
	 */
	public function registerClient(clientId:int):void {
		_clientCount++;
		clientTargetTab[clientId] = 0;
	}

	/**
	 *
	 */
	public function killClient(clientId:int):void {
		_clientCount--;
		delete clientTargetTab[clientId];
	}

	public function get clientCount():int {
		return _clientCount;
	}

	public function get activeTabId():int {
		return _activeTabId;
	}

	// TODO : think if its needed to merge these 2 functions into 1, or separate compleatly.
	private function createTab(tabId:int, tabTitle:String = ""):void {
		if (!disabledTabs[tabId]) {
			//trace("Storadge.createTab > tabId : " + tabId + ", tabTitle : " + tabTitle);
			tabDataStore[tabId] = new TabData();
			dispatchEvent(new TabEvent(TabEvent.TAB_CREATE, tabId, tabTitle));
		}
	}

	private function renameTab(tabId:int, tabTitle:String):void {
		if (!disabledTabs[tabId]) {
			//trace("Storadge.renameTab > tabId : " + tabId + ", tabTitle : " + tabTitle);
			if (!tabDataStore[tabId]) {
				tabDataStore[tabId] = new TabData();
				dispatchEvent(new TabEvent(TabEvent.TAB_CREATE, tabId, tabTitle));
			} else {
				dispatchEvent(new TabEvent(TabEvent.TAB_RENAME, tabId, tabTitle));
			}
		}
	}

	private function removeTab(tabId:int):void {
		//trace("Storadge.removeTab > tabId : " + tabId);
		if (tabDataStore[tabId]) {
			tabDataStore[tabId].dispose();
			delete tabDataStore[tabId];
			dispatchEvent(new TabEvent(TabEvent.TAB_REMOVE, tabId));
			// refactor, open next, not defoult tab
		}
		if (_activeTabId == tabId) {
			openTab(0);
		}
	}

	public function showAppMessage(data:String):void {
		//trace("Storadge.showAppMessage > data : " + data);
		var messageData:MessageData = new MessageData();
		messageData.msgText = Vector.<String>([data]);
		tabDataStore[0].log.push(messageData);

		if (_activeTabId == 0) {
			dispatchEvent(new TabEvent(TabEvent.TAB_CHANGE, 0));
			dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[0].log));
		}
	}

	public function showDebugAppMessage(data:String, debugId:int = 0):void {
		//trace("Storadge.showAppMessage > data : " + data);
		var messageData:MessageData = new MessageData();
		messageData.msgText = Vector.<String>(data.split("\n"));

		var debugTabId:int = int.MAX_VALUE - 100 - debugId;

		if (!tabDataStore[debugTabId]) {
			if (debugId == 1) {
				createTab(debugTabId, "[-UNCAUGHT_ERROR-]");
			} else {
				createTab(debugTabId, "[-SELF-DEBUG-]");
			}
		}

		if (!tabDataStore[debugTabId]) {
			createTab(debugTabId, "SELF-DEBUG");
		}
		tabDataStore[debugTabId].log.push(messageData);

		if (_activeTabId == debugTabId) {
			dispatchEvent(new TabEvent(TabEvent.TAB_CHANGE, debugTabId));
			dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[debugTabId].log));
		}
	}

	/**
	 *
	 */
	public function parseTextData(clientId:int, data:String):void {
		//trace(">>>Storadge.parseTextData > clientId : " + clientId + ", data : " + data);
		var messageData:MessageData = new MessageData();
		messageData.msgText = Vector.<String>([data]);
		tabDataStore[clientTargetTab[clientId]].log.push(messageData);

		if (_activeTabId == clientTargetTab[clientId]) {
			dispatchEvent(new TabEvent(TabEvent.TAB_CHANGE, _activeTabId));
			dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[_activeTabId].log));
		}
	}

	/**
	 *
	 */
	public function parseMessageData(clientId:int, data:String):void {
		//trace(">>>Storadge.parseMessageData > clientId : " + clientId + ", data : " + data);
		var messageData:MessageData = new MessageData();
		var xmlData:XML = new XML(data);

		if (xmlData.@tabid == undefined || !disabledTabs[int(xmlData.@tabid)]) {

			var targetTabId:int = clientTargetTab[clientId];

			// parse parameters.
			if (xmlData.@type != undefined && xmlData.@type != "") {
				////trace("xmlData.@type : " + xmlData.@type);
				messageData.level = settings.getLevelByType(xmlData.@type);
			}

			if (xmlData.@level != undefined && xmlData.@level != "") {
				////trace("xmlData.@level : " + xmlData.@level);
				messageData.level = xmlData.@level;
			}

			if (xmlData.@bold == undefined && xmlData.@italic == undefined && xmlData.@underline == undefined) {
				messageData.typeCode = settings.getTextStyleCode(messageData.level);
			} else {
				messageData.setBldItlUnd((xmlData.@bold != undefined && xmlData.@bold != "" && xmlData.@bold != "0" && xmlData.@bold != "false"), //
						(xmlData.@italic != undefined && xmlData.@italic != "" && xmlData.@italic != "0" && xmlData.@italic != "false"), //
						(xmlData.@underline != undefined && xmlData.@underline != "" && xmlData.@underline != "0" && xmlData.@underline != "false") //
				);
			}

			if (xmlData.@color != undefined && xmlData.@color != "") {
				if (xmlData.@color.charAt(0) == "#") {
					messageData.textColor = uint("0x" + xmlData.@color.substring(1));
				} else {
					messageData.textColor = uint(xmlData.@color);
				}
			} else {
				// set default for level setting.
				messageData.textColor = settings.getTextColor(messageData.level);
			}

			if (xmlData.@bgcolor != undefined && xmlData.@bgcolor != "") {
				var tempData:Array = xmlData.@bgcolor.split(",");
				messageData.bgColors = new Vector.<uint>();

				for (var i:int = 0; i < tempData.length; i++) {
					if (tempData[i].charAt(0) == "#") {
						messageData.bgColors.push(uint("0x" + tempData[i].substring(1)));
					} else {
						messageData.bgColors.push(uint(tempData[i]));
					}
				}
			} else {
				messageData.bgColors = settings.getBgColor(messageData.level);
			}

			if (xmlData.@tabid != null && xmlData.@tabid != "") {
				targetTabId = int(xmlData.@tabid);

				if (tabDataStore[targetTabId] == null) {
					createTab(targetTabId);
				}
			}
			// set message text.
			// todo : if message has new lines - create foldable message.
			// temporal soliution for foldable messages - create more of same message.
			var breakPoint:int = 0;
			var messageLeftText:String = xmlData;
			var messagePartText:String;
			messageData.msgText = new Vector.<String>();

			while (breakPoint >= 0) {
				breakPoint = messageLeftText.indexOf("\n");

				// TODO : maybe imlement <br> for message break also ???
				if (breakPoint == -1) {
					messagePartText = messageLeftText
				} else {
					messagePartText = messageLeftText.substring(0, breakPoint);
					messageLeftText = messageLeftText.substring(breakPoint + 1);
				}
				messageData.msgText.push(messagePartText);

			}
			tabDataStore[targetTabId].log.push(messageData);

			if (_activeTabId == targetTabId) {
				dispatchEvent(new TabEvent(TabEvent.TAB_CHANGE, _activeTabId));
				dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[_activeTabId].log));
			}
		}
	}

	public function parseCommandData(clientId:int, data:String):void {
		//trace(">>>Storadge.parseCommandData > data : " + data);
		var xmlData:XML = new XML(data);
		var tabId:int;
		var name:String;

		switch (xmlData.toString()) {
			case Commands.SET_TARGET_TAB:
				tabId = int(xmlData.@tabId);
				name = unescape(xmlData.@name)
				if (tabDataStore[tabId] == null) {
					createTab(tabId, name);
				}
				clientTargetTab[clientId] = tabId;
				break;
			case Commands.RENAME_TAB:
				tabId = int(xmlData.@tabId);
				name = unescape(xmlData.@name)
				renameTab(tabId, name);
				break;
			case Commands.ENABLE_TABS:
				enableTabs(String(xmlData.@tabIds).split(","));
				break;
			case Commands.DISABLE_TABS:
				disableTabs(String(xmlData.@tabIds).split(","));
				break;
			default:
				showAppMessage("WARNING : Unknown command : " + xmlData.toString())
				break;
		}
	}

	/**
	 *
	 */
	public function openTab(tabId:int):void {
		//trace("Storadge.openTab > tabId : " + tabId);
		if (_activeTabId != tabId) {
			_activeTabId = tabId;
			dispatchEvent(new TabEvent(TabEvent.TAB_CHANGE, _activeTabId));
			dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[_activeTabId].log));
		}
	}

	/**
	 *
	 */
	public function closeTab(tabId:int):void {
		//trace("Storadge.openTab > tabId : " + tabId);
		if (_activeTabId != 0) {
			removeTab(tabId);
		}
	}

	private function disableTabs(tabIds:Array):void {
		//trace("Storadge.disableTabs > tabIds : " + tabIds);
		for (var i:int = 0; i < tabIds.length; i++) {
			var tabId:int = int(tabIds[i]);
			if (tabId) {
				disabledTabs[tabId] = true;
			}
		}
	}

	private function enableTabs(tabIds:Array):void {
		//trace("Storadge.enableTabs > tabIds : " + tabIds);
		for (var i:int = 0; i < tabIds.length; i++) {
			var tabId:int = int(tabIds[i]);
			if (tabId) {
				disabledTabs[tabId] = false;
				closeTab(tabId);
			}
		}
	}

	public function getActiveTabText():String {
		var retVal:String = "";
		var log:Vector.<MessageData> = tabDataStore[_activeTabId].log;
		for (var textId:int = 0; textId < log.length; textId++) {
			// TODO : check if ending MUST be handled with diferent OS.
			// TODO : chex how this porforms to copy big amounts of daat. limit it at reasonable point if needed. (copy only last X lines...)
			var sublineCount:int = log[textId].msgText.length;
			for (var subLine:int = 0; subLine < sublineCount; subLine++) {
				retVal += log[textId].msgText[subLine] + "\r\n";
			}
		}
		return retVal;
	}

	public function getLineText(textId:int):String {
		var retVal:String = "";
		var log:Vector.<MessageData> = tabDataStore[_activeTabId].log;
		if (log[textId]) {
			var sublineCount:int = log[textId].msgText.length;
			for (var subLine:int = 0; subLine < sublineCount; subLine++) {
				retVal += log[textId].msgText[subLine] + "\r\n";
			}
		}
		return retVal;
	}

	public function clearCurrentTab():void {
		tabDataStore[_activeTabId].log = Vector.<MessageData>([]);
		dispatchEvent(new MessageEvent(MessageEvent.MESSAGE_UPDATE, tabDataStore[_activeTabId].log));
	}


}
}