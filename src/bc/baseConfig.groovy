package bc;

class baseConfig {
  // Wait timeout in minutes
  public static final int WAIT_TIMEOUT = 10

  // Deployment Environment TAGs
  public static final String[] DEPLOYMENT_ENVIRONMENT_TAGS = ['dev', 'test', 'prod']

  // The name of the project namespace(s).
  public static final String  NAME_SPACE = '7cba16'

  // Instance Suffix
  public static final String  SUFFIX = '-primary'

  // Apps - Listed in the order they should be tagged
  public static final String[] APPS = ['db', 'bc-reg-fdw', 'agent', 'backup', 'event-processor', 'bcreg-controller']
}