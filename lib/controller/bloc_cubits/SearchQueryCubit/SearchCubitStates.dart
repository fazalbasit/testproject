abstract class SearchQueryEvent {}

class SetQuery extends SearchQueryEvent {
  final String query;

  SetQuery(this.query);
}

class ToggleSearch extends SearchQueryEvent {}

class SearchQueryState extends SearchQueryEvent {
  final String query;
  final bool isSearching;

  SearchQueryState({required this.query, required this.isSearching});
}
