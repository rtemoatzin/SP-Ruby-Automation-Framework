class LoginPage < BasePage
  def open
    visit(BASE_URL)

    # If there is an active session:
    return if logged_in?

    # If there is not an active session, check that we are in Sign In page:
    expect(page).to have_css("body.saml-idp.new.signin", wait: 15)
    expect(page).to have_field("user_email", wait: 15)
  end

  def login(email:, password:)

    fill("user_email", with: email)
    fill("user_password", with: password)
    find("#submitBtn", wait: 15).click

    expect(page).to have_css("div.ember-application", wait: 20)
  end

  private

  def logged_in?
    page.has_css?("div.ember-application", wait: 2)
  end
end
