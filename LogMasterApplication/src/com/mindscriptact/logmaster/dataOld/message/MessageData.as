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
package com.mindscriptact.logmaster.dataOld.message {

/**
 * Message data unit.
 * @author Deril
 */
public class MessageData {
	
	
	static public const LEVEL_ATRIB_NAME:String = "level";

	static public const TYPE_ATRIB_NAME:String = "type";

	static public const COLOR_ATRIB_NAME:String = "color";

	static public const BGCOLOR_ATRIB_NAME:String = "bgcolor";

	static public const BLINGINTERVAL_ATRIB_NAME:String = "blinkInterval";

	static public const EASE_ATRIB_NAME:String = "ease";

	
	static public const STYLE_BLANK:int = 0;
	
	static public const STYLE_NORMAL:int = 1;

	static public const STYLE_BOLD:int = 2;

	static public const STYLE_ITALIC:int = 3;

	static public const STYLE_UNDERLINE:int = 5;

	static public const STYLE_BOLD_ITALIC:int = STYLE_BOLD * STYLE_ITALIC;

	static public const STYLE_BOLD_UNDERLINE:int = STYLE_BOLD * STYLE_UNDERLINE;

	static public const STYLE_ITALIC_UNDERLINE:int = STYLE_BOLD_ITALIC * STYLE_UNDERLINE;

	static public const STYLE_BOLD_ITALIC_UNDERLINE:int = STYLE_BOLD * STYLE_ITALIC * STYLE_UNDERLINE;

	
	/** Code that defines bold,italic,underline style of the message all in one place. */
	public var typeCode:int = STYLE_NORMAL;

	/** Message level */
	public var level:int = 0;

	/** Text color */
	public var textColor:uint = 0x000000;

	/** Background Color */
	public var bgColors:Vector.<uint>;

	/** Message text */
	public var msgText:Vector.<String>;

	/** Flag for folded messages */
	public var isFolded:Boolean = false;
	
	// TODO : implement
	//public var blinkInterval : int;
	// TODO : implement
	//public var easecode 
	/**
	 *
	 */
	public function setBldItlUnd(bold:Boolean, italic:Boolean, underline:Boolean):void {
		//trace("MessageData.setBldItlUnd > bold : " + bold + ", italic : " + italic + ", underline : " + underline);
		typeCode = STYLE_NORMAL;

		if (bold)
			typeCode = typeCode * STYLE_BOLD;

		if (italic)
			typeCode = typeCode * STYLE_ITALIC;

		if (underline)
			typeCode = typeCode * STYLE_UNDERLINE;			
		
	}

	/**
	 *
	 */
	public function copy(copyData:MessageData):void {
		this.typeCode = copyData.typeCode;
		this.level = copyData.level;
		this.textColor = copyData.textColor;
		this.bgColors = copyData.bgColors;
		this.msgText = copyData.msgText;
	}

	public function toString():String {
		return "ClientMessageData{" + " msgText:" + msgText + " level:" + level + " textColor:" + textColor + " bgColors:" + bgColors + " }";
	}
	
	public function getSublineCount(lineCharCount:int):int {
		var retVal:int = 0;
		if (isFolded) {
			retVal = 1;
		} else {
			for (var i:int = 0; i < msgText.length; i++) {
				if (msgText[i].length) {
					retVal += Math.ceil(msgText[i].length / lineCharCount);
				} else {
					retVal++;	
				}
			}
		}
		return retVal;
	}
}
}