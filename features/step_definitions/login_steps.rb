Given("I log into SimplePractice") do
  @login = LoginPage.new
  @login.open
  @login.login(email: EMAIL, password: PASSWORD)
end

Then("I should see the Calendar") do
  expect(page).to have_css("div.ember-application", wait: 20)
end

