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
package com.mindscriptact.logmaster.viewOld {
import com.mindscriptact.logmaster.viewOld.components.TextLine;
import flash.display.Sprite;
import flash.events.MouseEvent;


/**
 * Custom visual representation of text.
 * Optimized for better performance.
 * @author Deril
 */
public class TextPane extends Sprite {
	private var _paneWidth:int;

	private var _paneHeight:int;

	private var _lineCount:int = 0;
	
	private var _lineCharCount:int = 0;
	
	private var oneCharWidth:int;

	/** First line of text pane. */
	private var _firstLine:TextLine;
	private var _lastLine:TextLine;
	
	public var isAutoScrolling:Boolean = false;
	
	/** Line number to start rendering from*/
	public var startLine:int = 0;
	
	/** Subline number in Line to start rendering from*/
	public var startSubLine:int = 0;	

	/** Ammount of lines to move in textPane with next render. */
	public var lineMoveAmmount:int = 0;		
	
	private var lineHeight:int;

	public function TextPane(paneWidth:int = 100, paneHeight:int = 100){
		_firstLine = createNewLine();
		lineHeight = _firstLine.height;
		lineHeight = 18;
		resize(paneWidth, paneHeight);
		//
		// REFACTOR : think of better implementation.. or if its needed...
		// Dinamicly get one char width, with asumtion that this app always will use fixed width fonts.
		_firstLine.message_txt.text = "?";
		oneCharWidth = _firstLine.message_txt.textWidth;
		_firstLine.message_txt.text = "";
	}

	/**
	 * sets new size for pane, and resizes visuals.
	 */
	public function resize(paneWidth:int, paneHeight:int):void {
		////trace("TextPane.resize > paneWidth : " + paneWidth + ", paneHeight : " + paneHeight);
		this._paneWidth = paneWidth;
		this._paneHeight = paneHeight;
		var lineCountNeeded:int = Math.floor(paneHeight / lineHeight);
		var renderLastLine:TextLine = _firstLine;

		if (_lineCount < lineCountNeeded){
			// go to last line.
			while (renderLastLine.nextLine){
				renderLastLine = renderLastLine.nextLine;
			}
			// create missing lines.
			while (_lineCount < lineCountNeeded) {
				var newLine:TextLine = createNewLine();
				renderLastLine.nextLine = newLine;
				newLine.prevLine = renderLastLine;
				renderLastLine = renderLastLine.nextLine;
			}
			_lastLine = renderLastLine;
		} else if (_lineCount > lineCountNeeded){
			// go to line that should be the last.
			for (var i:int = 0; i < lineCountNeeded; i++){
				var endLine:TextLine = renderLastLine;
				renderLastLine = renderLastLine.nextLine;
			}
			endLine.nextLine = null;
			// remove not needed lines
			removeLinesFrom(renderLastLine);
			_lastLine = renderLastLine;
		}
		render();
	}

	private function removeLinesFrom(lastLine:TextLine):void {
		////trace("TextPane.removeLinesFrom > lastLine : " + lastLine);
		var nextLine:TextLine = lastLine;

		while (nextLine){
			nextLine = lastLine.nextLine;
			destroyLine(lastLine);
			lastLine = nextLine;
		}
	}

	/**
	 * Renders data from storadge.
	 */
	public function render():void {
		////trace("TextPane.render");
		var tempLine:TextLine = _firstLine;
		var lineNr:int = 0;

		while (tempLine){
			tempLine.y = lineNr * lineHeight;
			tempLine.bg_spr.width = paneWidth;
			tempLine.message_txt.width = paneWidth - tempLine.folding_spr.width;
			lineNr++;
			tempLine = tempLine.nextLine;
		}
		
		_lineCharCount = Math.floor(_firstLine.message_txt.width / oneCharWidth);
	}

	/**
	 *
	 */
	private function createNewLine():TextLine {
		////trace("TextPane.createNewLine");
		var newLine:TextLine = new TextLine();
		newLine.folding_spr.useHandCursor = false;
		//newLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_EMPTY);
		this.addChild(newLine);
		_lineCount++;
		return newLine;
	}

	/**
	 *
	 */
	private function destroyLine(line:TextLine):void {
		////trace("TextPane.destroyLine > line : " + line);
		this.removeChild(line);
		line.dispose();
		_lineCount--;
	}

	

	public function get paneWidth():int {
		return _paneWidth;
	}

	public function get paneHeight():int {
		return _paneHeight;
	}
	
	public function get lineCount():int {
		return _lineCount;
	}
	
	public function get lineCharCount():int {
		return _lineCharCount;
	}
	
	public function get firstLine():TextLine {
		return _firstLine;
	}
	
	public function get lastLine():TextLine {
		return _lastLine;
	}
}
}