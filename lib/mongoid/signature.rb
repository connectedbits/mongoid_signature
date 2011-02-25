require 'digest/md5'

module Mongoid::Signature
  extend ActiveSupport::Concern
  
  included do
    field :signature, :type => String, :required => true
    
    index :signature
    
    before_validation :sign!

    class_attribute :sign_fields
    delegate :sign_fields, :to => "self.class"
  end  
  
  def signature_string
    ss = ''
    sign_fields.each do |sf|
      if self.respond_to?(sf)
        if self.send(sf).respond_to?('signature_string')
          ss << self.send(sf).signature_string
        else
          ss << self.send(sf).to_s
        end
        ss << ';'
      end
    end if sign_fields
    ss
  end  

  def sign!
    sig = Digest::MD5.new << self.signature_string
    self.signature = sig.to_s
  end

  def validate_unique_signature
    dupe = self.class.where(:signature => self.signature).first
    errors.add(:base, "is a duplicate") if dupe
  end
  
  module ClassMethods
    def sign_document(options = {})
      self.sign_fields = options[:include]
    end
  end
end
