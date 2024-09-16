require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      phone_number: '12345678',
      role: 'client',
      email: 'john.doe@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = User.new(first_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    user = User.new(last_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with an improperly formatted email' do
    user = User.new(email: 'invalid_email_format')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include('is invalid')
  end

  it 'is invalid if email is not unique' do
    User.create(
      first_name: 'John',
      last_name: 'Doe',
      phone_number: '12345678',
      role: 'client',
      email: 'john.doe@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    user = User.new(email: 'john.doe@example.com')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'is invalid without a password' do
    user = User.new(password: nil)
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid if the password is less than 6 characters' do
    user = User.new(password: 'short')
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

  it 'is invalid without a phone number' do
    user = User.new(phone_number: nil)
    expect(user).to_not be_valid
    expect(user.errors[:phone_number]).to include("can't be blank")
  end

  it 'is invalid if the phone number is not 8 digits' do
    user = User.new(phone_number: '12345')
    expect(user).to_not be_valid
    expect(user.errors[:phone_number]).to include('must be 8 digits')
  end
end