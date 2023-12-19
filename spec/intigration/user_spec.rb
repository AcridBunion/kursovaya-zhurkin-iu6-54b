# frozen_string_literal: true

require "json"
require "selenium-webdriver"
require 'rspec'
include RSpec::Expectations

describe "EnterSuccess" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_enter_sucsses" do
     @driver.get "http://localhost:3000/"
     @driver.find_element(:link, "Buy&Drive").click
     @driver.find_element(:link, "Войти").click
     @driver.find_element(:id, "user_email").click
     @driver.find_element(:id, "user_email").clear
     @driver.find_element(:id, "user_email").send_keys "a@1"
     @driver.find_element(:id, "user_password").click
     @driver.find_element(:id, "user_password").clear
     @driver.find_element(:id, "user_password").send_keys "111111"
     @driver.find_element(:xpath, "//form[@id='new_user']/div[4]/input").click
     @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Выйти'])[1]/following::p[1]").click
     @driver.find_element(:id, "navbarDropdown").click
     @driver.find_element(:link, "Выйти").click
   end

   it "test_wrong_password" do
     @driver.get "http://localhost:3000/"
     @driver.find_element(:link, "Buy&Drive").click
     @driver.find_element(:link, "Войти").click
     @driver.find_element(:id, "user_email").click
     @driver.find_element(:id, "user_email").clear
     @driver.find_element(:id, "user_email").send_keys "a@1"
     @driver.find_element(:id, "user_password").click
     @driver.find_element(:id, "user_password").clear
     @driver.find_element(:id, "user_password").send_keys "123456"
     expect("http://localhost:3000/users/sing_up")
   end


   it "test_find_true" do
     @driver.get "http://localhost:3000/autos/1"
     @driver.find_element(:link, "Buy&Drive").click
     @driver.find_element(:link, "Войти").click
     @driver.find_element(:id, "user_email").clear
     @driver.find_element(:id, "user_email").send_keys "a@1"
     @driver.find_element(:id, "user_password").click
     @driver.find_element(:id, "user_password").clear
     @driver.find_element(:id, "user_password").send_keys "111111"
     @driver.find_element(:xpath, "//form[@id='new_user']/div[4]/input").click
     @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Выйти'])[1]/following::p[1]").click
     @driver.find_element(:id, "title").click
     @driver.find_element(:id, "title").clear
     @driver.find_element(:id, "title").send_keys "BMW 320I 86000"
     @driver.find_element(:name, "commit").click
     expect("http://localhost:3000/find_autos/show?title=BMW+320I+86000&commit=%D0%9D%D0%B0%D0%B9%D1%82%D0%B8")
   end


   it "test_find_without_enter" do
     @driver.get "http://localhost:3000/autos/1"
     @driver.find_element(:link, "Buy&Drive").click
     @driver.find_element(:id, "title").click
     @driver.find_element(:id, "title").clear
     @driver.find_element(:id, "title").send_keys "BMW"
     @driver.find_element(:name, "commit").click
     expect("http://localhost:3000/find_autos/show?title=BMW&commit=%D0%9D%D0%B0%D0%B9%D1%82%D0%B8")
   end



  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
