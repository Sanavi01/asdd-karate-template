function fn() {
  // Determine environment: mvn test -Dkarate.env=qa
  var env = karate.env || 'qa';
  karate.log('karate.env =', env);

  var config = {
    env: env,
    baseUrl: 'https://automationexercise.com/api'
  };

  if (env === 'local') {
    config.baseUrl = 'http://localhost:8080/api';
  } else if (env === 'qa') {
    config.baseUrl = 'https://automationexercise.com/api';
  } else if (env === 'staging') {
    config.baseUrl = 'https://staging.automationexercise.com/api';
  } else if (env === 'prod') {
    config.baseUrl = 'https://api.example.com';
  }

  // Karate SSL configuration (set to true to disable cert validation in non-prod)
  karate.configure('ssl', true);

  // Default connection and read timeouts (in milliseconds)
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 30000);

  return config;
}
