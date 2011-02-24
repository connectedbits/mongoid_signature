class User
  include Mongoid::Document
  include Mongoid::Signature
  
  field :name
  field :email
  
  references_many :posts
  references_many :comments
  
  sign_document :include => [:name]
end