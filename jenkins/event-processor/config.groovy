// Pipeline Configuration Properties
// Import this file into the pipeline using 'load'.
class config extends bc.baseConfig {
  // Override - Wait timeout in minutes
  public static final  int WAIT_TIMEOUT = 30

  // Build configuration
  public static final String  APP_NAME = "event-processor"
  public static final String[] BUILDS = ["${this.APP_NAME}"]
}

return new config();