package com.mindscriptact.logmaster {
import com.mindscriptact.logmaster.controller.core.StartupCommand;

import flash.display.Stage;

import mvcexpress.modules.ModuleCore;

/**
 * ...
 * @author Deril
 */
public class MainModule extends ModuleCore {

	public function start(stage:Stage):void {
		commandMap.execute(StartupCommand, stage);

	}
}
}