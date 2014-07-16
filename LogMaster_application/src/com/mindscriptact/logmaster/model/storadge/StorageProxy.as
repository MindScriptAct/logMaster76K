package com.mindscriptact.logmaster.model.storadge {
import com.mindscriptact.logmaster.dataOld.Storadge;

import mvcexpress.mvc.Proxy;

/**
 * COMMENT
 * @author Deril
 */
public class StorageProxy extends Proxy {

	private var dataStore:Storadge;

	public function StorageProxy(dataStore:Storadge) {
		this.dataStore = dataStore;
	}

	public function getDataStore():Storadge {
		return dataStore;
	}

	public function showDebugAppMessage(data:String, debugId:int = 0):void {
		dataStore.showDebugAppMessage(data, debugId);
	}
}
}