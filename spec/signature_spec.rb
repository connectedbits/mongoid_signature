require 'spec_helper'

describe Mongoid::Signature do
  before do
    @user = User.new(:name => 'Eric')
  end

  describe "a new instance" do
    it "should have a nil signature field" do
      @user.signature.should be_nil
    end
  end  
  
  describe "two instances with the same signature fields" do
    before do
      @post1 = Post.new(:title => 'My Great Blog Post', :body => 'I was born...')
      @post2 = Post.new(:title => 'My Great Blog Post', :body => 'I was born...')
      @post1.sign!
      @post2.sign!
    end

    it "should have the same signature" do
      @post1.signature.should  == @post2.signature
    end 

    describe "with otherwise different data" do
      before do
        @post1.published = true
        @post2.published = false
      end

      it "should both have the same signature" do
        @post1.signature.should == @post2.signature
      end
    end
  end
  
  describe "two instances with different signature fields" do
    before do
      @post1 = Post.new(:title => 'My Great Blog Post', :body => 'I was born...')
      @post2 = Post.new(:title => 'Been Busy!', :body => 'Sorry for not posting but...')
      @post1.sign!
      @post2.sign!
    end

    it "should not have the same signature" do
      @post1.signature.should_not == @post2.signature
    end 
  end
  
  describe "an instance with a related document" do
    before do
      @post_from_user1 = Post.new(:title => 'My Great Blog Post', :body => 'I was born...', :user => User.new(:name => 'Eric'))
      @post_from_user2 = Post.new(:title => 'My Great Blog Post', :body => 'I was born...', :user => User.new(:name => 'Dave'))
      @post_from_user1.sign!
      @post_from_user2.sign!
    end

    it "should not have the same signature" do
      @post_from_user1.signature.should_not == @post_from_user2.signature
    end 
  end
end
