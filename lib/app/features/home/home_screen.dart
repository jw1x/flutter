import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../widgets/widgets.dart';
import 'bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();

    _homeBloc.add(
      const HomeLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог автомобилей'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),

            HomeLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),

            HomeLoadSuccess() => _buildSuccess(state),

            HomeLoadFailure() => _buildFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildSuccess(HomeLoadSuccess state) {
    final cars = state.cars;

    return RefreshIndicator(
      onRefresh: () async {
        _homeBloc.add(
          const HomeLoad(),
        );

        await _homeBloc.stream.firstWhere(
          (state) =>
              state is HomeLoadSuccess ||
              state is HomeLoadFailure,
        );
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        separatorBuilder: (_, _) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final car = cars[index];

          return ContentCard(
            id: car.id,
            title: car.title,
            description: car.description,
            imagePath: car.imagePath,
          );
        },
      ),
    );
  }

  Widget _buildFailure(HomeLoadFailure state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Не удалось загрузить автомобили',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.exception.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _homeBloc.add(
                  const HomeLoad(),
                );
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}