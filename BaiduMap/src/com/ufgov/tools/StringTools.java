package com.ufgov.tools;

import java.io.UnsupportedEncodingException;

public class StringTools {

	private static final String UTF8 = "UTF-8";
	private static final String ISO8859 = "iso8859-1";

	public static String ISO2UTF(String str){
		try {
			return new String(str.getBytes(ISO8859), UTF8);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}
}
