import 'package:flutter/material.dart';

class SearchCityTextField extends StatefulWidget {
  final void Function(bool,String) onPressed;
  const SearchCityTextField({
    super.key, required this.onPressed,
  });

  @override
  State<SearchCityTextField> createState() => _SearchCityTextFieldState();
}

class _SearchCityTextFieldState extends State<SearchCityTextField> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Field cannot be Empty';
                  }

                  return null;
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 50,
            width: 50,
            child: ElevatedButton(
              onPressed: () {
                final isValidated = formKey.currentState?.validate() ?? false;
                widget.onPressed(isValidated,textEditingController.text);
              },
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }
}
