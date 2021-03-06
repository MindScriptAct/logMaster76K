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
import flash.events.MouseEvent;
import flash.events.ServerSocketConnectEvent;
import flash.net.ServerSocket;
import flash.net.Socket;

/**
 * Opens server socket, manages client connection.
 * Updates Storage client status data on new clients, and on client disconect.
 * @author Deril
 */
public class ConnectionManager {
	private var server:ServerSocket;

	private var clients:Vector.<ClientSocket> = new Vector.<ClientSocket>();

	// TODO : implement.
	/** Ports to try to set server to. */
	private var ports:Vector.<int> = Vector.<int>([4455, 4444, 4445, 4446, 4447, 4448, 4449]);

	//
	/** Data storadge is used to send information on user connect - disconect. */
	private var dataStore:Storadge;

	// TODO : implement several ports, and  bind to next once - if defalt is in use.
	public function ConnectionManager(dataStore:Storadge) {
		//trace("ConnectionManager.ConnectionManager");
		this.dataStore = dataStore;
	}

	public function startIt(event:MouseEvent = null):void {
		server = new ServerSocket();

		var connectPort:int = 0;
		var isServerStarted:Boolean = false;
		while (connectPort < ports.length && !isServerStarted) {
			try {
				server.bind(ports[connectPort]);
				server.listen();
				isServerStarted = true;
				dataStore.showDebugAppMessage("Server binded to perceived:" + ports[connectPort] + " true:" + server.localPort);
			} catch (error:Error) {
				dataStore.showAppMessage(" \"LogMaster76K\" fail to start!  error:" + error);
				connectPort++;
			}
		}

		if (server.listening) {
			dataStore.showAppMessage(" \"LogMaster76K\" sucsesifuly started!!!  (" + ports[connectPort] + ")");
		}
		server.addEventListener(ServerSocketConnectEvent.CONNECT, handleConnect);
		server.addEventListener(Event.CLOSE, handleClose);
	}

	private function handleClose(event:Event):void {
		//trace("ConnectionManager.handleClose > event : " + event);
		dataStore.showAppMessage("\"LogMaster76K\" is closed !!!");
	}

	private function handleConnect(event:ServerSocketConnectEvent):void {
		//trace("ConnectionManager.handleConnect > event : " + event, event.socket);
		var client:ClientSocket = new ClientSocket(event.socket, dataStore);
		dataStore.registerClient(client.id);
		this.clients.push(client);
		client.addEventListener(Event.CLOSE, handleClientClose);
		//dataStore.showDebugAppMessage("Server accepted client connection!");
	}

	private function handleClientClose(event:Event):void {
		//trace("ConnectionManager.handleClientClose > event : " + event);
		var client:ClientSocket = event.target as ClientSocket;
		//
		client.removeEventListener(Event.CLOSE, handleClientClose);
		dataStore.killClient(client.id);

		for (var i:uint = 0; i < clients.length; i++) {
			if (clients[i] == client) {
				clients.splice(i, 1);
				break;
			}
		}
	}

	CONFIG::debug
	public function getSocketStatus():String {
		var retVal:String = "----------------------------- Socket status:" + "\n";
		if (server) {
			retVal += "Server socket:" + server + " listening:" + server.listening + " bound:" + server.bound + " " + server.localAddress + " " + server.localPort + "\n";
		} else {

			retVal += "Server socket:" + server + "\n";
		}
		for (var c:int = 0; c < clients.length; c++) {
			var client:Socket = clients[c].debug_getSocket();
			retVal += "Client socket:" + " id:" + clients[c].id + " connected:" + client.connected + " bytesAvailable:" + client.bytesAvailable + " bytesPending:" + client.bytesPending + " " + client.localAddress + " " + client.localPort + " " + client.endian + "\n";
		}
		retVal += "-----------------------------------------------" + "\n";
		return retVal;
	}
}
}