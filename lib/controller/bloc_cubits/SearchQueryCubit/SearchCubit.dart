import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/controller/bloc_cubits/SearchQueryCubit/SearchCubitStates.dart';

class SearchQueryCubit extends Cubit<SearchQueryState> {
  SearchQueryCubit() : super(SearchQueryState(query: '', isSearching: false));

  void setQuery(String query, bool check) {
    emit(SearchQueryState(query: query, isSearching: check));
  }

  void toggleSearch() {
    emit(SearchQueryState(query: '', isSearching: !state.isSearching));
  }
}
