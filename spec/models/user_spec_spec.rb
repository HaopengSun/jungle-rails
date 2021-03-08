require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid if all contributes are present" do
      @user = User.new(name: 'test', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors).not_to include("can\'t be blank")
    end

    it "is not valid if the password and the password_confirmation are different" do
      @user = User.new(name: 'test', email: 'test@test.com', password: '12345', password_confirmation: '123456')
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is not valid if the name is missing" do
      @user = User.new(email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
  
      @user = User.new(name: 'test', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors[:name]).not_to include("can't be blank")
    end

    it "is not valid if the email is missing" do
      @user = User.new(name: 'test', password: '12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
  
      @user = User.new(name: 'test', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors[:email]).not_to include("can't be blank")
    end

    it "is not valid if the password is too short" do
      @user = User.new(name: 'test', email: 'test@test.com', password: '123', password_confirmation: '123')
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 5 characters)")
    end

    it "is not valid if the email should be unique" do
      @user1 = User.new(name: 'test1', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user1.save
      @user2 = User.new(name: 'test2', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user2.save
      expect(@user2.errors[:email]).to include('has already been taken')
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials when every condition is met' do
      @user = User.new(name: 'name', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.save
      @user = User.authenticate_with_credentials('test@test.com', '12345')
      expect(@user).not_to be(nil)
    end

    it 'should not pass when the password is incorrect' do
      @user = User.new(name: 'name', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.save
      @user = User.authenticate_with_credentials('test@test.com', '123456')
      expect(@user).to be(nil)
    end

    it 'should pass due to case insensitive of email' do
      @user = User.new(name: 'name', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.save
      @user = User.authenticate_with_credentials('TEST@test.com', '12345')
      expect(@user).not_to be(nil)
    end

    it 'should pass even though email with spaces' do
      @user = User.new(name: 'name', email: 'test@test.com', password: '12345', password_confirmation: '12345')
      @user.save
      @user = User.authenticate_with_credentials('  test@test.com   ', '12345')
      expect(@user).not_to be(nil)
    end
  end
end
