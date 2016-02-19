require "cloud_builder/version"
require "cloud_builder/cli"
require 'cloud_builder/dsl'
require 'cloud_builder/resource'
require 'cloud_builder/mappings'
require 'cloud_builder/reference'
require 'cloud_builder/stack'
require 'cloud_builder/brick'
require 'cloud_builder/jsonable'
require 'cloud_builder/parameter'
require 'cloud_builder/output'


require 'cloud_builder/dslostruct'
require 'cloud_builder/dontformatunderscore'
  
require 'json'
require 'forwardable'

module CloudBuilder
  DESCRIPTION = 'Description'
  GET_ATT     = 'Fn::GetAtt'
  FIND_IN_MAP = 'Fn::FindInMap'
  BASE64      = 'Fn::Base64'
  JOIN        = 'Fn::Join'
  KEY         = 'Key'
  MAPPINGS    = 'Mappings'
  PROPERTIES  = 'Properties'
  REF         = 'Ref'
  RESOURCES   = 'Resources'
  PARAMETERS  = 'Parameters'
  METADATA    = 'Metadata'
  OUTPUTS     = 'Outputs'
  TAGS        = 'Tags'
  TYPE        = 'Type'
  VALUE       = 'Value'
  PROPAGATE_AT_LAUNCH = 'PropagateAtLaunch'
  VERSION     = 'AWSTemplateFormatVersion'
  DELETION_POLICY = 'DeletionPolicy'
  UPDATE_POLICY = 'UpdatePolicy'
  DEPENDS_ON = 'DependsOn'

  
  class Spec
    extend DSL
  end
end

