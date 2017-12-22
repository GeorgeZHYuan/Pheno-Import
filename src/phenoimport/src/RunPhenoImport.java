import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.lang.ProcessBuilder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Servlet implementation class RunPhenoImport
 */
@WebServlet("/RunPhenoImport")
public class RunPhenoImport extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static String loadStream(InputStream s) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(s));
        StringBuilder sb = new StringBuilder();
        String line;
        while((line=br.readLine()) != null)
            sb.append(line).append("\n");
        return sb.toString();
    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phenoImportLocation = "/gpfs/common/programs/tm_pheno_ext/Pheno-Import/pheno_import.sh";
		String topNode = request.getParameter("topNode");
		String studyName = request.getParameter("studyName");
		String phenoAddress = request.getParameter("phenoAddress");
		String phenoUsername = request.getParameter("phenoUsername");
		String phenoPassword = request.getParameter("phenoPassword");
		String[] patientIds = request.getParameterValues("patientIds[]");
		
		List<String> commands = new ArrayList<>(Arrays.asList("bash"));
		commands.add(phenoImportLocation);
		commands.add(topNode);
		commands.add(studyName);
		commands.add(phenoAddress);
		commands.add(phenoUsername);
		commands.add(phenoPassword);
		for (int i = 0; i < patientIds.length; i++) {
			commands.add(patientIds[i]);
		}
		
		ProcessBuilder runPhenoImport = new ProcessBuilder(commands);
		Process proccess = runPhenoImport.start();
		String output = loadStream(proccess.getInputStream());
		String error = loadStream(proccess.getErrorStream());
		
		response.setContentType("text/plain");		
		response.getWriter().write(output + "\n" + error);
//		response.getWriter().write(commands.toString());	
	}
}