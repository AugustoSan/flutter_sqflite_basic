import 'package:flutter/material.dart';
import 'package:flutter_sqflite_basic/models/password_model.dart';
import 'package:flutter_sqflite_basic/providers/password_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordProvider(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contraseñas'),
          centerTitle: true,
        ),
        body: Column(
          children: const [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: _FormInputPassword(),
              elevation: 20,
            ),
            ButtonGetAllAccoun(),
          ],
        ),
      ),
    );
  }
}

class ButtonGetAllAccoun extends StatelessWidget {
  const ButtonGetAllAccoun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passProvider = Provider.of<PasswordProvider>(context);
    return TextButton.icon(
        onPressed: () async {
          final list = await passProvider.getAllAccounts();
          Navigator.pushNamed(context, '/list_accounts', arguments: list);
        },
        icon: const Icon(Icons.list),
        label: const Text('Ver todas las cuentas'));
  }
}

class _FormInputPassword extends StatelessWidget {
  const _FormInputPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passProvider = Provider.of<PasswordProvider>(context, listen: false);
    if (passProvider.onLoad == true) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SizedBox(
        width: double.infinity,
        height: 200,
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Cuenta'), icon: Icon(Icons.person)),
              onChanged: (value) {
                passProvider.passModel.cuenta = value;
              },
              initialValue: passProvider.passModel.cuenta,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: const Text('Contraseña'),
                icon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    passProvider.obscureText(!passProvider.inputObscureText);
                  },
                  icon: Icon(passProvider.inputObscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              obscureText: passProvider.inputObscureText,
              onChanged: (value) {
                passProvider.passModel.password = value;
              },
              initialValue: passProvider.passModel.password,
            ),
            TextButton.icon(
              onPressed: () async {
                if (passProvider.passModel.password.isNotEmpty) {
                  await passProvider.savePassword();
                  passProvider.passModel.cuenta = '';
                  passProvider.passModel.password = '';
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ],
        )),
      );
    }
  }
}
