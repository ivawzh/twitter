require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  it { should have_content(user.name)}
  it { should have_content(user.email)}

  describe "micropost creation" do
    before { visit root_path }
    it "should not create a micropost" do
      expect { click_button "Post" }.not_to change(Micropost, :count)
    end


    describe "error messages" do
      before { click_button "Post" }
      it { should have_content('error') }
    end


    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a microsoft" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end














end