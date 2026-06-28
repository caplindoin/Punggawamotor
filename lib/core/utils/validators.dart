class Validators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }
    if (!RegExp(r'^(\+62|0)[0-9]{9,12}$').hasMatch(value)) {
      return 'Nomor HP tidak valid';
    }
    return null;
  }

  static String? validatePlateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Plat nomor tidak boleh kosong';
    }
    if (!RegExp(r'^[A-Z]{1,2}\s?\d{1,4}\s?[A-Z]{1,3}$')
        .hasMatch(value.toUpperCase())) {
      return 'Format plat nomor tidak valid';
    }
    return null;
  }

  static String? validateEmptyField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }
}
