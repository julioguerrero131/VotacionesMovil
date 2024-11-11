import 'package:flutter/material.dart';
import 'package:votaciones_movil/components/NumericFormField.dart';
import 'package:votaciones_movil/components/DropDownFormField.dart';
import 'package:votaciones_movil/components/TextLabelFormField.dart';
import 'package:votaciones_movil/components/showAlertDialog.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportKey = GlobalKey<FormState>();

  final _numberTotalVotesController = TextEditingController();
  final _numberValidVotesController = TextEditingController();
  final _numberBlankVotesController = TextEditingController();
  final _numberNullVotesController = TextEditingController();

  List<String> items = ['Candidato 1', 'Candidato 2', 'Candidato 3'];

  List<TextEditingController> controllersFirstField = [];
  List<TextEditingController> controllersSecondField = [];

  String? _selectedOption;
  bool _isPresidentChecked = false;
  bool _isSecretaryChecked = false;
  bool _isDelegatedChecked = false;

  int _submitCheckboxAttempt = 0;
  int _submitNumericAttempt = 0;
  int _submitTotalAttempt = 0;

  // Función para enviar el formulario
  void _submitForm() {
    if (_reportKey.currentState!.validate()) {
      // Obtén los valores ingresados en los campos de texto
      int totalVotes = int.tryParse(_numberTotalVotesController.text) ?? 0;
      int validVotes = int.tryParse(_numberValidVotesController.text) ?? 0;
      int blankVotes = int.tryParse(_numberBlankVotesController.text) ?? 0;
      int nullVotes = int.tryParse(_numberNullVotesController.text) ?? 0;

      // Calcula la suma de votos válidos, blancos y nulos
      int sumVotes = validVotes + blankVotes + nullVotes;

      // Calcula la suma de los votos ingresados en los campos de texto
      int candidatesVotes = controllersSecondField.fold(0, (sum, controller) {
        int value = int.tryParse(controller.text) ?? 0;
        return sum + value;
      });

      // Validar que la suma coincida con el total
      if (totalVotes != sumVotes) {
        if (_submitTotalAttempt == 0) {
          showAlertDialog(
            context: context,
            title: 'Error',
            message:
                'La suma de Válidos, Blancos y Nulos no coincide con Totales.',
          );
          _submitTotalAttempt++;
          return; // No enviamos el formulario si no coinciden
        }
      }

      // Validar el rango de la suma de los votos
      if (candidatesVotes < 0 || candidatesVotes != validVotes) {
        if (_submitNumericAttempt == 0) {
          showAlertDialog(
            context: context,
            title: 'Advertencia',
            message:
                'La cantidad de Votos Válidos no coincide con la suma de los Votos de cada Candidatos.',
          );
          _submitNumericAttempt++;
          return; // No enviamos el formulario en el primer intento
        }
      }
    } else {
      showAlertDialog(
        context: context,
        title: 'Error: Formulario No Válido',
        message: 'Por favor, completa todos los campos correctamente.',
      );
      return;
    }

    // Verificar si al menos un checkbox está marcado
    if (!_isPresidentChecked && !_isSecretaryChecked && !_isDelegatedChecked) {
      // Si es el primer intento sin checkbox, mostrar advertencia
      if (_submitCheckboxAttempt == 0) {
        showAlertDialog(
          context: context,
          title: 'Advertencia',
          message: 'Debe marcar al menos un checkbox antes de enviar.',
        );
        _submitCheckboxAttempt++;
        return; // No enviamos el formulario en el primer intento
      }
    }

    showAlertDialog(
      context: context,
      title: 'Correcto',
      message: 'Los datos son correctos. La suma de los votos es válida.',
    );
    // Aquí puedes agregar la lógica de envío de datos
    _submitNumericAttempt = 0;
    _submitCheckboxAttempt = 0;
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos dos controladores para cada elemento en la lista
    controllersFirstField = List.generate(
        items.length, (index) => TextEditingController(text: items[index]));
    controllersSecondField =
        List.generate(items.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // Liberar los controladores usando un bucle for
    for (int i = 0; i < controllersFirstField.length; i++) {
      controllersFirstField[i].dispose();
      controllersSecondField[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _reportKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ingrese la cantidad de votos según corresponda",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Divider(
                color: Color(0xFF18599d), // Cambia el color si lo deseas
                thickness: 1.0, // Ajusta el grosor de la línea
                height: 20.0, // Espacio vertical alrededor del Divider
              ),
              DropdownFormField(
                label: 'Seleccione una junta:',
                items: const ['Junta 1', 'Junta 2', 'Junta 3'],
                value: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: NumericFormField(
                      controller: _numberTotalVotesController,
                      label: 'Totales:',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un número';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumericFormField(
                      controller: _numberValidVotesController,
                      label: 'Válidos:',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un número';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumericFormField(
                      controller: _numberBlankVotesController,
                      label: 'Blancos:',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un número';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumericFormField(
                      controller: _numberNullVotesController,
                      label: 'Nulos:',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un número';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap:
                    true, // Esto le dice al ListView que no ocupe todo el espacio disponible
                physics:
                    const NeverScrollableScrollPhysics(), // Evita que el ListView intente hacer scroll dentro de SingleChildScrollView
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextLabelFormField(
                          controller: controllersFirstField[
                              index], // Cambiado para usar un controlador diferente por cada elemento
                          label: 'Candidato:',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            }
                            return null;
                          },
                          isReadOnly: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: NumericFormField(
                          controller: controllersSecondField[
                              index], // Cambiado para usar un controlador diferente por cada elemento
                          label: 'Votos:',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese un número';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isPresidentChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPresidentChecked = value!;
                      });
                    },
                  ),
                  Text(
                    'Firmó Presidente de la JRV',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isSecretaryChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSecretaryChecked = value!;
                      });
                    },
                  ),
                  Text(
                    'Firmó Secretaría de la JRV',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isDelegatedChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isDelegatedChecked = value!;
                      });
                    },
                  ),
                  Text(
                    'Firmaron TODOS los Delegados de la JRV',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Guardar Datos y Enviar'),
                ),
              )
            ]),
      ),
    );
  }
}