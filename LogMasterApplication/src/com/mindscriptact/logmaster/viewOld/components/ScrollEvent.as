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
package com.mindscriptact.logmaster.viewOld.components {
import flash.events.Event;

/**
 * Text pane scroll events.
 * @author Derilas
 */
public class ScrollEvent extends Event {

	
	static public const LINE_UP : String = "lineUp";
	static public const PAGE_UP : String = "pageUp";
	
	static public const SCROLL_TO : String = "scrollTo";
	
	static public const LINE_DOWN : String = "lineDown";
	static public const PAGE_DOWN : String = "pageDown";	

	public var position:Number;	
	
	
	public function ScrollEvent(type:String, position:Number = -1) {
		super(type);
		this.position = position;
		
	}
	
}
}