package template;

import com.intuit.karate.junit5.Karate;

/**
 * Master runner that executes ALL feature files in the project.
 * Use individual domain runners for targeted test execution.
 *
 * Run all: mvn test -Dtest=RunAllTests
 * Run by tag: mvn test -Dtest=RunAllTests -Dkarate.options="--tags @smoke"
 */
class RunAllTests {

    @Karate.Test
    Karate runAll() {
        return Karate.run("classpath:template").relativeTo(getClass());
    }
}
