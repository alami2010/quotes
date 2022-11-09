import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quotez/bloc/network_connectivity/network_connectivity_cubit.dart';
import 'package:quotez/data/model/quote.dart';
import 'package:quotez/data/repository/quote_repository.dart';

part 'home_state.dart';

/// [HomeCubit] handles quote requests shown in the [HomeScreen]
/// Also listens to connectivity states from [NetworkConnectivityCubit]
class HomeCubit extends Cubit<HomeState> {
  final QuoteRepository quoteRepository;
  final NetworkConnectivityCubit networkCubit;
  StreamSubscription? networkCubitSubscription;

  String mentorx = "";

  HomeCubit({required this.quoteRepository, required this.networkCubit})
      : super(HomeInit()) {
    networkCubitSubscription = networkCubit.stream.listen((networkState) {
      if (networkState is NoNetworkConnectionState) {
        emit(HomeNoNetwork());
      } else if (networkState is NetworkConnectionUpdatedState) {
        getRandomQuote("AllQuotes");
      }
    });
  }

  /// [getRandomQuote] Returns a random quote.
  void getRandomQuote(String mentor) async {
    print("mentor " + mentor );
    print("mentorx " + mentorx );

    emit(HomeLoading());
    if(mentor.isNotEmpty) mentorx = mentor;
    String currentMentor = mentor.isEmpty ? mentorx : mentor;
    currentMentor =  currentMentor.isEmpty ? "AllQuotes" : currentMentor;
    print("currentMentor " + currentMentor );
    final newRandomQuote = await quoteRepository.getRandomQuote(currentMentor);
     emit(HomeLoaded(randomQuote: newRandomQuote));
  }
}
