import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.lang.Object;
import java.net.HttpURLConnection;
import javax.xml.bind.DatatypeConverter;

import java.util.Scanner;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FetchPatientIds
 */
@WebServlet("/FetchPatientIds")
public class FetchPatientIds extends HttpServlet {
	
    int indexOfKey = 0;
    int nextIndexOfSpace = 0;
    int lastIndexOfKey = 0;
    static String key = "\"id\":";
    
    public static String returnInfo(String urlGiven, String username, String password) {
    	
    	String jsonLine = "";
    	
    	URL url;
		try {
			
			String newUrl = urlGiven;
//			String newUrl = formerUrl + "/" + id;
			String authorization = username + ":" + password;
			
			url = new URL(newUrl);
//			String encoding = Base64.getEncoder().encodeToString((authorization).getBytes("UTF-8"));
			String encoding = DatatypeConverter.printBase64Binary((authorization).getBytes("UTF-8"));
						
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setDoOutput(true);
			connection.setRequestProperty ("Authorization", "Basic " + encoding);
			InputStream content = (InputStream)connection.getInputStream();
			BufferedReader in = new BufferedReader (new InputStreamReader (content));
			
			jsonLine = in.readLine();
//			System.out.println(jsonLine);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return jsonLine;
    }
    
    public static String returnJson(String urlGiven, String username, String password, String id) {
    	
    	String jsonLine = "";
    	
    	URL url;
		try {
			
			String formerUrl = urlGiven;
			String newUrl = formerUrl + "/" + id;
			
			url = new URL(newUrl);
//			String encoding = Base64.getEncoder().encodeToString((username+":"+password).getBytes("UTF-8"));
			String encoding = DatatypeConverter.printBase64Binary((username+":"+password).getBytes("UTF-8"));
			
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setDoOutput(true);
			connection.setRequestProperty ("Authorization", "Basic " + encoding);
			InputStream content = (InputStream)connection.getInputStream();
			BufferedReader in = new BufferedReader (new InputStreamReader (content));
			
			jsonLine = in.readLine();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return jsonLine;
    }
    
    public static String getName(String jsonExtracted) {
    	
    	String patientDescription = "";
    	
    	if(jsonExtracted != "JSON not found") {
//	    	String patientName = "";
	    	
	    	JSONParser parser = new JSONParser();
	    	
	    	Object obj;
	    	Object obj2;
			try {
				obj = parser.parse(jsonExtracted);
				JSONObject patientData = (JSONObject) obj;
				obj2 = parser.parse(jsonExtracted);
				JSONObject patientData2 = (JSONObject) obj2;
				JSONObject patientBackground = (JSONObject) patientData2.get("notes");
				String indicationForReferral = (String) patientBackground.get("indication_for_referral");
				String diagnosisNotes = (String) patientBackground.get("diagnosis_notes");
				String familyHistory = (String) patientBackground.get("family_history");
				String medicalHistory = (String) patientBackground.get("medical_history");
				
				if(!indicationForReferral.isEmpty())
					patientDescription = indicationForReferral;
				else if(!diagnosisNotes.isEmpty())
					patientDescription = diagnosisNotes;
				else if(!familyHistory.isEmpty())
					patientDescription = familyHistory;
				else
					patientDescription = "No Description Provided";
				
	//			patientName = firstName + " " + lastName;
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
    	}else {
    		patientDescription = "ID not found";
    	}
//    	return patientName;
		return patientDescription;
    }

    @SuppressWarnings({ "unchecked", "resource" })
	public static String getPhenoData(String var1, String var2, String var3){
    String results = "";
	try{
		
//		String currentUrl = "http://localhost:9090/rest/patients";
//		String currentUsername = "Admin";
//		String currentPassword = "admin";
		
		Scanner scanner = new Scanner(System.in);
//		System.out.flush();
//		String var1 = scanner.nextLine();
//		String var2 = scanner.nextLine();
//		String var3 = scanner.nextLine();
		
		JSONParser parser = new JSONParser();
		
//		String line = returnInfo(currentUrl, currentUsername, currentPassword);
		String line = returnInfo(var1, var2, var3);
		
//		while ((line = in.readLine()) != null) {
			if(line != null) {
			
			Object obj = parser.parse(line);
			JSONObject jsonObject = (JSONObject) obj;
			JSONArray patientSummaries = (JSONArray) jsonObject.get("patientSummaries"); 
			
			String id;
			String eid;
			
			int temp = 0;
			
			try {
			
				while (((JSONObject) patientSummaries.get(temp)) != null) {
					temp++;
				}
			}catch (Exception e) {
			}finally {
				
				JSONArray jArray = new JSONArray();
				
				for(int i = 0; i < temp; i++) {
					JSONObject array = ((JSONObject) patientSummaries.get(i));
					JSONObject json = new JSONObject();
					id = (String) array.get("id");
					eid = (String) array.get("eid");
					json.put("id", id);
					
					String jsonOutput = returnJson(var1, var2, var3, id);
					String name = getName(jsonOutput);
					json.put("name", name);

					jArray.add(json);
				}
				results = jArray.toString();
//				System.out.println(jArray.toString());
			}
			
		} 		
		
	}
	catch (Exception e){
		e.printStackTrace();
	}
	
		return results;
   }
    
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String url = request.getParameterValues("url")[0];
		String username = request.getParameterValues("username")[0];
		String password = request.getParameterValues("password")[0];
		String patientInfo = getPhenoData(url+"/rest/patients", username, password);
//		String patientInfo = getPhenoData("http://localhost:10000/rest/patients", "Admin", "admin");
		
		response.setContentType("application/json");
		response.getWriter().write(patientInfo);
//		response.getWriter().write("[{\"name\":\"test\", \"id\":\"12345\"}, {\"name\":\"test2\", \"id\":\"54321\"}]");
	}

//    public static void main(String[] args){
//    	
//    	System.out.println(getPhenoData("http://localhost:10000/rest/patients", "Admin", "admin"));
//    	
//    }
}