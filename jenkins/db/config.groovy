// Pipeline Configuration Properties
// Import this file into the pipeline using 'load'.
class config extends bc.baseConfig {
  // Build configuration
  public static final String  APP_NAME = "db"
  public static final String[] BUILDS = ["${this.APP_NAME}"]

  // Deployment configuration
  public static final String[] DEPLOYMENTS = ["event-db", "event-processor-log-db", "wallet"]
}

return new config();