require 'spec_helper'

describe "UserPages" do
  subject{ page }
  describe "SignUp page" do
    before { visit signup_path }
    it { should have_content( 'SignUp' ) }
    it { should have_title( full_title( 'SignUp' ) ) }
  end
end
