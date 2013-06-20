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
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Simple scroll bar with extra functionasity for marks.
 * @author Deril
 */
public class ScrollBar extends Sprite {
	private var size:int;

	private var _paneWidth:int;

	private var _paneHeight:int;
	
	private var back:ScrollBackSPR;
	
	private var bar:ScrollBarSPR;

	public function ScrollBar(size:int = 100){

		back = new ScrollBackSPR();
		back.addEventListener(MouseEvent.CLICK, handleBackClick);
		this.addChild(back);
		//
		bar = new ScrollBarSPR();
		bar.addEventListener(MouseEvent.MOUSE_DOWN, handleBarDown);
		bar.addEventListener(MouseEvent.MOUSE_UP, handleBarRelaese);
		bar.x = 1;
		this.addChild(bar);
		
		
		// TODO : refactor..
		_paneWidth = back.width;
		resize(size);
	}
	
	private function handleBarRelaese(even:MouseEvent):void {
		stopMouseDrag();
	}
	
	private function handleBarDown(event:MouseEvent):void {
		startBarDrag();
	}
	
	private function stopMouseDrag():void {
		this.stage.removeEventListener(Event.ENTER_FRAME, handleDragTick)
		this.stage.removeEventListener(MouseEvent.MOUSE_UP, handleBarRelaese)
	}
	
	private function startBarDrag():void {
		if (this.stage.hasEventListener(Event.ENTER_FRAME)) {
			this.stage.removeEventListener(Event.ENTER_FRAME, handleDragTick)
		}
		if (this.stage.hasEventListener(MouseEvent.MOUSE_UP)) {
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, handleBarRelaese)
		}
		
		this.stage.addEventListener(Event.ENTER_FRAME, handleDragTick)
		this.stage.addEventListener(MouseEvent.MOUSE_UP, handleBarRelaese)
	}
	
	private function handleDragTick(event:Event):void {
		var scrollPos:Number = this.mouseY / back.height;
		if (scrollPos < 0) {
			scrollPos = 0;
		}
		if (scrollPos > 1) {
			scrollPos = 1;
		}		
		dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_TO, scrollPos));
	}
	
	private function handleBackClick(event:MouseEvent):void {
		if (this.mouseY < bar.y) {
			dispatchEvent(new ScrollEvent(ScrollEvent.PAGE_UP));
		} else {
			dispatchEvent(new ScrollEvent(ScrollEvent.PAGE_DOWN));
		}
	}

	/**
	 *
	 */
	public function resize(size:int):void {
		this.size = size;
		_paneHeight = size;
		//
		back.height = size //- lineUpArrow.height * 2;
	}
	
	public function updateBar(lineNumber:int, lineCount:int, startSubLine:int, sublineCount:int):void {
		var bigGap:int = Math.floor((back.height - bar.height) / lineCount);
		var smallGap:int = Math.floor(bigGap / sublineCount);
		bar.y = bigGap * lineNumber + smallGap * startSubLine;
	}
	
	public function set isAutoscrolling(value:Boolean):void {
		if (value) {
			bar.y = back.height - bar.height;
		}
		bar.autoScrollMark_mc.visible = value;
	}

	private function handleLineUp(event:MouseEvent):void {
		//trace("ScrollBar.handleLineUp > evt : " + evt);
		dispatchEvent(new ScrollEvent(ScrollEvent.LINE_UP));
	}

	private function handleLineDown(event:MouseEvent):void {
		//trace("ScrollBar.handleLineDown > evt : " + evt);
		dispatchEvent(new ScrollEvent(ScrollEvent.LINE_DOWN));
	}

	public function get paneWidth():int {
		return _paneWidth;
	}

	public function get paneHeight():int {
		return _paneHeight;
	}
}
}