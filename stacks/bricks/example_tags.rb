# Defines Example specific parameters and tags
# - client
# - projects
# - environments
# 
# Also defines the globals.example_tags method

# Client name
parameter :client do
  default globals.client
end

# Project name
parameter :project do
  default globals.project
end

# Environment name
parameter :environment do
  default globals.environment
end

# Output from this method can be passed directly to the tags parameter block
# 
# Example:
# resource :name do 
#   type "AWS::EC2::Instance"
#   properties do 
#     tags globals.example_tags
#   end
# end
def globals.example_tags 
  {
    :client => ref(:client),
    :project => ref(:project), 
    :environment => ref(:environment),
  }
end