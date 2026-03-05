import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/person_model.dart';
import '../widgets/person_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<Person> _people = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasNext = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPeople();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasNext) {
      _currentPage++;
      _fetchPeople();
    }
  }

  Future<void> _fetchPeople() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _apiService.fetchPeople(_currentPage);

      setState(() {
        _people.addAll(data["people"]);
        _hasNext = data["next"] != null;
      });
    } catch (e) {
      setState(() {
        _error = "Network problem";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text(_error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Characters",
        style: TextStyle(
          fontWeight: FontWeight.bold,


      ),



      ),
          centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _people.length + 1,
        itemBuilder: (context, index) {
          if (index < _people.length) {
            return PersonCard(person: _people[index]);
          } else {
            return _isLoading
                ? const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            )
                : const SizedBox();
          }
        },
      ),
    );
  }
}