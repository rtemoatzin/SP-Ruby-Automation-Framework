# TASKS_CHECKLIST

This checklist covers expected positive behaviors (“happy paths”) for the Tasks feature.
Sections are grouped by meaningful user workflows (Create, View/List, Edit, Complete, Filters, Search, Attachments).

---

## 1) Access & Navigation

- Navigate to Tasks page from the Main Page and see the Tasks list load successfully.
- Clicking the 'Create task' button opens the New Task form.
- Close the New Task form to return to the Tasks list view

---

## 2) Tasks List

- Tasks list displays existing tasks under the selected status filter
- Each task card displays expected summary info (title, due date/time if set, client if set, assignee if set, priority badge if set).
- Clicking a task card opens the Edit task form.

---

## 3) Search

- Using the Search field updates the Tasks list in real time.
- The Tasks list displays only tasks that contains in its summary the content input into the Search field.
- Clearing the search input returns to the full list for the selected filters.

---

## 4) Filters

- Status filter changes between All / Incomplete / Completed and updates the list accordingly.
- Asignee filter can be changed to a specific asignee and updates the list accordingly.
- Sort filter changes between Custom / Due Date / Date Created / Priority and sorts the list accordingly.
- Default status filter on page load is Incomplete.
- Default asignee filter on page load is All.
- Default sort filter on page load is Custom.
- Switching the filters sets the defaults to the last filters visited.
- Tasks are rendered and remain interactable after switching filters.
- Combined filters update the list according all applied filters.

---

## 5) Create Task

5.1 Minimal Create (required fields only)
- Create a task using only Task Name and Save; task is created successfully and is displayed in the list.
- Selecting '+ Add quick task' creates a new blank Task card to be filled with a Task name; entering a name saves the task succesfully and is displayed in the list.

5.2 Full Create (all supported fields)
- Create a task with:
  - Task Name
  - Description
  - Due Date
  - Due Time (after due date is provided)
  - Priority
  - Client
  - Assigned To
  - Attachment upload
  - Save
  and verify the task is created successfully and is displayed in the Tasks list.

5.3 Field behaviors
- Due Time input becomes enabled after selecting a Due Date.
- Priority dropdown allows selecting each option and the selected value is reflected in the UI.
- Using the Client dropdown Search field displays suggestions accordingly and selecting one associates the client with the task.
- Using the Assigned To dropdown Search field displays suggestions accordingly and selecting one associates the asignee(s) with the task.
- Attachment upload accepts a valid file and displays the filename in the UI.

---

## 6) Edit Task

- Open an existing task, update Task Name, and Save; changes persist and display across navigation/refresh.
- Update Description and Save; changes persist.
- Update Due Date/Time and Save; changes persist and display correctly in the list.
- Update Priority and Save; badge/value updates and persists.
- Update Client and Save; associated client updates and persists.
- Update Assigned To and Save; assignee updates and persists.
- Add an attachment to an existing task and Save; attachment is linked and visible.
- Selecting 'Delete Task' removes the task from the Tasks list

---

## 7) Complete Task

- From the Incomplete filter, marking a task as completed by clicking on the checkbox moves it to the Completed list.
- From the Completed filter, marking a task as incomplete by clicking on the checkbox moves it to the Incomplete list.

---

## 8) Attachments

- Upload a supported file type and the upload completes successfully.
- Clicking on the attachment opens it.
- Every attachment has an option menu represented by a 3 dots button.
- The attachment's option menu has a Download, Rename and a Delete option.
- The attachment is able to be downloaded using the Download option.
- The attachment is able to be renamed using the Rename button.
- The attachment is deleted from the task after using the Delete option.
- Attachment is retained after refresh/navigation.
