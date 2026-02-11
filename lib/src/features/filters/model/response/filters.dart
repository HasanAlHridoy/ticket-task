/// Represents the type of UI a filter section should render.
enum FilterSectionType { checkbox, dropdown, tags }

/// A single selectable filter option (e.g., one brand, one priority level, one tag).
class FilterOption {
  final String id;
  final String label;
  final String? iconUrl; // Optional icon/logo URL

  const FilterOption({required this.id, required this.label, this.iconUrl});
}

/// A filter section (e.g., "Brand", "Priority", "Tags").
/// [type] determines the UI widget used to render this section.
class FilterSection {
  final String id;
  final String label;
  final FilterSectionType type;
  final List<FilterOption> options;

  const FilterSection({required this.id, required this.label, required this.type, required this.options});
}

/// The full filter configuration returned by the API.
/// Contains a dynamic list of sections — the UI renders them in order.
class FilterConfig {
  final List<FilterSection> sections;

  const FilterConfig({required this.sections});
}
