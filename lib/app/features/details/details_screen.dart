import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import 'bloc/bloc.dart';

class DetailsScreen extends StatefulWidget {
  final String carId;

  const DetailsScreen({
    super.key,
    required this.carId,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DetailsBloc _detailsBloc = getIt<DetailsBloc>();

  @override
  void initState() {
    super.initState();

    _detailsBloc.add(
      DetailsLoad(
        id: widget.carId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробнее'),
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        bloc: _detailsBloc,
        builder: (context, state) {
          return switch (state) {
            DetailsInitial() => const SizedBox.shrink(),

            DetailsLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),

            DetailsLoadSuccess() => _buildSuccess(state),

            DetailsLoadFailure() => _buildFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildSuccess(DetailsLoadSuccess state) {
    final car = state.car;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              car.imagePath,
              height: 220,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            car.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          Text(
            car.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 24),

          Text(
            'Характеристики',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          _buildCharacteristic(
            'Кузов',
            car.body ?? '-',
          ),

          _buildCharacteristic(
            'Двигатель',
            car.engine ?? '-',
          ),

          _buildCharacteristic(
            'Привод',
            car.drive ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _buildFailure(DetailsLoadFailure state) {
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
              'Не удалось загрузить автомобиль',
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
                _detailsBloc.add(
                  DetailsLoad(
                    id: widget.carId,
                  ),
                );
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristic(
    String name,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}