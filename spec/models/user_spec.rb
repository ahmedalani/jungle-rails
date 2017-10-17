require 'rails_helper'

RSpec.describe User, type: :model do

  context 'given password not matching the password_confirmation field' do 
    it 'should return an error' do
      @user = User.create(first_name: 'a', last_name: 'b', password: '12345', password_confirmation: '54321', email: 'a@b.com')
      expect(@user.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
    end 
  end 

  context 'given a user with an existing email' do 
    it 'should return an error tham email has already been taken' do
      @user1 = User.create(first_name: 'c', last_name: 'd', password: '12345', password_confirmation: '12345', email: 'c@d.com')
      @user2 = User.create(first_name: 'c', last_name: 'd', password: '12345', password_confirmation: '12345', email: 'C@D.com') 
      expect(@user2.errors.messages[:email]).to include('has already been taken')
    end 
  end 

  context 'given a user with blank first name, last name, and email' do 
    it 'should return a validation error: first name, last name, email can\'t be black' do
      @user = User.create(first_name: '', last_name: '', password: '12345', password_confirmation: '12345', email: '')
      expect(@user.errors.messages).to include(:first_name=>["can't be blank"], :last_name=>["can't be blank"], :email=>["can't be blank"])
    end 
  end 

  context 'given user with password less than minimum allowed' do 
    it 'should return error, password too short' do
      @user = User.create(first_name: 'a', last_name: 'b', password: '1234', password_confirmation: '1234', email: 'a@b.com')      
      expect(@user.errors.messages[:password]).to include('is too short (minimum is 5 characters)')
    end 
  end 

  describe '.authenticate_with_credentials' do     
    context 'given user with valid login email and password' do 
      it 'should return true if user used correct login to authenticate_with_credentials method' do 
        @user = User.create(first_name: 'a', last_name: 'b', password: '12345', password_confirmation: '12345', email: 'a@b.com')      
        user = @user.authenticate_with_credentials('a@b.com', '12345')
        expect(user).to eq(@user)
      end 
    end 
    
    context 'given user with valid login email(include whitespaces) and password' do 
      it 'should return true if user used correct login to authenticate_with_credentials method' do 
        @user = User.create(first_name: 'a', last_name: 'b', password: '12345', password_confirmation: '12345', email: 'a@b.com')      
        user = @user.authenticate_with_credentials(' a@b.com ', '12345')
        expect(user).to eq(@user)
      end 
    end 

    context 'given user with valid login email( with wrong letter uppercased) and password' do 
      it 'should return true using correct login to authenticate_with_credentials method' do 
        @user = User.create(first_name: 'a', last_name: 'b', password: '12345', password_confirmation: '12345', email: 'eXample@domain.COM')      
        user = @user.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', '12345')
        expect(user).to eq(@user)
      end 
    end 
  end 

end
