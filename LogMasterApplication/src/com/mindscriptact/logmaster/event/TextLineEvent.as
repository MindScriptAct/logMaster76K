package com.mindscriptact.logmaster.event {
import flash.events.Event;

/**
 * COMMENT
 * @author Deril
 */
public class TextLineEvent extends Event {
	
	static public const ITEM_CLICK:String = "textLineItemClick";
	static public const FOLD_CLICK:String = "textLineFoldClick"
	
	public var textId:int;

	public function TextLineEvent(type:String, textId:int){
		this.textId = textId;
		super(type, true);
	}
}
}