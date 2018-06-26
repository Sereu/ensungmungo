package silverstar.utils;

import java.lang.reflect.Type;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class StringUtils {

	private static SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
	
	public static String dateToString (Date date) {
		if(date == null) {
			return null;
		}
		return dateFormatter.format(date);
	}
	
	public static class DateSerializer implements JsonSerializer<Date> {
		
		private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		@Override
		public JsonElement serialize(Date src, Type typeOfSrc, JsonSerializationContext context) {
			String formatedDate = formatter.format(src);
			return new JsonPrimitive(formatedDate);
		}
	}
	
	private static DecimalFormat df = new DecimalFormat("##,###");
	
	//1000000 ---> 1,000,000
	public static String numberWithComma(int number) {
		return df.format(number);		
	}
}