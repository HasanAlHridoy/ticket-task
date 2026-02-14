# Gian Ticket Task Project Overview

This project is a Flutter application designed for managing and filtering support tickets, while also providing contact management and user profile features. It follows a modular architecture with Riverpod for state management and GoRouter for navigation.

## 🚀 Application Flow (First to Last)

1.  **App Initialization**:
    *   The app starts in `main.dart`, initializing `ScreenUtil` for responsive design.
    *   `GoRouter` sets up the initial route (`/`) which points to the **HomeView**.
    *   A `ShellRoute` is used to wrap the main views with a `CustomBottomNavBar`.

2.  **Home Feed**:
    *   The `HomeProvider` automatically fetches a list of tickets from the `TicketService`.
    *   The UI renders a **HomeAppBar** and a **TicketStatsHeader** (displaying ticket count).
    *   The **TicketListView** displays the fetched tickets using **TicketCard** components.

3.  **Filtering Journey**:
    *   User clicks the filter icon in the `TicketStatsHeader`.
    *   The app navigates to `/filters`.
    *   **FilterService** generates a configuration by analyzing current ticket data (extracting unique Brands, Tags, and Priorities).
    *   The **FiltersView** randomizes the visibility of optional sections like "Tags" and "Overdue" on each open.
    *   User selects filter options. These are tracked locally in `FiltersProvider`.
    *   User clicks "Apply". The selections are pushed to the `HomeProvider`.
    *   The **HomeView** re-renders, showing only tickets that match the criteria.

4.  **Secondary Navigation**:
    *   User switches to the **Contacts** tab via the bottom navigation bar.
    *   User can search for contacts or interact with contact cards (delete/edit).
    *   User switches to the **Profile** tab to view their information and assigned roles.

---

## 🛠 Feature Breakdown

### 1. Home (Dynamic)
*   **Ticket Feed**: Displays all tickets or filtered results.
*   **Stats Header**: Dynamically updates the ticket count as filters are applied.
*   **Refresh**: User can pull-to-refresh to reset filters and fetch fresh data.

### 2. Filters (Highly Dynamic)
*   **Dynamic Options**: Brand, Priority, and Tag options are extracted from the actual data, not hardcoded.
*   **Conditional Randomization**: Optional sections (Tags, Overdue) appear/disappear randomly *unless* they have an active filter applied.
*   **State Persistence**: Filter selections are saved in the global `HomeProvider`, allowing the UI to restore choices even after closing the filter page.
*   **Modular Rendering**: Uses a `FilterSectionHub` to switch between Checkbox, Dropdown, and Tag UI styles based on section type.

### 3. Contacts (Dynamic)
*   **Search**: Real-time filtering of the contact list based on name.
*   **Action Menu**: Contact cards feature a popup menu for "Edit", "View tickets", and "Delete".
*   **Delete Action**: Fully functional deletion that updates the UI immediately.

### 4. Profile (Static/Data-Driven)
*   **User Info**: Displays avatar, name, email, and role from the `ProfileService`.
*   **Role Cards**: A horizontally scrolling list of assigned roles with manager information.

---

## 🏗 Technical Architecture

*   **State Management**: `flutter_riverpod` (using Notifiers and AsyncNotifiers).
*   **Navigation**: `go_router` for declarative routing and deep linking.
*   **UI/UX**:
    *   `flutter_screenutil` for pixel-perfect scaling across devices.
    *   **Atomic Design**: Small reusable widgets (e.g., `TicketCard`, `BasicInfoSection`) are separated into `components` folders for each feature.
    *   **Theme**: Custom extensions for easy access to theme and screen spacing (e.g., `.ph` for padding).

## 📊 Summary: What is Dynamic vs Static

| Feature | Element | Logic Type | Rationale |
| :--- | :--- | :--- | :--- |
| **Home** | Ticket List | **Dynamic** | Changes based on applied filter state. |
| **Filters** | Section Visibility | **Dynamic** | Sections "come and go" randomly. |
| **Filters** | Option Lists | **Dynamic** | Derived from actual ticket meta-data. |
| **Contacts** | Search Result | **Dynamic** | Updates as the user types. |
| **Profile** | User Data | **Dynamic** | Fetched from the profile service (simulated API). |
| **Navigation** | Bottom Bar | **Static** | Always visible and fixed at the bottom. |
| **UI** | Card Layouts | **Static** | Templates are fixed; only the content changes. |
