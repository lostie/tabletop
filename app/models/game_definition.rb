class GameDefinition
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :author, type: String
  field :version, type: String
end
