When("I go to the Tasks page") do
  @tasks = TasksPage.new
  @tasks.open
end

When("I create a fully detailed task") do
  @task_title = "Test Automation Task #{Time.now.utc.strftime("%Y%m%d%H%M%S")}"

  @tasks.create_task(
    name: @task_title,
    description: "Task created by automation filling all available fields. Using Ruby, Cucumber, Capybara and Selenium.",
    due_on: "12/12/2025",          # mm/dd/yyyy
    due_time: "10:30 am",          # hh:mm am/pm (ajusta según UI)
    priority: "High",
    client: "test_first_name test_last_name",
    assigned_to: "Test Automation",
    attachment_path: "features/fixtures/sample.txt"
  )
end

When("I mark the task as Completed") do
  @tasks.complete_task(title: @task_title)
end

Then("I should see the task in the Completed filter") do
  puts "Switching filter at: #{Time.now}"
  @tasks.expect_task_in_completed(title: @task_title)
  puts "Found task at: #{Time.now}"
end
