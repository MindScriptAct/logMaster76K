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
import com.mindscriptact.logmaster.event.TextLineEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;


/**
 * Line of text in text pane.
 * @author Deril
 */
public class TextLine extends TextLineSPR {

	static public const FOLD_STATE_STAR_FOLDED:String = "startFolded";
	static public const FOLD_STATE_STAR_NOT_FOLDED:String = "startNotFolded";
	static public const FOLD_STATE_MIDDLE:String = "middle";
	static public const FOLD_STATE_END:String = "end";
	static public const FOLD_STATE_EMPTY:String = "empty";
	
	public var nextLine:TextLine = null;
	public var prevLine:TextLine = null;

	public var bgColorTransform:ColorTransform = new ColorTransform();
	public var bgColors:Vector.<uint>;
	public var curentBgColorNr:int = -1;
	public var isBlinking:Boolean = false;
	
	public var textId:int = -1;

	public function TextLine() {
		this.message_txt.mouseEnabled = false;
		this.folding_spr.addEventListener(MouseEvent.CLICK, handleFoldingClick);
		this.bg_spr.addEventListener(MouseEvent.CLICK, handleItemClick);
	}
	
	private function handleItemClick(event:MouseEvent):void {
		trace("TextLine.handleItemClick > event : " + event);
		trace("textId : " + textId);
		dispatchEvent(new TextLineEvent(TextLineEvent.ITEM_CLICK, textId));
	}
	
	private function handleFoldingClick(event:MouseEvent):void {
		trace("TextLine.handleFoldingClick > event : " + event);
		dispatchEvent(new TextLineEvent(TextLineEvent.FOLD_CLICK, textId));
	}

	/**
	 *
	 */
	public function dispose():void {
		// FIXME: causes error(NULL POINTER) then closing/resizing tab. for watever reasons firs line becomes disposed one..
		//bgColorTransform = null;
		nextLine = null;
		bgColors = null;
	}
}
}