/*********************************************************************
 *  Copyright (C) 2010 by Raimundas Banevicius (raima156@yahoo.com)
 * 
 * 
 *	This file is part of LogMaster76K.
 *
 *	LogMaster76K is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *	
 *	LogMaster76K is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *	
 *	You should have received a copy of the GNU General Public License
 *	along with LogMaster76K.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *********************************************************************/
package com.mindscriptact.logmaster.event {
import flash.events.Event;


/**
 * Tab events.
 * @author Deril
 */
public class TabEvent extends Event {
	
	static public const TAB_CREATE:String = "tabCreate";

	static public const TAB_CHANGE:String = "tabChange";

	static public const TAB_REMOVE:String = "tabRemove";

	static public const TAB_RENAME:String = "tabRename";

	public var tabId:int;
	public var name:String;

	
	public function TabEvent(type:String, tabId:int = -1, name:String = null){
		super(type);
		this.tabId = tabId;
		this.name = name;
	}


}
}