// Runs the entire test suite in parallel
// Generates Cucumber HTML Report when complete


package ssoService;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;
import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

@CucumberOptions(tags = { "~@ignore" })
public class RegressionTestParallel {

	@Test
	public void regressionTestParallel() {
		String karateOutputPath = "target/surefire-reports";
		KarateStats stats = CucumberRunner.parallel(getClass(), 5, karateOutputPath); // Runs in 5 threads
		generateReport(karateOutputPath);
		assertTrue("Scenarios failed", stats.getFailCount() == 0);
	}

	private static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"), "demo");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

}
