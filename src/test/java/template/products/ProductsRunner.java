package template.products;

import com.intuit.karate.junit5.Karate;

/**
 * Runner for the Products domain.
 * Executes all feature files in the products package.
 *
 * Run: mvn test -Dtest=ProductsRunner
 * Run smoke only: mvn test -Dtest=ProductsRunner -Dkarate.options="--tags @smoke"
 */
class ProductsRunner {

    @Karate.Test
    Karate testProducts() {
        return Karate.run("products").relativeTo(getClass());
    }
}
