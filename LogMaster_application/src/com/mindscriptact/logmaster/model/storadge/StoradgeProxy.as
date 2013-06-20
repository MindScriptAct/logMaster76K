package com.mindscriptact.logmaster.model.storadge {
import org.puremvc.as3.interfaces.IProxy;
import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * COMMENT
 * @author Deril
 */
public class StoradgeProxy extends Proxy implements IProxy {
	
	public static const NAME:String = "StoradgeProxy";
	
	public function StoradgeProxy() {
		super(NAME);
		
	}
	
}
}