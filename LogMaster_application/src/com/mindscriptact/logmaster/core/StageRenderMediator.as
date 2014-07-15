/*********************************************************************
 *  Copyright (C) 2010 by Raimundas Banevicius (raima156@yahoo.com)
 *
 *
 *    This file is part of LogMaster76K.
 *
 *    LogMaster76K is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    LogMaster76K is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with LogMaster76K.  If not, see <http://www.gnu.org/licenses/>.
 *
 *********************************************************************/
package com.mindscriptact.logmaster.core {
import com.mindscriptact.logmaster.dataOld.Storadge;
import com.mindscriptact.logmaster.dataOld.message.MessageData;
import com.mindscriptact.logmaster.event.MessageEvent;
import com.mindscriptact.logmaster.event.TabEvent;
import com.mindscriptact.logmaster.event.TextLineEvent;
import com.mindscriptact.logmaster.messages.Message;
import com.mindscriptact.logmaster.model.app.AppProxy;
import com.mindscriptact.logmaster.model.storadge.StorageProxy;
import com.mindscriptact.logmaster.viewOld.TabPane;
import com.mindscriptact.logmaster.viewOld.TextPane;
import com.mindscriptact.logmaster.viewOld.components.AppBorders;
import com.mindscriptact.logmaster.viewOld.components.ScrollBar;
import com.mindscriptact.logmaster.viewOld.components.ScrollEvent;
import com.mindscriptact.logmaster.viewOld.components.TextLine;
import com.mindscriptact.logmaster.viewOld.components.ToolTip;

import flash.display.Stage;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.system.System;
import flash.text.TextFormat;
import flash.utils.Dictionary;
import flash.utils.Timer;
import flash.utils.setTimeout;

import mvcexpress.mvc.Mediator;

/**
 * Initializes and updates view on storadge events.
 * @author Deril
 */
public class StageRenderMediator extends Mediator {

	[Inject]
	public var view:Stage;

	[Inject]
	public var appProxy:AppProxy;


	private var text_types:Dictionary = new Dictionary();
	/** of TextFormat by int */

	// FIXME : refactor tab pane implementation..
	private var tabPane:TabPane;

	/** Text pane to output log messages. */
	private var textPane:TextPane;

	private var srollBar:ScrollBar = new ScrollBar();

	private var borders:AppBorders = new AppBorders();

	private var bgColorTransform:ColorTransform = new ColorTransform();

	private var messages:Vector.<MessageData> = new Vector.<MessageData>();

	// flag for pending update, needed to buffer out too merge too many update calls in one.
	private var isUpdatePending:Boolean = false;

	private var dataStore:Storadge;


	override protected function onRegister():void {

		this.dataStore = (proxyMap.getProxy(StorageProxy) as StorageProxy).getDataStore();
		//
		// All data storadge listeners.
		dataStore.addEventListener(MessageEvent.MESSAGE_UPDATE, handleMessageUpdate);
		// TODO : refactor, change to enother event.
		dataStore.addEventListener(TabEvent.TAB_CHANGE, handleTabBarUpdate);
		dataStore.addEventListener(TabEvent.TAB_CREATE, handleTabCreate);
		dataStore.addEventListener(TabEvent.TAB_REMOVE, handleTabRemove);
		dataStore.addEventListener(TabEvent.TAB_RENAME, handleTabRename);
		//
		view.addEventListener(Event.RESIZE, handleResize);

		var tickTimer:Timer = new Timer(1000, 0);
		tickTimer.addEventListener(TimerEvent.TIMER, handleTick);
		tickTimer.start();

		//
		////////////////////////////
		//
		// show main menu.
		// TODO : implement.
		//
		// Show defalt tab (id = 0)
		tabPane = new TabPane(dataStore);
		view.addChild(tabPane);
		//
		// create TextPane
		textPane = new TextPane();
		view.addChild(textPane);
		textPane.addEventListener(TextLineEvent.FOLD_CLICK, handleFoldingEvent);
		textPane.addEventListener(TextLineEvent.ITEM_CLICK, handleItemClick);
		//
		//
		var currentLine:TextLine = textPane.firstLine;
		// TODO : move text type settings to dedicated class.
		var testFormat:TextFormat
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 0;
		testFormat.italic = 0;
		testFormat.underline = 0;
		text_types[MessageData.STYLE_BLANK] = testFormat;
		text_types[MessageData.STYLE_NORMAL] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 1;
		testFormat.italic = 0;
		testFormat.underline = 0;
		text_types[MessageData.STYLE_BOLD] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 0;
		testFormat.italic = 1;
		testFormat.underline = 0;
		text_types[MessageData.STYLE_ITALIC] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 0;
		testFormat.italic = 0;
		testFormat.underline = 1;
		text_types[MessageData.STYLE_UNDERLINE] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 1;
		testFormat.italic = 1;
		testFormat.underline = 0;
		text_types[MessageData.STYLE_BOLD_ITALIC] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 1;
		testFormat.italic = 0;
		testFormat.underline = 1;
		text_types[MessageData.STYLE_BOLD_UNDERLINE] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 0;
		testFormat.italic = 1;
		testFormat.underline = 1;
		text_types[MessageData.STYLE_ITALIC_UNDERLINE] = testFormat;
		testFormat = currentLine.message_txt.getTextFormat();
		testFormat.bold = 1;
		testFormat.italic = 1;
		testFormat.underline = 1;
		text_types[MessageData.STYLE_BOLD_ITALIC_UNDERLINE] = testFormat;
		//
		// custom scrollbar
		view.addChild(srollBar);
		// REFACTOR : remove event listeners, move to PureMVC.
		srollBar.addEventListener(ScrollEvent.PAGE_UP, handlePageUp);
		srollBar.addEventListener(ScrollEvent.PAGE_DOWN, handlePageDown);
		srollBar.addEventListener(ScrollEvent.SCROLL_TO, handleScrollToPosition);
		//
		new ToolTip(this.view);
		//
		//show app borders
		view.addChild(borders);


		addHandler(Message.RESIZE_APP, handleResize)
		addHandler(Message.SCROLL_LINE_UP, handleLineUp)
		addHandler(Message.SCROLL_FAST_SCROLL_UP, handleFastScrollUp)
		addHandler(Message.SCROLL_THIRD_UP, handleThirdUp)
		addHandler(Message.SCROLL_PAGE_UP, handlePageUp)
		addHandler(Message.SCROLL_LINE_DOWN, handleLineDown)
		addHandler(Message.SCROLL_FAST_SCROLL_DOWN, handleFasatScrollDown)
		addHandler(Message.SCROLL_THIRD_DOWN, handleThirdDown)
		addHandler(Message.SCROLL_PAGE_DOWN, handlePageDown)
	}

	private function handleLineUp(blank:Object):void {
		scrollTextPane(-1);
	}

	private function handleFastScrollUp(blank:Object):void {
		scrollTextPane(textPane.lineCount / -6);

	}

	private function handleThirdUp(blank:Object):void {
		scrollTextPane(textPane.lineCount / -3);
	}

	private function handleLineDown(blank:Object):void {
		scrollTextPane(1);
	}

	private function handleFasatScrollDown(blank:Object):void {
		scrollTextPane(textPane.lineCount / 6);

	}

	private function handleThirdDown(blank:Object):void {
		scrollTextPane(textPane.lineCount);
	}


	private function handleFoldingEvent(event:TextLineEvent):void {
		if (event.textId >= 0) {
			messages[event.textId].isFolded = !messages[event.textId].isFolded;
			initMessageUpdate();
		}
	}

	private function handleItemClick(event:TextLineEvent):void {
		// TODO : IMPLEMENT then data store changed to proxy..
		//sendNotification(Note.SEND_TO_CLIPBOARD, event.textId);

		if (event.textId >= 0) {
			System.setClipboard(dataStore.getLineText(event.textId));
		}
	}

	/**
	 * Redraw app window elements.
	 */
	private function handleResize(param:Object):void {
		var appW:int = view.stageWidth;
		var appH:int = view.stageHeight;
		var appBorders:int = AppBorders.BORDER_SIZE;
		// borders
		borders.resize(appW, appH);
		// tab pane
		tabPane.resize(appW - appBorders * 2, appH - appBorders * 2);
		tabPane.x = appBorders;
		tabPane.y = appBorders;
		//
		textPane.resize(appW - appBorders * 2 - srollBar.width, appH - appBorders * 2 - tabPane.height);
		textPane.x = appBorders;
		textPane.y = appBorders + tabPane.paneHeight;
		//
		srollBar.resize(appH - appBorders * 2 - tabPane.height);
		srollBar.x = appW - srollBar.paneWidth - appBorders;
		srollBar.y = appBorders + tabPane.paneHeight;
		//
		initMessageUpdate();
	}

	private function handleScrollToPosition(event:ScrollEvent):void {
		textPane.isAutoScrolling = false;
		textPane.startLine = Math.floor(event.position * messages.length);
		textPane.startSubLine = 0;
		initMessageUpdate();
	}

	private function handlePageDown(event:ScrollEvent):void {
		sendMessage(Message.SCROLL_PAGE_DOWN);
	}

	private function handlePageUp(event:ScrollEvent):void {
		sendMessage(Message.SCROLL_PAGE_UP);
	}

	private function scrollTextPane(scrollAmount:int):void {
		textPane.lineMoveAmmount += scrollAmount;
		initMessageUpdate();
	}

	/**
	 *
	 */
	public function handleTabBarUpdate(event:TabEvent):void {
		tabPane.activateTab(event.tabId);
	}

	private function handleMessageUpdate(event:MessageEvent):void {
		////trace("Render.handleLogUpdate > event : " + event);
		// TODO : check if updated log currently is active.. (Logtabid == active tab id.)
		messages = event.messages;

		initMessageUpdate();
	}

	private function initMessageUpdate():void {
		if (!isUpdatePending) {
			isUpdatePending = true;
			setTimeout(messageUpdate, 10);
		}
	}


	private function messageUpdate():void {
		isUpdatePending = false;
		var currentTextLine:TextLine;
		//
		var totalPaneLineCount:int = textPane.lineCount;
		var lineCharCount:int = textPane.lineCharCount;
		//
		var textLineNr:int = 0;
		var textSubLineNumber:int = 0;
		//
		var sublineCount:int;
		var messageSubLineCount:int;
		var textSubLineNr:int;
		var messageText:String;
		var messageCharCount:int;
		var charNr:int;
		var tempColorTransform:ColorTransform;
		var colorCount:int;
		//

		// get inital render line.
		textLineNr = textPane.startLine;
		textSubLineNumber = textPane.startSubLine;

		// move text if needed.
		if (textPane.lineMoveAmmount > 0) {
			textSubLineNumber += textPane.lineMoveAmmount;
			do {
				var checkNextLine:Boolean = false;
				sublineCount = messages[textLineNr].getSublineCount(lineCharCount);
				if (textSubLineNumber >= sublineCount) {
					textSubLineNumber -= sublineCount;
					textLineNr++;
					checkNextLine = true;
				}
			} while (checkNextLine && textLineNr < messages.length);
		} else if (textPane.lineMoveAmmount < 0) {
			textPane.isAutoScrolling = false;
			textSubLineNumber += textPane.lineMoveAmmount;
			while (textSubLineNumber < 0) {
				if (textLineNr > 0) {
					textLineNr--;
					sublineCount = messages[textLineNr].getSublineCount(lineCharCount);
					textSubLineNumber += sublineCount;
				} else {
					textSubLineNumber = 0;
				}
			}
			sublineCount = messages[textLineNr].getSublineCount(lineCharCount);
		}
		textPane.lineMoveAmmount = 0;

		// save modifications.
		textPane.startLine = textLineNr;
		textPane.startSubLine = textSubLineNumber;

		// autoscroll is off, text will be rendered top-down.
		if (!textPane.isAutoScrolling) {
			currentTextLine = textPane.firstLine;
			// render text.
			while (textLineNr < messages.length && currentTextLine) {
				messageSubLineCount = messages[textLineNr].msgText.length;
				for (textSubLineNr = 0; textSubLineNr < messageSubLineCount; textSubLineNr++) {
					messageText = messages[textLineNr].msgText[textSubLineNr];
					messageCharCount = messageText.length;
					for (charNr = 0; charNr < messageCharCount && currentTextLine; charNr += lineCharCount) {
						if (textSubLineNumber) {
							// skip subline
							textSubLineNumber--;
						} else {
							// set text
							currentTextLine.message_txt.text = messageText.substr(charNr, lineCharCount);
							// set text color.
							currentTextLine.message_txt.textColor = messages[textLineNr].textColor;
							// set folding state.
							if (messages[textLineNr].isFolded) {
								currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_STAR_FOLDED);
							} else {
								if (textSubLineNr == 0 && charNr == 0) { // start line check
									if (textSubLineNr == messages[textLineNr].msgText.length - 1 && charNr + lineCharCount > messageCharCount) { // end line check
										currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_EMPTY);
									} else {
										currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_STAR_NOT_FOLDED);
									}
								} else if (textSubLineNr == messages[textLineNr].msgText.length - 1 && charNr + lineCharCount > messageCharCount) { // end line check
									currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_END);
								} else {
									currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_MIDDLE);
								}
							}
							// set bg color
							if (messages[textLineNr].bgColors) {
								colorCount = messages[textLineNr].bgColors.length;
								if (colorCount > 0) {
									currentTextLine.curentBgColorNr = 0;
									currentTextLine.bgColorTransform.color = messages[textLineNr].bgColors[0];
									currentTextLine.bg_spr.transform.colorTransform = currentTextLine.bgColorTransform;
									if (colorCount > 1) {
										currentTextLine.bgColors = messages[textLineNr].bgColors
										currentTextLine.isBlinking = true;
									} else {
										currentTextLine.bgColors = null;
										currentTextLine.isBlinking = false;
									}
								}
							} else {
								clearBackGround(currentTextLine);
							}
							// set text bold,italic,underline
							currentTextLine.message_txt.setTextFormat(text_types[messages[textLineNr].typeCode]);
							//
							currentTextLine.textId = textLineNr;
							// jump to next line
							currentTextLine = currentTextLine.nextLine;
							// if message is foldede break the broken line looping.
							if (messages[textLineNr].isFolded) {
								break;
							}
						}
					}
					// if message is foldede break the subline looping.
					if (messages[textLineNr].isFolded) {
						break;
					}
				}
				textLineNr++;
			}
			// if text fails to fit - turn auto scroll on.
			if (currentTextLine) {
				textPane.isAutoScrolling = true;
			}
		}

		// autoscroll is on, text will be rendered bottom-up.
		if (textPane.isAutoScrolling) {
			currentTextLine = textPane.lastLine;
			textLineNr = messages.length - 1;
			// render text.
			while (textLineNr >= 0 && currentTextLine) {
				messageSubLineCount = messages[textLineNr].msgText.length;
				for (textSubLineNr = messageSubLineCount - 1; textSubLineNr >= 0; textSubLineNr--) {
					// if message is folded - render first line only.
					if (messages[textLineNr].isFolded) {
						textSubLineNr = 0;
					}
					messageText = messages[textLineNr].msgText[textSubLineNr];
					messageCharCount = messageText.length;
					var messageSubLineSubParts:int = Math.ceil(messageCharCount / lineCharCount);
					for (charNr = lineCharCount * (messageSubLineSubParts - 1); charNr >= 0 && currentTextLine; charNr -= lineCharCount) {
						// if message is folded - render first subline only.
						if (messages[textLineNr].isFolded) {
							charNr = 0;
						}
						// set text
						currentTextLine.message_txt.text = messageText.substr(charNr, lineCharCount);
						// set text color.
						currentTextLine.message_txt.textColor = messages[textLineNr].textColor;
						// set folding state.
						if (messages[textLineNr].isFolded) {
							if (messages.length > 1 || messageCharCount > lineCharCount) {
								currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_STAR_FOLDED);
							} else {
								currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_EMPTY);
							}
						} else {
							if (textSubLineNr == 0 && charNr == 0) { // start line check
								if (textSubLineNr == messages[textLineNr].msgText.length - 1 && charNr + lineCharCount > messageCharCount) { // end line check
									currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_EMPTY);
								} else {
									currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_STAR_NOT_FOLDED);
								}
							} else if (textSubLineNr == messages[textLineNr].msgText.length - 1 && charNr + lineCharCount > messageCharCount) { // end line check
								currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_END);
							} else {
								currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_MIDDLE);
							}
						}
						// set bg color
						if (messages[textLineNr].bgColors) {
							colorCount = messages[textLineNr].bgColors.length;
							if (colorCount > 0) {
								currentTextLine.curentBgColorNr = 0;
								currentTextLine.bgColorTransform.color = messages[textLineNr].bgColors[0];
								currentTextLine.bg_spr.transform.colorTransform = currentTextLine.bgColorTransform;

								if (colorCount > 1) {
									currentTextLine.bgColors = messages[textLineNr].bgColors
									currentTextLine.isBlinking = true;
								} else {
									currentTextLine.bgColors = null;
									currentTextLine.isBlinking = false;
								}
							}
						} else {
							clearBackGround(currentTextLine);
						}
						// set text bold,italic,underline
						currentTextLine.message_txt.setTextFormat(text_types[messages[textLineNr].typeCode]);
						//
						currentTextLine.textId = textLineNr;
						// jump to next line
						currentTextLine = currentTextLine.prevLine;
						//
						messageSubLineSubParts--;
						//
						if (!currentTextLine) {
							textSubLineNumber = messageSubLineSubParts;
						}
					}
				}
				textLineNr--;
			}

			// save first rendering line. (it will be needed if scrolling is appliend)
			textPane.startLine = textLineNr + 1;
			textPane.startSubLine = textSubLineNumber + 1;
			//  clean all not filed lines, if any.
			while (currentTextLine) {
				clearTextLine(currentTextLine);
				currentTextLine = currentTextLine.prevLine;
			}
		}
		srollBar.updateBar(textPane.startLine, messages.length, textPane.startSubLine, sublineCount);
		srollBar.isAutoscrolling = textPane.isAutoScrolling;
	}


	private function clearTextLine(currentTextLine:TextLine):void {
		currentTextLine.message_txt.text = "";
		currentTextLine.folding_spr.gotoAndStop(TextLine.FOLD_STATE_EMPTY);
		currentTextLine.textId = -1;
		clearBackGround(currentTextLine);
	}

	private function clearBackGround(currentTextLine:TextLine):void {
		currentTextLine.bgColors = null;
		//
		currentTextLine.curentBgColorNr = 0;
		if (currentTextLine.bgColorTransform) {
			currentTextLine.bgColorTransform.color = 0xFFFFFF;
			currentTextLine.bg_spr.transform.colorTransform = currentTextLine.bgColorTransform;
		}
		//
		currentTextLine.isBlinking = false;
	}


	private function handleTick(e:TimerEvent):void {
		blinkLines();
	}

	private function blinkLines():void {
		var currentLine:TextLine = textPane.firstLine;

		while (currentLine) {
			if (currentLine.isBlinking) {
				currentLine.curentBgColorNr++;
				if (currentLine.curentBgColorNr >= currentLine.bgColors.length) {
					currentLine.curentBgColorNr = 0;
				}
				//
				currentLine.bgColorTransform.color = currentLine.bgColors[currentLine.curentBgColorNr];
				currentLine.bg_spr.transform.colorTransform = currentLine.bgColorTransform;
			}
			currentLine = currentLine.nextLine;
		}

	}


	private function handleTabCreate(event:TabEvent):void {
		//trace("Render.handleTabCreate > tab : " + evt.tabId);
		tabPane.createTab(event.tabId, event.name);
	}

	private function handleTabRename(event:TabEvent):void {
		//trace("Render.handleTabRename > evt : " + evt.tabId);
		tabPane.renameTab(event.tabId, event.name);
	}

	private function handleTabRemove(event:TabEvent):void {
		//trace("Render.handleTabRemove > event : " + event);
		tabPane.removeTab(event.tabId);
	}
}
}