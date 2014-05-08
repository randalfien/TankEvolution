package eu.addlexapps.evolvetank.utils
{
	import avmplus.getQualifiedClassName;
	
	import flash.utils.describeType;

	public class FishUtils
	{
		public function FishUtils()
		{
		}
		
		public static function randomText(words:int = 18):String
		{
			var s:String = "";
			for (var i:int = 0; i < words; i++) 
			{
				var l:Number = Math.random();
				if( l > .95 ){
					s = s.concat("Medicinares ");
				}else if( l > .8 ){
					s = s.concat("Lorem ");
				}else if( l > .7 ){
					s = s.concat("Ipsum ");
				}else if( l > .6 ){
					s = s.concat("Dol ");
				}else if( l > .5 ){
					s = s.concat("Ma ");
				}else if( l > .4 ){
					s = s.concat("Am ");
				}else if( s.length > 0 && l > .3 ){
					s = s.concat("of ");
				}
			}
			
			return s;
		}
		
		public static function getUnixTime():Number {
			return int( new Date().time / 1000 );
		}
		
		public static function getWeek(date:Date):int
		{
			var days:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 
			var year:Number = date.fullYearUTC;
			var isLeap:Boolean = (year % 4 == 0) && (year % 100 != 0) || (year % 100 == 0) && (year % 400 == 0); 
			if(isLeap)
				days[1]++;
			
			var d:int = 0;
			//month is conveniently 0 indexed.
			for(var i:int = 0; i < date.monthUTC; i++)
				d += days[i];
			d += date.dateUTC;
			
			var temp:Date = new Date(year, 0, 1);
			var jan1:Number = temp.dayUTC;
			/**
			 * If Jan 1st is a Friday (as in 2010), does Mon, 4th Jan 
			 * fall in the first week or the second one? 
			 *
			 * Comment the next line to make it in first week
			 * This will effectively make the week start on Friday 
			 * or whatever day Jan 1st of that year is.
			 **/
			d += jan1;
			
			return Math.ceil(d / 7);
		}
		
		public static function clip(num:int, min:int, max:int):Number
		{
			if( num < min ) return min;
			if( num > max ) return max
			return num;
		}
		
		public static function traceObject(o:Object):void
		{
			trace("object: {")
			for( var s:String in o ){
				trace(s +":" + o[s] );
			}
			trace("}");
		}
		
		public static function getPropertyNames(instance:Object):Array {
			var className:String = getQualifiedClassName(instance);
			var typeDef:XML = describeType(instance);
			trace(typeDef);
			var props:Array = [];
			for each(var prop:XML in typeDef.accessor.(@access == "readwrite" || @access == "readonly")) {
				props.push(prop.@name);
			}   
			return props;
		}
		

		public static function getObjectAsStrinf(o:Object, recursion:int = 0):String
		{
			if( recursion > 5 ) return "-";
			var result:String = getQualifiedClassName(o)+" {";
			var props:Array = getPropertyNames(o);
			for each(var prop:String in props) {
				if( o[prop] is int || o[prop] is String || o[prop] is Number || o[prop] == null || o[prop] == undefined || o[prop] is Boolean){
					result += prop +":"+ o[prop] + " , ";
				}else{
					result += prop + ":" + getObjectAsStrinf(o[prop], recursion++) + " , ";
				}
			}
			result += "}";
			return result;
		}

		public static function trimWhiteSpace(s:String):String
		{
			var i:int = 0;
			while( s.charAt(i) == " " || s.charAt(i) == "\t"){
				i++;
			}
			var j:int = s.length-1;
			while( s.charAt(j) == " " || s.charAt(j) == "\t"){
				j--;
			}
			return s.substring(i,j+1);
		}
	}
}