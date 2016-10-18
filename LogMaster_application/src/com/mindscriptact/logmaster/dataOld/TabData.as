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
import com.mindscriptact.logmaster.dataOld.graph.GraphData;
import com.mindscriptact.logmaster.dataOld.message.MessageData;
import com.mindscriptact.logmaster.dataOld.watch.WatchData;

/**
 * Tab data.
 * @author Deril
 */
public class TabData {

	/** tab name */
	public var title:String = "";

	/** Stores all log messages */
	public var log:Vector.<MessageData> = new Vector.<MessageData>();

	/** Stores all Graph info. */
	public var graph:Vector.<GraphData> = new Vector.<GraphData>();

	/** Stares all Watch info. */
	public var watch:Vector.<WatchData> = new Vector.<WatchData>();

	public function TabData(tabTitle:String) {
		this.title = tabTitle;
	}

	/**
	 *
	 */
	public function dispose():void {
		log = null;
		graph = null;
		watch = null;
	}
}
}