# SimplePractice - UI Automation (Tasks feature)

This project contains UI automation tests for the **Tasks** feature using:

- Ruby
- Cucumber (BDD)
- Capybara
- Selenium (Chrome)

The main scenario covers:
1) Log in  
2) Navigate to Tasks  
3) Create a task filling all fields  
4) Mark the task as completed  
5) Verify the task appears under the **Completed** filter

---

## Repository Structure

- `features/pages/*` uses a **Page Object Model** approach (encapsulates selectors + actions).
- `features/step_definitions/*` contains the Cucumber steps calling Page methods.
- `features/support/env.rb` bootstraps Capybara/Selenium configuration.
- `features/support/hooks.rb` contains hooks (e.g., screenshot on failure).

---

## Prerequisites

### 1) Install Ruby
Recommended: Ruby **3.4+**

Verify:
```bash
ruby -v
bundle -v
```

### 2) Install Google Chrome
Make sure **Chrome** is installed.

Verify:
- Open Chrome → `chrome://version` (check it launches normally)

> Note: These tests run with Selenium controlling Chrome.

---

## Setup

### 1) Install Gems
From the project root:

```bash
bundle install
```

### 2) Configure Environment Variables

Create a file called **`.env`** in the project root. Example:

```bash
BASE_URL=URL_To_The_Test_Environment
EMAIL=Valid_Email
PASSWORD=Valid_Password
HEADLESS=true
```

**Variables**
- `BASE_URL` (required): Base URL for the app
- `EMAIL` (required): login email
- `PASSWORD` (required): login password
- `HEADLESS` (optional): `true` or `false`

## Running Tests

### Run Tasks feature only
```bash
bundle exec cucumber features/tasks.feature
```
---

## Screenshots on Failure

When a scenario fails, a screenshot is saved under:

```
tmp/capybara/
```

Example output:
```
Screenshot saved: tmp/capybara/20251203-130450-create_a_task....png
```

---

## Notes / Common Issues

### Chrome noise logs (GPU / GCM, etc.)
Chrome may print logs like:
- `Automatic fallback to software WebGL...`
- `QUOTA_EXCEEDED`, `DEPRECATED_ENDPOINT`

These are typically browser-level logs and do not necessarily indicate a test failure.

### Time / Dynamic Data
The task title is generated with a timestamp to avoid collisions; each run creates a unique task.
