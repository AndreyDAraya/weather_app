part of '../page.dart';

/// Widget for displaying a search bar.
class SearchWidget extends StatelessWidget {
  SearchWidget({
    super.key,
  });

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search ...',
      controller: searchController,
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.white),
      elevation: MaterialStateProperty.resolveWith((states) => 1),
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            BlocProvider.of<WeatherBloc>(context).add(OnLoadByCityNameEvent(
              cityName: searchController.text.trim(),
            ));
          },
        )
      ],
    );
  }
}
