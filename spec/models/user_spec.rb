require 'spec_helper'

describe User do
  before :each do
    @user = User.new
  end

  it "should not add double properties" do
    User.property_names.size.should == User.property_names.uniq.size
  end

  describe 'accessing attributes' do
    it "should access attributes through [] on record" do
      @user.email = 'test@example.com'
      @user[:email].should == 'test@example.com'
    end
  end
  describe :database_authenticatable do

    it "should add email correctly" do
      property = User.properties.find{|p| p.name == :email }
      property.should_not be_nil
      property.type.should == String
    end
    it "should add encrypted_password correctly" do
      property = User.properties.find{|p| p.name == :encrypted_password }
      property.should_not be_nil
      property.type.should == String
    end

    it "should set encrypted_password by password= assignment" do
      @user.encrypted_password.should be_blank
      @user.password = '12345'
      @user.encrypted_password.should_not be_blank
    end
  end
  describe :rememberable do
    it "should add remember_created_at correctly" do
      property = User.properties.find{|p| p.name == :remember_created_at }
      property.should_not be_nil
      property.type.should == Time
    end
  end

  describe :recoverable do

    it "should add reset_password_token correctly" do
      property = User.properties.find{|p| p.name == :reset_password_token }
      property.should_not be_nil
      property.type.should == String
    end

    it "should add reset_password_sent_at correctly" do
      property = User.properties.find{|p| p.name == :reset_password_sent_at }
      property.should_not be_nil
      property.type.should == Time
    end

  end

  describe :trackable do
    it "should add sign_in_count correctly" do
      property = User.properties.find{|p| p.name == :sign_in_count}
      property.should_not be_nil
      property.type.should == Fixnum
    end
    it "should add current_sign_in_at correctly" do
      property = User.properties.find{|p| p.name == :current_sign_in_at }
      property.should_not be_nil
      property.type.should == Time
    end
    it "should add last_sign_in_at correctly" do
      property = User.properties.find{|p| p.name == :last_sign_in_at }
      property.should_not be_nil
      property.type.should == Time
    end
    it "should add current_sign_in_ip correctly" do
      property = User.properties.find{|p| p.name == :current_sign_in_ip}
      property.should_not be_nil
      property.type.should == String
    end
    it "should add last_sign_in_ip correctly" do
      property = User.properties.find{|p| p.name == :last_sign_in_ip}
      property.should_not be_nil
      property.type.should == String
    end
  end
end
