# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Immune::Application.initialize!

config.frameworks -= [ :active_record, :active_resource, :action_mailer]