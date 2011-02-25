class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Signature
  
  field :title
  field :body
  field :published, :type => Boolean, :default => false
  
  referenced_in :users
  embeds_many :comments  
  
  sign_document :include => [:user, :title, :body], :save_signature => true
end