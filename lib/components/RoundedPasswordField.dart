import 'package:flutter/material.dart';
import 'package:hostels/components/TextFieldContainer.dart';
import 'package:hostels/components/palette.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? passwordhint;
  final TextEditingController? field;
  final Color? fcolor;
  final bool? hideText;
  final VoidCallback? showHide;

  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.passwordhint,
    this.field,
    this.fcolor = Colors.black12,
    this.hideText = true,
    this.showHide,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      fcolor: fcolor!,
      child: TextFormField(
        obscureText: hideText!,
        onChanged: onChanged,
        cursorColor: kappPrimary,
        decoration: InputDecoration(
          hintText: passwordhint,
          hintStyle: const TextStyle(
            color: kappColorDark,
          ),
          icon: const Icon(
            Icons.lock_outlined,
            color: theme,
          ),
          suffixIcon: IconButton(
            onPressed: showHide,
            icon: Icon(
              hideText!
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            color: theme,
          ),
          border: InputBorder.none,
        ),
        controller: field,
      ),
    );
  }
}
