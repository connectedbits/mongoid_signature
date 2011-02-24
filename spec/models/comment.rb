class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Signature
  
  field :body
  
  embedded_in :post
  referenced_in :user
  
  sign_document :include => [:user, :body]
end