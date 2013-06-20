package {
import mindscriptact.logmaster.DebugMan;
import mindscriptact.logmaster.LogMan;
import mindscriptact.logmaster.RawMan;
import flash.display.Sprite;


/**
 * Diferent levels of abstraction.
 * @author Deril
 */
public class MainMesengingLevels extends Sprite {

	public function MainMesengingLevels(){


		// ROW data.
		RawMan.sendRowData( //
			"<msg" + //
			" level='3'" + //
			" bold='1'" + //
			" italic='0'" + //
			" underline='0'" + //
			" color='0x710000'" + //
			" bgcolor='0xFFEEEE'" + //
			" tabid='" + 2 + "'" + //
			">" + //
			"MainMesengingLevels :  Success is not forever and failure isn't fatal." + //
			"</msg>");


		// 'Public' usage.
		DebugMan.errorTo(2, "MainMesengingLevels :  Success is not forever and failure isn't fatal.");


		// 'Private' usage.
		var log:LogMan = new LogMan("MainMesengingLevels", 2);
		log.error("Success is not forever and failure isn't fatal.");


	}

}

}