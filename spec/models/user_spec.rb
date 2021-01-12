require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with all fields" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      expect(@user).to be_valid
    end
    it "is invalid when missing name" do
      @user = User.new(name: nil, email:"test@test.com", password:"test", password_confirmation:"test")
      expect(@user).to_not be_valid
    end
    it "is invalid when missing email" do
      @user = User.new(name: "TEST", email:nil, password:"test", password_confirmation:"test")
      expect(@user).to_not be_valid
    end
    it "is invalid when missing password" do
      @user = User.new(name: "TEST", email:"test@test.com", password:nil, password_confirmation:"test")
      expect(@user).to_not be_valid
    end
    it "is invalid when missing password_confirmation" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:nil)
      expect(@user).to_not be_valid
    end
    it "is invalid when email is already in use" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      @user2 = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      assert @user.save
      assert !@user2.save
    end
    it "is invalid when password_confirmation doesn't match" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"wrong")
      expect(@user).to_not be_valid
    end
    it "is invalid when password is too short" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"a", password_confirmation:"a")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns nil for invalid login" do 
      @user = User.authenticate_with_credentials("test", "incorrect")
      expect(@user).to be_nil
    end

    it "returns a user for valid login" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      @user.save
      @test = User.authenticate_with_credentials("test@test.com", "test")
      expect(@test).to_not be_nil
    end

    it "returns a user for valid login when extra spaces present" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      @user.save
      @test = User.authenticate_with_credentials("   test@test.com   ", "test")
      expect(@test).to_not be_nil
    end

    it "returns a user for valid login with incorrect case" do
      @user = User.new(name: "TEST", email:"test@test.com", password:"test", password_confirmation:"test")
      @user.save
      @test = User.authenticate_with_credentials("TEST@TEST.com", "test")
      expect(@test).to_not be_nil
    end
  end
end
