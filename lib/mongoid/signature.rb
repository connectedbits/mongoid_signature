require 'digest/md5'

module Mongoid::Signature
  extend ActiveSupport::Concern
  
  included do
    class_attribute :sign_fields
    delegate :sign_fields, :to => "self.class"
  end  
  
  def signature_string
    sig = ''
    self.sign_fields.each do |field|
      if self.respond_to?(field)
        if value = self.send(field)
          if value.respond_to?('signature_string')
            value = value.signature_string
          elsif value.respond_to?('to_s')
            value = value.to_s
          end
          sig << value if !value.blank?
        end  
      end
      sig << ';'
    end if self.sign_fields
    sig
  end

  def sign!
    sig = (Digest::MD5.new << self.signature_string).to_s
    self.signature = sig if self.respond_to?(:signature)
  end

  def unique_signature?
    match = self.class.where(signature: self.signature).first
    if match.nil?
      true
    else
      match._id == self._id && self.class.where(signature: self.signature).count < 2
    end
  end      

  def validate_unique_signature
    if unique_signature? 
      true
    else
      errors.add(:base, "is a duplicate")
      false
    end
  end
  
  module ClassMethods
    def sign_document(options = {})
      self.sign_fields = options[:include]
      if options[:save_signature]
        class_eval <<-EOV
          field :signature, :type => String, :required => true
          index :signature
          before_validation :sign!
        EOV
      end
    end
  end
end
