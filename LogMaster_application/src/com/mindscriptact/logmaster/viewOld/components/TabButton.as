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
import flash.display.Shape;
import flash.display.Sprite;

/**
 * Tob button, for diferent tab.
 * @author Deril
 */
public class TabButton extends TabButtonMC {
	static public const STATE_PASSIVE:String = "passive";

	static public const STATE_ACTIVE:String = "active";

	/** */
	private var _id:int;

	/**  */
	private var titleName:String = "";

	public function TabButton(id:int, titleName:String = ""){
		this._id = id;
		this.titleName = titleName;

		if (titleName == ""){
			this.titleName = "<=== " + _id + " ===>";
		} else {
			this.titleName = titleName;
		}
		this.title_txt.text = this.titleName;
		changeState(TabButton.STATE_PASSIVE);
	}

	/**
	 *
	 */
	public function setTitle(titleName:String):void {
		this.titleName = titleName;
		this.title_txt.text = this.titleName;
	}

	public function dispose():void {
		// TODO : implement;
	}

	public function get id():int {
		return _id;
	}

	public function changeState(state:String):void {
		this.gotoAndStop(state);
	}
}
}