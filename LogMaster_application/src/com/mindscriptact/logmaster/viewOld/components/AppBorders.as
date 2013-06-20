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
import com.mindscriptact.logmaster.core.AppManager;
import flash.display.NativeWindowResize;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author Derilas
 */
public class AppBorders extends Sprite {
	static public const BORDER_SIZE:int = 4;
	
	static private const BORDER_CORNER_SIZE:int = 9;

	private var cornecUL:AppCornerBTN;
	private var cornecUR:AppCornerBTN;
	private var cornecBL:AppCornerBTN;
	private var cornecBR:AppCornerBTN;


	private var borderL:AppBorderVBTN;
	private var borderR:AppBorderVBTN;
	private var borderU:AppBorderHBTN;
	private var borderB:AppBorderHBTN;
	

	public function AppBorders() {
		
		cornecUL = new AppCornerBTN();		this.addChild(cornecUL);
		cornecUR = new AppCornerBTN();		this.addChild(cornecUR); 	cornecUR.scaleX = -1;
		cornecBL = new AppCornerBTN();		this.addChild(cornecBL);	cornecBL.scaleY = -1;
		cornecBR = new AppCornerBTN();		this.addChild(cornecBR); 	cornecBR.scaleX = -1; cornecBR.scaleY = -1;
		borderL = new AppBorderVBTN();		this.addChild(borderL);
		borderR = new AppBorderVBTN();		this.addChild(borderR);
		borderU = new AppBorderHBTN();		this.addChild(borderU);
		borderB = new AppBorderHBTN();		this.addChild(borderB);
		
		cornecUL.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.TOP_LEFT);});
		cornecUR.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.TOP_RIGHT);});
		cornecBL.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.BOTTOM_LEFT);});
		cornecBR.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.BOTTOM_RIGHT);});
		borderL.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.LEFT);});
		borderR.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.RIGHT);});
		borderU.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.TOP);});
		borderB.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent):void {AppManager.startResize(NativeWindowResize.BOTTOM);});
		
		cornecUL.useHandCursor = //
		cornecUR.useHandCursor = //
		cornecBL.useHandCursor = // 
		cornecBR.useHandCursor = //
		borderL.useHandCursor = //
		borderR.useHandCursor = //
		borderU.useHandCursor = //
		borderB.useHandCursor = false;
	}

	public function resize(appWidth:int, appHeight:int):void {
		cornecUR.x = appWidth;
		cornecBL.y = appHeight;
		cornecBR.x = appWidth; cornecBR.y = appHeight;
		//
		borderL.height = appHeight - BORDER_CORNER_SIZE * 2;
		borderL.y =  BORDER_CORNER_SIZE;
		//
		borderR.height = appHeight - BORDER_CORNER_SIZE * 2;
		borderR.x =  appWidth;		
		borderR.y =  BORDER_CORNER_SIZE;
		borderR.scaleX = -1
		//
		borderU.width = appWidth - BORDER_CORNER_SIZE * 2;
		borderU.x = BORDER_CORNER_SIZE;
		//
		borderB.width = appWidth - BORDER_CORNER_SIZE * 2;
		borderB.x = BORDER_CORNER_SIZE;
		borderB.y = appHeight;
		borderB.scaleY = -1

	}
}
}