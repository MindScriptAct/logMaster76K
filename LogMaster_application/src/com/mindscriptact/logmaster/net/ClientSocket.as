﻿/*********************************************************************
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
package com.mindscriptact.logmaster.net {
import com.mindscriptact.logmaster.dataOld.Storadge;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.OutputProgressEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;

/**
 * Client socket.
 * Cuts incoming string to data units(message,graph,watch,commands) and sends to Storadge.
 * @author Deril
 */
public class ClientSocket extends EventDispatcher {
	static private var nextId:int = 0;

	//static private var EMPTY_DATA:DataUnit = new DataUnit();

	/** Unique id for socket connection. */
	private var _id:int = nextId++;

	/** Client socket */
	private var socket:Socket;

	/** Socket data that comes from server. With every data arival it will be tried to bo parsed. */
	private var data:String = ""

	/** Data staradge to send parsed messages and commands. */
	private var dataStore:Storadge;


	public function ClientSocket(socket:Socket, dataStore:Storadge):void {


		this.socket = socket;
		this.dataStore = dataStore;
		socket.addEventListener(Event.CONNECT, handleClientConnect);
		socket.addEventListener(Event.CLOSE, handleClientClose);

		socket.addEventListener(ProgressEvent.SOCKET_DATA, handleClientData);

		socket.addEventListener(IOErrorEvent.IO_ERROR, handleClientError);
		socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleClientError);


