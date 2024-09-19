import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Headers/headerAdmin.dart';
import 'package:unity_fund/Widgets/Widgets/date_filter_dropdown.dart';
import 'package:unity_fund/Widgets/Widgets/search_bar.dart';
import 'package:unity_fund/data/donation_data.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class MonitoreoDonacion extends StatefulWidget {
  User usuario;
  MonitoreoDonacion(this.usuario, {super.key});

  @override
  State<MonitoreoDonacion> createState() => _MonitoreoDonacionState();
}

class _MonitoreoDonacionState extends State<MonitoreoDonacion> {
  final searchController = TextEditingController();
  List<DonationData> tableData = [];
  List<DonationData> filteredData = [];
  String selectedDateRange =
      'Últimos 6 meses'; // Valor por defecto para el dropdown

  @override
  void initState() {
    super.initState();
    fetchTableData(); // Llama a fetchTableData cuando el widget se inicializa
  }

  void fetchTableData() async {
    try {
      // Llama a la función fetchDonations para obtener los datos
      final donations = await fetchDonations();

      // Actualiza el estado con los datos obtenidos
      setState(() {
        tableData = donations; // Ahora es una lista de DonationData
        filteredData = tableData; // Inicialmente, los datos no están filtrados
      });
    } catch (e) {
      print('Error al obtener donaciones: $e');
    }
  }

  void filterTableData(String searchQuery) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (selectedDateRange) {
      case 'Últimos 3 meses':
        startDate = now.subtract(Duration(days: 90));
        break;
      case 'Últimos 6 meses':
        startDate = now.subtract(Duration(days: 180));
        break;
      case 'Últimos 12 meses':
        startDate = now.subtract(Duration(days: 360));
        break;
      case 'Últimos 24 meses':
        startDate = now.subtract(Duration(days: 720));
        break;
      default:
        startDate = DateTime(2000);
    }

    setState(() {
      filteredData = tableData.where((row) {
        // Asegurarse de que la fecha tenga el formato correcto
        List<String> dateParts = row.date.split('-');
        String formattedDate =
            '${dateParts[0]}-${dateParts[1].padLeft(2, '0')}-${dateParts[2].padLeft(2, '0')}';

        DateTime rowDate = DateTime.parse(formattedDate);

        return rowDate.isAfter(startDate) &&
            row.project.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double containerWidth = screenWidth * 0.7;
    final double tableWidth = screenWidth * 0.7;

    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        children: [
          Headeradmin(widget.usuario, 2), // Header de la página
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Monitoreo de Donaciones',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSearchBar(
                            width: screenWidth * 0.4,
                            searchController: searchController,
                            onSearch: (searchQuery) {
                              filterTableData(searchQuery);
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          DateFilterDropdown(
                            width: screenWidth * 0.2,
                            options: [
                              'Últimos 3 meses',
                              'Últimos 6 meses',
                              'Últimos 12 meses',
                              'Últimos 24 meses'
                            ],
                            selectedOption: selectedDateRange,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDateRange =
                                    newValue ?? 'Últimos 6 meses';
                                filterTableData(searchController.text);
                              });
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Container(
                            width: tableWidth,
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'Fecha',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Hora',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Cantidad',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Proyecto',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Usuario',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                              ],
                              rows: filteredData.map((row) {
                                print(row.project);
                                return DataRow(
                                  cells: [
                                    DataCell(Text(
                                      row.date,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                      ),
                                    )),
                                    DataCell(Text(
                                      row.time,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                      ),
                                    )),
                                    DataCell(Text(
                                      row.amount,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                      ),
                                    )),
                                    DataCell(Text(
                                      row.project,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                      ),
                                    )),
                                    DataCell(Text(
                                      row.username,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                      ),
                                    )),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
