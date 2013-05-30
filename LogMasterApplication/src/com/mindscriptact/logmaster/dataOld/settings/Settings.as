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
package com.mindscriptact.logmaster.dataOld.settings {
import com.mindscriptact.logmaster.dataOld.message.MessageData;
import flash.utils.Dictionary;

/**
 * Contains current settings for the app.
 * @author Deril
 */
public class Settings {
	static private var instance:Settings;
	
	/** Definition af message levels */
	public var levelTypeNames:Dictionary = new Dictionary() /** of Strings by int */;

	/** Level visual settings stored in message date. */
	public var levelTypes:Vector.<MessageData> = new Vector.<MessageData>();

	/**
	 *
	 */
	static public function getInstance():Settings {
		if (!instance){
			instance = new Settings();
		}
		return instance;
	}

	// TODO : think about extendeng messageData and creating dedicated data type for settings.
	// FIXME : load settings from compiuter local xml file... 
	public function Settings(){
		if (instance){
			throw new Error("Error: Instantiation failed: use Settings.getInstance();");
		}
		Settings.instance = this;
		//
		levelTypeNames[0] = "debug";
		levelTypeNames[1] = "info"
		levelTypeNames[2] = "warn"
		levelTypeNames[3] = "error"
		levelTypeNames[4] = "fatal"
		//
		var levelData:MessageData = new MessageData();
		levelData.level = 0;
		levelData.textColor = 0x004080;
		//levelData.bgColors = Vector.<uint>([]);
		levelData.msgText = Vector.<String>(["This is debug text."]);
		levelTypes.push(levelData);
		//
		levelData = new MessageData();
		levelData.level = 1;
		//levelData.textColor = 0;
		//levelData.bgColors = Vector.<uint>([]);
		levelData.msgText = Vector.<String>(["This is info text."]);
		levelTypes.push(levelData);
		//
		levelData = new MessageData();
		levelData.level = 2;
		levelData.textColor = 0xB75B00;
		levelData.bgColors = Vector.<uint>([0xFFEEDD]);
		levelData.msgText = Vector.<String>(["This is varn text."]);
		levelTypes.push(levelData);
		//
		levelData = new MessageData();
		levelData.level = 3;
		levelData.textColor = 0x710000;
		levelData.bgColors = Vector.<uint>([0xFFEEEE]);
		levelData.msgText = Vector.<String>(["This is error text."]);
		levelData.setBldItlUnd(true, false, false);
		levelTypes.push(levelData);
		//
		levelData = new MessageData();
		levelData.level = 4;
		//levelData.textColor = 0;
		levelData.bgColors = Vector.<uint>([0xFFDDDD, 0xFFCCCC]);
		levelData.msgText = Vector.<String>(["This is fatal text."]);
		levelData.setBldItlUnd(true, false, false);
		levelTypes.push(levelData);
	}

	/**
	 * Gets count of posible levels.
	 * @return	level count.
	 */
	public function getLevelCount():int {
		return levelTypes.length;
	}

	/**
	 * Gets type name by level id.
	 * @param	level	level id.
	 * @return	level name.
	 */
	public function getTypeByLevel(levelId:int):String {
		return levelTypeNames[levelId];
	}

	/**
	 * Gets level id by type name.
	 * @param	type	type name.
	 * @return	level id.
	 */
	public function getLevelByType(typeName:String):int {
		//trace("Settings.getLevelByType > type : " + typeName);
		var retVal:int = int.MIN_VALUE;

		for (var i:uint = 0; i < levelTypes.length; i++){
			if (levelTypeNames[i] == typeName){
				retVal = levelTypes[i].level;
				break;
			}
		}
		return retVal;
	}

	/**
	 * Gets level text color.
	 * @param	levelId	levelId
	 * @return	text color
	 */
	public function getTextColor(levelId:int):uint {
		var retVal:uint = 0;

		for (var i:uint = 0; i < levelTypes.length; i++){
			if (levelTypes[i].level == levelId){
				retVal = levelTypes[i].textColor;
				break;
			}
		}
		return retVal;
	}

	/**
	 * Gets level bg colors
	 * @param	levelId	Level id
	 * @return	bg corols
	 */
	public function getBgColor(levelId:int):Vector.<uint> {
		var retVal:Vector.<uint> = null;

		for (var i:uint = 0; i < levelTypes.length; i++){
			if (levelTypes[i].level == levelId){
				retVal = levelTypes[i].bgColors;
				break;
			}
		}
		return retVal;
	}

	/**
	 * Get text style 
	 * @param	levelId	level id
	 * @return	Text style.
	 */
	public function getTextStyleCode(levelId:int):int {
		var retVal:int = MessageData.STYLE_NORMAL;

		for (var i:uint = 0; i < levelTypes.length; i++){
			if (levelTypes[i].level == levelId){
				retVal = levelTypes[i].typeCode;
				break;
			}
		}
		return retVal;
	}
}
}