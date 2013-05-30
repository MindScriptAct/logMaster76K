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
import flash.events.MouseEvent;

/**
 * ...
 * @author Derilas
 */
public class FilterCheckBox extends filterCheckBoxSPR {
	public function FilterCheckBox(levelId:int, levelType:String, levelColor:uint){
		this.mouseChildren = false;
		this.addEventListener(MouseEvent.CLICK, handleFilterClick);
		this.addEventListener(MouseEvent.MOUSE_OVER, handleFilterOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, handleFilterOut);
	}

	private function handleFilterOut(event:MouseEvent):void {
		//trace("FilterCheckBox.handleFilterOut > evt : " + evt);
		//ToolTip.hide();
	}

	private function handleFilterOver(event:MouseEvent):void {
		//trace("void.handleFilterOver > evt : " + evt);
		//ToolTip.show();
	}

	private function handleFilterClick(event:MouseEvent):void {
		//trace("void.handleFilterClick > evt : " + evt);
	}
}
}