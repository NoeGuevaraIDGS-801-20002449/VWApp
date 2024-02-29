import 'package:flutter/material.dart';

// Importa tus proveedores aquí
import 'package:vwapp/provider/personal_provider.dart';
import 'package:vwapp/provider/herramienta_provider.dart';
import 'package:vwapp/provider/linea_provider.dart';

class CustomSearchDelegate<T> extends SearchDelegate<String> {
  final T pdProvider; // Usar un tipo genérico T para el proveedor
  CustomSearchDelegate(this.pdProvider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia la consulta de búsqueda.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Cierra la barra de búsqueda y regresa nulo.
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final query = this.query.toLowerCase();

    // Utiliza pdProvider de acuerdo con el tipo genérico T
    if (pdProvider is HerramientaProvider) {
      final filteredItems =
          (pdProvider as HerramientaProvider).error.where((item) {
        final tipoError = item['tipoError'].toString().toLowerCase();
        final prioridad = item['prioridad'].toString().toLowerCase();
        return tipoError.contains(query) || prioridad.contains(query);
      }).toList();

      return ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item['tipoError']),
            subtitle: Text(item['prioridad']),
            onTap: () {
              _showDetailsScreen(context, item);
            },
          );
        },
      );
    } else if (pdProvider is LineaProvider) {
      final filteredItems = (pdProvider as LineaProvider).error.where((item) {
        final tipoError = item['tipoError'].toString().toLowerCase();
        final prioridad = item['prioridad'].toString().toLowerCase();
        return tipoError.contains(query) || prioridad.contains(query);
      }).toList();

      return ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item['tipoError']),
            subtitle: Text(item['prioridad']),
            onTap: () {
              _showDetailsScreen(context, item);
            },
          );
        },
      );
    } else if (pdProvider is PersonalProvider) {
      final filteredItems =
          (pdProvider as PersonalProvider).error.where((item) {
        final tipoError = item['tipoError'].toString().toLowerCase();
        final prioridad = item['prioridad'].toString().toLowerCase();
        return tipoError.contains(query) || prioridad.contains(query);
      }).toList();

      return ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item['tipoError']),
            subtitle: Text(item['prioridad']),
            onTap: () {
              _showDetailsScreen(context, item);
            },
          );
        },
      );
    }

    return Center(
      child: Text('Proveedor no compatible'),
    );
  }

  void _showDetailsScreen(BuildContext context, Map<String, dynamic> item) {
    if (pdProvider is HerramientaProvider) {
      final index = (pdProvider as HerramientaProvider).error.indexOf(item);
      Navigator.of(context)
          .pushNamed('/detalle_error_herramienta_screen', arguments: index);
    } else if (pdProvider is LineaProvider) {
      final index = (pdProvider as LineaProvider).error.indexOf(item);
      Navigator.of(context)
          .pushNamed('/detalle_error_linea_screen', arguments: index);
    } else if (pdProvider is PersonalProvider) {
      final index = (pdProvider as PersonalProvider).error.indexOf(item);
      Navigator.of(context)
          .pushNamed('/detalle_error_personal_screen', arguments: index);
    }
  }
}