		CONFIG::debug {
			// debug stuff
			//socket.addEventListener(Event.ACTIVATE, handleSocketEvent)
			//socket.addEventListener(Event.DEACTIVATE, handleSocketEvent)
			//socket.addEventListener(Event.CLOSE, handleSocketEvent)
			//socket.addEventListener(Event.CONNECT, handleSocketEvent)
			socket.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, handleSocketEvent, false, 0, true);
			socket.addEventListener(IOErrorEvent.IO_ERROR, handleSocketEvent, false, 0, true);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSocketEvent, false, 0, true);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, handleSocketEvent, false, 0, true);

			dataStore.showDebugAppMessage("client connected.");

		}
	}

	private function handleSocketEvent(event:Event):void {
		//trace("ClientSocket.handleClientClose > "+event.type);
		if (dataStore) {
			dataStore.showDebugAppMessage("client event: " + event.type + " " + event);
		}
	}

	private function handleClientClose(event:Event):void {
		//trace("ClientSocket.handleClientClose > event : " + event);
		dataStore.showDebugAppMessage("ClientSocket.handleClientClose");
		dispatchEvent(new Event(Event.CLOSE));
		dispose();
	}

	private function handleClientConnect(event:Event):void {
		trace("ClientSocket.handleClientConnect > event : " + event);
		dataStore.showDebugAppMessage("ClientSocket.handleClientConnect");
	}

	private function handleClientError(event:IOErrorEvent):void {
		trace("ClientSocket.handleClientError > event : " + event);
		dataStore.showDebugAppMessage("ClientSocket.handleClientError");
	}

	private function handleClientData(event:ProgressEvent):void {
		dataStore.showDebugAppMessage("ClientSocket.handleClientData");
		//trace("ClientSocket.handleClientData > event : " + event);
		var newData:String = socket.readUTFBytes(socket.bytesAvailable);
		data += newData;
		parse();
	}

	CONFIG::debug
	private var parseLog:String = "";

	CONFIG::debug
	private var parseLogArray:Array = [];

	private function parse():void {

		CONFIG::debug {
			parseLog = "";
			debugLog(" starting data : -------------------");
			debugLog(data);
			debugLog(" -----------------------------------");
		}

		//trace("---###>>>>> ClientSocket.parse " + data);
		var endPoss:int;

		// TODO : check for fastest string search implementation.
		do {
			var xmlStartFound:Boolean = false;
			var newDataParsed:Boolean = false;
			//

			if (data.charAt(0) == "<") {
				CONFIG::debug {
					debugLog("open bracket found");
				}
				if (data.indexOf("<msg") == 0) {
					xmlStartFound = true;
					CONFIG::debug {
						debugLog("msg start found");
					}
					endPoss = data.indexOf("</msg>");
					CONFIG::debug {
						debugLog("endPoss =" + endPoss);
					}

					////trace("#### MSG : " + data.substr(0, endPoss + 6));
					if (endPoss >= 0) {
						CONFIG::debug {
							debugLog(" parsing data : -------------------");
							debugLog(data.substr(0, endPoss + 6));
							debugLog(" -----------------------------------");
						}
						dataStore.parseMessageData(this._id, data.substr(0, endPoss + 6));
						data = data.substring(endPoss + 6);
						CONFIG::debug {
							debugLog(" substringed data : -------------------");
							debugLog(data);
							debugLog(" -----------------------------------");
						}
						newDataParsed = true;
					}
				} else if (data.indexOf("<graph") == 0) {
					xmlStartFound = true;
					CONFIG::debug {
						debugLog(" parsing praph...");
					}
					endPoss = data.indexOf("</graph>");

					////trace("#### GRAPH : " + data.substr(0, endPoss + 8));
					if (endPoss >= 0) {
						data = data.substring(endPoss + 8);
						newDataParsed = true;
					}
					CONFIG::debug {
						debugLog(" substringed data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
				} else if (data.indexOf("<whatch") == 0) {
					xmlStartFound = true;
					CONFIG::debug {
						debugLog(" parsing whatch...");
					}
					endPoss = data.indexOf("</whatch>");

					////trace("#### WHATCH : " + data.substr(0, endPoss + 9));
					if (endPoss >= 0) {
						data = data.substring(endPoss + 9);
						newDataParsed = true;
					}
					CONFIG::debug {
						debugLog(" substringed data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
				} else if (data.indexOf("<cmd") == 0) {
					xmlStartFound = true;
					CONFIG::debug {
						debugLog(" parsing cmd...");
					}
					endPoss = data.indexOf("</cmd>");

					////trace("#### CMD : " + data.substr(0, endPoss + 6));
					if (endPoss >= 0) {
						dataStore.parseCommandData(this._id, data.substr(0, endPoss + 6));
						data = data.substring(endPoss + 6);
						newDataParsed = true;
					}
					CONFIG::debug {
						debugLog(" substringed data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
				} else if (data.indexOf("<html>") == 0) {
					xmlStartFound = true;
					CONFIG::debug {
						debugLog(" parsing html...");
					}
					endPoss = data.indexOf("</html>");

					////trace("#### HTML : " + data.substr(0, endPoss + 7));
					if (endPoss >= 0) {
						data = data.substring(endPoss + 7);
						newDataParsed = true;
					}
					CONFIG::debug {
						debugLog(" substringed data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
				}
			}
			if (!xmlStartFound && !newDataParsed) { // rezerved XML tags not found, try to treat as simple text that ends with new line.
				CONFIG::debug {
					debugLog(" rezerved xml not found... try to handle as text that ends with new line...");
				}
				// simpe text, find first new line character, and treat as flash html text.
				endPoss = data.indexOf("\n");
				CONFIG::debug {
					debugLog("endPoss = " + endPoss);
				}
				if (endPoss > 0) {
					////trace("#### TEXT : " + data.substr(0, endPoss));
					// TODO : refartor, treat as default message. Remouve text tag comepleatly.
					dataStore.parseTextData(this._id, data.substr(0, endPoss));
					newDataParsed = true;
				}

				if (endPoss == 0) {
					CONFIG::debug {
						debugLog("remove empty new line..");
					}
					////trace("#### EMTY NEW LINE FOUND, REMOVED. ");
					newDataParsed = true;
				}

				// ERROR HANDLING!!!
				// FIXME : Find why this is possible.
				var errorPos:int = data.indexOf("</msg>");
				CONFIG::debug {
					debugLog(" looking for errorPos = " + errorPos);
				}
				if (errorPos >= 0) {
					CONFIG::debug {
						debugLog(" error message found! ");
						debugLog(" error data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
					var errorousText:String = data.substr(0, errorPos + 6);
					dataStore.showDebugAppMessage(errorousText, 2);
					data = data.substring(errorPos + 6);
					CONFIG::debug {
						debugLog(" substringed data : -------------------");
						debugLog(data);
						debugLog(" -----------------------------------");
					}
					newDataParsed = true;
				}
				CONFIG::debug {
					debugLog(" data remaining... : -------------------");
					debugLog(data);
					debugLog(" -----------------------------------");
				}
				data = data.substring(endPoss + 1);
				CONFIG::debug {
					debugLog(" remove handled data : -------------------");
					debugLog(data);
					debugLog(" -----------------------------------");
				}
			}
		} while (newDataParsed && data.length > 0);

		CONFIG::debug {
			rememberLog();
		}
	}

	CONFIG::debug
	private function rememberLog():void {
		parseLogArray.push(parseLog);
		if (parseLogArray.length > 5) {
			parseLogArray.shift();
		}
	}

	CONFIG::debug
	private function debugLog(msg:String):void {
		parseLog += msg + "\n";
	}

	/**
	 *
	 */
	public function dispose():void {
		dataStore.showDebugAppMessage("Client closed!");
		//trace("ClientSocket.dispose");
		socket.removeEventListener(Event.CONNECT, handleClientConnect);
		socket.removeEventListener(Event.CLOSE, handleClientClose);
		socket.removeEventListener(IOErrorEvent.IO_ERROR, handleClientError);
		socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleClientError);
		socket.removeEventListener(ProgressEvent.SOCKET_DATA, handleClientData);
		socket = null;
		dataStore = null;
	}

	public function get id():int {
		return _id;
	}

	CONFIG::debug
	public function debug_getSocket():Socket {
		return socket;
	}
}
}