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
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
/**
 * Tooltip visual element.
 * @author Derilas
 */
	
   
public class ToolTip extends Sprite {
	static private var instance:ToolTip;

	public function ToolTip(tooltipHolder:Stage):void {
		if (instance) {
			throw new Error("Error: Instantiation failed: instantiate Tooltip only once.");
		}
		
		
		this.visible = false;
		
		var squareWidth : uint = 100;
		var squareHeight : uint = 100;
		var square : Shape = new Shape();
		square.graphics.lineStyle(1, 0xFF0000);
		square.graphics.beginFill(0xFFFFFF);
		square.graphics.moveTo(0, 0);
		square.graphics.lineTo(0, squareHeight);
		square.graphics.lineTo(squareWidth, squareHeight);
		square.graphics.lineTo(squareWidth, 0);
		square.graphics.lineTo(0, 0);
		square.graphics.endFill();
		this.addChild(square);
		
		instance = this;
		tooltipHolder.addChild(this);
		
		var myTextField:TextField = new TextField();
		this.addChild(myTextField);
		myTextField.text = 'TextLabel...';
		
		
		
	}
	
	
	static public function show():void {
		ToolTip.instance.visible = true;
	}
	static public function hide():void {
		ToolTip.instance.visible = false;
	}
	
}
}