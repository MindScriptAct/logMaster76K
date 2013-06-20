logMaster76K
============

Flash tracing tool based on socked connection. (focuses on team work, and data sorting in tabs)


##Downloads:


LogMaster 76K AIR installer
----------
* [LogMaster76K-v0_7b.air](https://github.com/MindScriptAct/logMaster76K/raw/master/LogMaster_downloads/LogMaster76K-v0_7b.air)

LogMaster AS3 API
----------
* [LogMaster-API_v0_4b.swc](https://github.com/MindScriptAct/logMaster76K/raw/master/LogMaster_downloads/LogMaster-API_v0_4b.swc)
* [LogMaster-API_v0_4b.zip](https://github.com/MindScriptAct/logMaster76K/raw/master/LogMaster_downloads/LogMaster-API_v0_4b.zip)



##Features:

 * will be abe to show HUGE ammounts of data without any lag. (76K of lines and much more..)
 * Supports diferent levels for output.
 * Organize traces in tabs
 * Tabs can be ignorred.(usefull in teamwork)
 * Output can be bold, italic, underlined, colorod, have simple or blinking colored background.
 

##Shortcuts:

 * DELETE - clears the trace.
 * CTRL+A - copy all to clipboard.
 * Mouse click -copy line to clipboard.


##Usage : 

Simple:

  	DebugMan.debug("...many people ask me how to use the secret debugging commands, apparently under the impression that I'll tell them.");
		DebugMan.info("We aren't in an information age, we are in an entertainment age..");
		DebugMan.warn("If you can't be a good example, then you'll just have to serve as a horrible warning...”");
		DebugMan.error("Admitting Error clears the Score, And proves you Wiser than before.");
		DebugMan.fatal("It is fatal to enter any war without the will to win it. ");

Name tab with ID 5:

		DebugMan.renameTab(5, "Tab 5!!");
		
Trace to tab with ID 5:
		
		DebugMan.debugTo(5,"...many people ask me how to use the secret debugging commands, apparently under the impression that I'll tell them.");
		DebugMan.infoTo(5,"We aren't in an information age, we are in an entertainment age..");
		DebugMan.warnTo(5,"If you can't be a good example, then you'll just have to serve as a horrible warning...”");
		DebugMan.errorTo(5,"Admitting Error clears the Score, And proves you Wiser than before.");
		DebugMan.fatalTo(5,"It is fatal to enter any war without the will to win it. ");
		
Custom trace:

		DebugMan.log("Happiness is a choice that requires effort at times.",
				DebugMan.LEVEL_INFO,
				0,
				DebugMan.TEXT_STYLE_BOLD_ITALIC_UNDERLINE,
				0x0000FF,
				[0xFF8080,0xFFFF00,0x00FF00]);
		
		
		
