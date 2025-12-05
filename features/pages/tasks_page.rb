class TasksPage < BasePage
  TASKS_PATH = "/tasks"
  NEW_TASK_PATH = "/tasks/new"

  def open
    visit_url(TASKS_PATH)
    expect(page).to have_current_path(/\/tasks/, wait: 20)
    expect(page).to have_content(/Tasks/i, wait: 20)
  end

  def start_new_task
    click_link("Create task")
    expect(page).to have_current_path(/\/tasks\/new/, wait: 15)
    expect(page).to have_field("title", wait: 15)
  end

  # Params (Only 'name' is required):
  # name: (required)
  # description:
  # due_on: "mm/dd/yyyy"
  # due_time: "hh:mm am" (only if there is a due_on)
  # priority: "High" | "Medium" | ...
  # client: "FirstName LastName" | ...
  # assigned_to: "FirstName LastName" | ...
  # attachment_path: "features/fixtures/sample.txt"
  def create_task(
    name:,
    description: nil,
    due_on: nil,
    due_time: nil,
    priority: nil,
    client: nil,
    assigned_to: nil,
    attachment_path: nil
  )
    start_new_task

    fill("title", with: name)
    fill("description", with: description) if description

    if due_on
      set_due_date(due_on)
      set_due_time(due_time) if due_time
    end

    select_spds_by_validation_path(path: "priority", option_text: priority) if priority
    select_typeahead_by_validation_path(path: "client", option_text: client) if client
    select_typeahead_by_validation_path(path: "taskAssignments", option_text: assigned_to) if assigned_to

    attach_attachment(attachment_path) if attachment_path

    click_button("Save")
    expect(page).to have_content(name, wait: 20)
  end

  def complete_task(title:)
    ensure_status_filter("Incomplete") #By default

    task_button = find("button.button-link", text: title, wait: 20)
    task_container = task_button.find(:xpath, "./ancestor::div[.//input[starts-with(@id,'isCompleted-')]][1]")
    checkbox_circle = task_container.find("label[for^='isCompleted-'] .checkable-circle", wait: 10)

    # Selenium scroll
    begin
      page.execute_script("arguments[0].scrollIntoView({block: 'center'});", checkbox_circle.native)
    rescue StandardError
    end

    checkbox_circle.click

    # The completed task disappears from the 'Incomplete' filter
    expect(page).to have_no_css("button.button-link", text: title, wait: 20)
  end

  def expect_task_in_completed(title:)
    ensure_status_filter("Completed")
    expect(page).to have_css("button.button-link", text: title, wait: 20)
  end

  private

  # ----- Due date/time -----

  def set_due_date(mmddyyyy)
    wrapper = find("[data-validation-path='dueAt']", wait: 10)
    date_input = wrapper.find("input[name='datePicker']", wait: 10)

    date_input.click
    date_input.set(mmddyyyy)
    date_input.send_keys(:enter)
  end

  def set_due_time(hhmm_ampm)
    wrapper = find("[data-validation-path='dueAt']", wait: 10)
    time_input = wrapper.find("#timePicker", visible: :all, wait: 10)

    # Wait for the timePicker to be enabled
    expect(page).to have_no_css("#timePicker:disabled", wait: 10)

    time_input.click
    time_input.set(hhmm_ampm)
    time_input.send_keys(:enter)
  end

  # ----- Attachment -----

  def attach_attachment(path)
    full_path = File.expand_path(path, Dir.pwd)
    find("input[type='file']", visible: :all, wait: 10).attach_file(full_path)

    # Validate that the file name is displayed
    expect(page).to have_text(File.basename(full_path), wait: 10)
  end

  # ----- Status filter (All / Incomplete / Completed) -----
  
  # Search for the toolbar
  def tasks_toolbar
    find(".o0dc1", match: :first, wait: 10).find("input.utility-search", wait: 10).find(:xpath, "./ancestor::*[contains(@class,'o0dc1')][1]")
  end

  def status_filter_root
    # Search for the dropdown with "All/Incomplete/Completed" values
    tasks_toolbar.find("div.dropdown-list", match: :first, wait: 10).tap do |first_dropdown|
      candidates = tasks_toolbar.all("div.dropdown-list", wait: 1)
      found = candidates.find do |d|
        d.has_css?("button.utility-button-style[value='All'], button.utility-button-style[value='Incomplete'], button.utility-button-style[value='Completed']", wait: 1)
      end
      return found if found
      return first_dropdown
    end
  end

  def status_filter_button
    status_filter_root.find(
      "button.utility-button-style[value='All'], "\
      "button.utility-button-style[value='Incomplete'], "\
      "button.utility-button-style[value='Completed']",
      wait: 10
    )
  end

  def current_status_filter
    status_filter_button[:value]
  end

  def open_status_filter_dropdown
    status_filter_button.click
    expect(status_filter_root).to have_css(".menu", wait: 10)
  end

  def set_status_filter(value)
    value = value.to_s
    return if current_status_filter == value

    open_status_filter_dropdown

    # items: <div class="item"><button><span>VALUE</span></button></div>
    status_filter_root.find(".menu .item button", text: value, match: :first, wait: 10).click
    expect(status_filter_root).to have_css("button.utility-button-style[value='#{value}']", wait: 10)
  end

  def ensure_status_filter(value)
    set_status_filter(value)
  end
end
