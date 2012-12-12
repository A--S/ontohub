require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many :comments
  should have_many :ontology_versions
  should have_many :team_users
  should have_many :teams
  should have_many :permissions
  
  should_strip_attributes :name, :email
  should_not_strip_attributes :password
  
  context 'User instance' do
    setup do
      @mails_sent = ActionMailer::Base.deliveries.size
      @user = FactoryGirl.create :user
    end
    
    should 'sent email' do
      assert_equal @mails_sent+1, ActionMailer::Base.deliveries.size
    end
    
    should 'have email' do
      assert_not_nil @user.email
    end
    
    should 'have name' do
      assert_not_nil @user.name
    end
    
    should 'not have deleted_at' do
      assert_nil @user.deleted_at
    end
    
    context 'after deletion' do
      setup do
        @user.delete
      end
      
      should 'have blank email' do
        assert_nil @user.email
      end
      
      #should 'have blank password' do
      #  assert_nil @user.password
      #end
      
      should 'have deleted_at' do
        assert_not_nil @user.deleted_at
      end
    end
    
  end
  
  context 'Admin instance' do
    setup do
      @admins = 2.times.map{ FactoryGirl.create :admin }
    end
    
    should 'destroy one admin' do
      @admins.first.destroy
    end
    
    should 'destroy not destroy all admins' do
      assert_raises Permission::PowerVaccuumError do
        @admins.each(&:destroy)
      end
    end
  end
  
end
