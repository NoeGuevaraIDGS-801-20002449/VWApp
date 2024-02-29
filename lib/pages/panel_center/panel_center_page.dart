import 'dart:ui';
import 'package:vwapp/pages/charts.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class Person {
  String name;
  Color color;
  Person({required this.name, required this.color});
}

class PanelCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  List<Person> _persons = [
  Person(name: "Carlos García", color: Color(0xfff8b250)),
  Person(name: "María Hernández", color: Color(0xffff5182)),
  Person(name: "Alejandra López", color: Color(0xff0293ee)),
  Person(name: "Juan Rodríguez", color: Color(0xfff8b250)),
  Person(name: "Sofía Ramírez", color: Color(0xff13d38e)),
  Person(name: "Miguel Pérez", color: Color(0xfff8b250)),
  Person(name: "Luisa Morales", color: Color(0xffff5182)),
  Person(name: "Joaquín Sánchez", color: Color(0xff0293ee)),
  Person(name: "Adriana Torres", color: Color(0xffff5182)),
  Person(name: "Fernando Mendoza", color: Color(0xff13d38e)),
];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Constants.kPadding / 2,
                right: Constants.kPadding / 2,
                left: Constants.kPadding / 2),
            child: Card(
              color: Constants.purpleLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                width: double.infinity,
                child: ListTile(
                  //leading: Icon(Icons.sell),
                  title: Text(
                    "Problemas no resueltos",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "10% no se han resuleto",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Chip(
                    label: Text(
                      "56",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BarChartSample2(),
          Padding(
            padding: const EdgeInsets.only(
                top: Constants.kPadding,
                left: Constants.kPadding / 2,
                right: Constants.kPadding / 2,
                bottom: Constants.kPadding),
            child: Card(
              color: Constants.purpleLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: List.generate(
                  _persons.length,
                  (index) => ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      child: Text(
                        _persons[index].name.substring(0, 1),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: _persons[index].color,
                    ),
                    title: Text(
                      _persons[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
