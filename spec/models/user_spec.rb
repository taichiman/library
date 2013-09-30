require 'spec_helper'

describe User do
  before{ @user = User.new name: "Example User", email: "user@example.com", password: 'foobar', password_confirmation: 'foobar' }
  subject{ @user }

  it{ should respond_to :name }
  it{ should respond_to :email }
  it{ should respond_to :password_digest }
  it{ should respond_to :password }
  it{ should respond_to :password_confirmation }
  it{ should respond_to :authenticate }

  it{ should be_valid }

  describe "when name is valid" do
    before { @user.name = ' ' }
    it{ should_not be_valid }
  end
  describe "when user email is not present" do
    before { @user.email = '' }
    it{ should_not be_valid }
  end
  describe "when name is too long" do
    before { @user.name = 'a'*51 }
    it{ should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      adresses = %w[ foo@bar..com user@foo,com user_at_foo.org examle.user@foo. foo@bar_baz.com foo@bar+baz.com  ]
      adresses.each do | invalid_adress |
        @user.email = invalid_adress
        expect( @user ).not_to be_valid
      end
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      adresses = %w[ user@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp ]
      adresses.each do | valid_adress |
        @user.email = valid_adress
        expect( @user ).to be_valid
      end
    end
  end
  
  describe "email adress with mixed case" do
    let( :mixed_case_email ) { "Foo@Example.com" }

    it "should save with lover case" do
      @user.email = mixed_case_email
      @user.save
      expect( @user.reload.email ).to eq mixed_case_email.downcase
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when password not present" do
    before {
      @user = User.new name: "Example User", email: "user@example.com", password: ' ', password_confirmation: ' ' 
    }
    it{ should_not be_valid }
  end

  describe "when password mismatch confirmation" do
    before do
      @user.password_confirmation = 'mismatch' 
    end
    it { should_not be_valid }
  end

  describe "return value of autheticate method" do
    before{ @user.save }
    let( :found_user ){ User.find_by email: @user.email }

    describe "with valid password" do
      it { should eq found_user.authenticate( @user.password ) }
    end

    describe "with invalid password" do
      let( :user_for_invalid_password ) { found_user.authenticate "invalid" }
      it{ should_not eq user_for_invalid_password }
      specify { expect( user_for_invalid_password ).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = 'a'*5 }
    it { should be_invalid }
  end
end


