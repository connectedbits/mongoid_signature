require 'digest/sha2'

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
      att = attributes[sf]
      if !att.nil?
        if att.respond_to?('signature_string')
          ss << att.signature_string
        else
          ss << att.to_s
        end
        ss << ';'
      end
    end if sign_fields
    ss
  end  

  def sign!
    sig = Digest::SHA2.new << self.signature_string
    self.signature = sig.to_s
  end

  def validate_unique_signature
    dupe = where(:signature => self.signature).first
    dupe = Report.first(:conditions => {:signature => self.signature})
    errors.add(:base, "is a duplicate") if dupe
  end
  
  module ClassMethods
    def sign_document(options = {})
      self.sign_fields = options[:include]
    end
  end
end
