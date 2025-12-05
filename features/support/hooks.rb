require "fileutils"

After do |scenario|
  next unless scenario.failed?

  begin
    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
    safe_name = scenario.name.gsub(/[^a-zA-Z0-9]+/, "_").downcase
    path = File.join("tmp", "capybara", "#{timestamp}-#{safe_name}.png")

    # Ensure the directory exists
    FileUtils.mkdir_p(File.dirname(path))

    # Save screenshot on failure
    page.save_screenshot(path)

    puts "Screenshot saved: #{path}"
  rescue StandardError => e
    warn "Screenshot failed: #{e.class} - #{e.message}"
  end
end
