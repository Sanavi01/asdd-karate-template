package template.auth;

import com.intuit.karate.junit5.Karate;

/**
 * Runner for the Auth domain.
 * Executes all feature files in the auth package.
 *
 * Run: mvn test -Dtest=AuthRunner
 * Run smoke only: mvn test -Dtest=AuthRunner -Dkarate.options="--tags @smoke"
 */
class AuthRunner {

    @Karate.Test
    Karate testAuth() {
        return Karate.run("login").relativeTo(getClass());
    }
}
