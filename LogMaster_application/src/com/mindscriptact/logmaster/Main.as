﻿/*********************************************************************
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
package com.mindscriptact.logmaster {
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.system.Security;


/**
 * Init aplication core elements.
 * @author Deril
 */
public class Main extends Sprite {

	// FIXME : implement font usage from user system.
	/** Quick and dirty way to have embeded fonts. */
	private var fontPack:FontPack = new FontPack();

	public function Main():void {

		//Security.allowInsecureDomain('*');
		//Security.allowDomain('*');

		// stage set up
		this.stage.scaleMode = StageScaleMode.NO_SCALE;
		this.stage.align = StageAlign.TOP_LEFT;
		//
		var mainModule:MainModule = new MainModule();
		mainModule.start(this);


	}

}
}