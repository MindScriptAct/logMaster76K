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
import com.mindscriptact.logmaster.dataOld.settings.Settings;
import flash.display.Sprite;

/**
 * 
 * @author Deril
 */
public class LeverFilters extends Sprite {
	public function LeverFilters(){
		var settings:Settings = Settings.getInstance();
		var filterCount:int = settings.getLevelCount();

		//for (var i:int = 0; i < filterCount; i++){
			//var filter:FilterCheckBox = new FilterCheckBox(	i, 
				//settings.getTypeByLevel(i), 
				//settings.getTextColorByLevel(i));
			//this.addChild(filter);
			//filter.x = (filter.width + 5) * i;
		//}
	}
}
}