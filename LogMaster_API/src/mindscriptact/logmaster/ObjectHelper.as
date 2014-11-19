package mindscriptact.logmaster
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author http://blog.another-d-mention.ro/programming/how-to-clone-duplicate-an-object-in-actionscript-3/,
	 * Modified by Raimundas Banevicius
	 */
	public class ObjectHelper
	{

		/**
		 * Returns clone of provided object.
		 * @param    source
		 * @return    Cloned object
		 */
		public static function clone(source : Object) : Object
		{
			var retVal : Object;
			if (source)
			{
				retVal = createEmptyClass(source);
				if (retVal)
				{
					copyData(source, retVal);
				}
			}
			return retVal;
		}

		/**
		 * Creates empty class of same type as provided object.
		 * @param    sourceObj    object to create empty class from.
		 * @return    new empty class.
		 */
		public static function createEmptyClass(sourceObj : Object) : *
		{
			var retVal : *;
			if (sourceObj)
			{
				try
				{
					var classOfSourceObj : Class = getDefinitionByName(getQualifiedClassName(sourceObj)) as Class;
					retVal = new classOfSourceObj();
				}
				catch (error : Error)
				{
					trace("ObjectHelper ERROR !!! failed to create new empty class[type:" + classOfSourceObj + "] out of object.[object:" + sourceObj + "]");
				}
			}
			return retVal;
		}

		/**
		 * Copies data from one object to another.
		 * @param    source        copy data to this object.
		 * @param    destination    copy data from this object.
		 */
			// TODO : add neste object, arrays, vector support.
		public static function copyData(source : Object, destination : Object) : void
		{
			//copies data from commonly named properties and getter/setter pairs
			if ((source) && (destination))
			{
				try
				{
					var sourceInfo : XML = describeType(source);
					var prop : XML;

					for each (prop in sourceInfo.variable)
					{

						if (destination.hasOwnProperty(prop.@name))
						{
							destination[prop.@name] = source[prop.@name];
						}
					}

					for each (prop in sourceInfo.accessor)
					{
						if (prop.@access == "readwrite")
						{
							if (destination.hasOwnProperty(prop.@name))
							{
								destination[prop.@name] = source[prop.@name];
							}

						}
					}
				}
				catch (error : Error)
				{
					trace("ObjectHelper ERROR !!! failed to copy data from[" + source + "] to [" + destination + "]. error:" + error);
				}
			}
		}

		public static function toString(data : *, useTabs : Boolean = true) : String
		{
			var retVal : String = "";
			if (data is Array)
			{
				retVal += "[";
				for (var i : int = 0; i < data.length; i++)
				{
					retVal += data[i].toStirng() + " ";
				}
				retVal += "]";
			}
			else
			{
				retVal = objectToString(data);
			}

			return retVal;
		}

		private static function objectToString(data : Object) : String
		{
			var retVal : String = "{";
			for (var id : String in data)
			{
				if (retVal != "{")
				{
					retVal += ", ";
				}
				retVal += id + ":" + data[id];
			}
			retVal += "}";
			return retVal;
		}


		public static function formatJsonString(jsonData : String) : String
		{
			var retVal : String = "";
			var tabs : String = "";

			var charCount : int = jsonData.length;

			for (var i : int = 0; i < charCount; i++)
			{
				var char : String = jsonData.charAt(i);

				if (char == ",")
				{
					retVal += tabs + char + "\n";
				}
				else
				{
					retVal += char;
				}

			}
			return retVal;
		}
	}
}
