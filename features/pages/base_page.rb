class BasePage
  include Capybara::DSL
  include RSpec::Matchers

  def visit_url(path = "")
    visit("#{BASE_URL}#{path}")
  end

  # Fill by id/name/label (visible)
  def fill(locator, with:)
    fill_in(locator, with:, visible: true)
  end

  # Click trying by ID (#submitBtn), text button, or text link
  def click_button_or_link(locator)
    if locator.is_a?(String) && locator.match?(/\A[A-Za-z][\w\-]*\z/) && page.has_css?("##{locator}", wait: 1)
      find("##{locator}", wait: 10).click
      return
    end

    find(:button, locator, visible: true, wait: Capybara.default_max_wait_time).click
  rescue Capybara::ElementNotFound
    find(:link, locator, visible: true, wait: Capybara.default_max_wait_time).click
  end

  # -------- SPDS Dropdown (Priority) --------
  # Using data-validation-path + trigger + option buttons role="option"
  def select_spds_by_validation_path(path:, option_text:)
    wrapper = find("[data-validation-path='#{path}']", wait: 10)

    wrapper.find("button.spds-input-dropdown-list-trigger", wait: 10).click

    wrapper.find(
      "button.spds-input-dropdown-list-item[role='option']",
      text: option_text,
      match: :first,
      wait: 10
    ).click

    expect(wrapper).to have_css(
      ".spds-input-dropdown-list-trigger-text-container",
      text: option_text,
      wait: 10
    )
  end

  # -------- Typeahead Select-box (Client / Assigned To) --------
  def select_typeahead_by_validation_path(path:, option_text:)
  wrapper = find("[data-validation-path='#{path}']", wait: 10)

  # Open typeahead
  wrapper.find(".select-box[role='combobox']", wait: 10).click

  # Write in searchbox
  search = wrapper.find(".select-box__input[role='searchbox']", wait: 10)
  search.set(option_text)

  # Wait for the dropdown options (can render outside the wrapper)
  expect(page).to have_css(".select-box__options[role='listbox'] .select-box__option[role='option']", wait: 10)

  # Click the text option (searching all the page)
  find(".select-box__option[role='option']",
       text: option_text, match: :first, wait: 10).click

  # We verify
  expect(wrapper).to have_text(option_text, wait: 10)
  end
end
