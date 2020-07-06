import 'dart:math';

import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';

abstract class CnpjCpfBase {
  static final _specialChar = '#';

  static String onlyNumbers(String value) {
    return value?.replaceAll(RegExp('[^0-9]'), '')?.trim() ?? '';
  }

  static bool isCnpjValid(String value) {
    return cnpjValidate(value) == EDocumentStatus.OK;
  }

  static bool isCpfValid(String value) {
    return cpfValidate(value) == EDocumentStatus.OK;
  }

  static EDocumentStatus cnpjValidate(String value) {
    var _workingValue = onlyNumbers(value);
    if (_workingValue.isEmpty) return EDocumentStatus.EMPTY;
    if (_workingValue.length != 14) return EDocumentStatus.FORMAT;
    var _numbers = _workingValue
        .split('')
        .map<int>((e) => int.parse(e))
        .take(12)
        .toList()
        .reversed
        .toList();
    var _digit1 = _getDigitModule11(_numbers, 2, 9);
    _numbers.insert(0, _digit1);
    var _digit2 = _getDigitModule11(_numbers, 2, 9);
    _numbers.insert(0, _digit2);
    if (_numbers.reversed.join('') != _workingValue) {
      return EDocumentStatus.DIGIT;
    }
    return EDocumentStatus.OK;
  }

  static EDocumentStatus cpfValidate(String value) {
    var _workingValue = onlyNumbers(value);
    if (_workingValue.isEmpty) return EDocumentStatus.EMPTY;
    if (_workingValue.length != 11) return EDocumentStatus.FORMAT;
    var _numbers =
        _workingValue.split('').map<int>((e) => int.parse(e)).take(9).toList();
    var _digit1 = _getDigitModule11(_numbers, 10, 2);
    _numbers.add(_digit1);
    var _digit2 = _getDigitModule11(_numbers, 11, 2);
    _numbers.add(_digit2);
    if (_numbers.join('') != _workingValue) {
      return EDocumentStatus.DIGIT;
    }
    return EDocumentStatus.OK;
  }

  static int _getDigitModule11(
      List<int> numbers, int iniFactor, int endFactor) {
    var _factor = iniFactor;
    var _sum = 0;
    for (var _number in numbers) {
      _sum += _number * _factor;
      if (_factor == endFactor) {
        _factor = iniFactor;
      } else {
        if (iniFactor > endFactor) {
          _factor--;
        } else {
          _factor++;
        }
      }
    }
    var _module = _sum % 11;
    var _digit = 11 - _module;
    return _digit < 10 ? _digit : 0;
  }

  static String randomCnpj({bool withMask = false}) {
    var _numbers = <int>[];
    _numbers.add(Random.secure().nextInt(8) + 1);
    _numbers.add(0);
    _numbers.add(0);
    _numbers.add(0);
    for (var i = 0; i < 8; i++) {
      _numbers.add(Random.secure().nextInt(9));
    }
    _numbers.insert(0, _getDigitModule11(_numbers, 2, 9));
    _numbers.insert(0, _getDigitModule11(_numbers, 2, 9));
    var _cnpj = _numbers.reversed.join();
    if (withMask) {
      return maskCnpj(_cnpj);
    }
    return _cnpj;
  }

  static String randomCpf({bool withMask = false}) {
    var _numbers = <int>[];
    for (var i = 0; i < 9; i++) {
      _numbers.add(Random.secure().nextInt(9));
    }
    _numbers.add(_getDigitModule11(_numbers, 10, 2));
    _numbers.add(_getDigitModule11(_numbers, 11, 2));
    var _cpf = _numbers.join();
    if (withMask) {
      return maskCpf(_cpf);
    }
    return _cpf;
  }

  static String maskCnpj(String value) {
    var _workingValue =
        onlyNumbers(value).padRight(14, _specialChar).substring(0, 14);
    _workingValue = '${_workingValue.substring(0, 2)}.'
        '${_workingValue.substring(2, 5)}.'
        '${_workingValue.substring(5, 8)}/'
        '${_workingValue.substring(8, 12)}-'
        '${_workingValue.substring(12, 14)}';
    return _removeSpecialChar(_workingValue);
  }

  static String maskCpf(String value) {
    var _workingValue =
        onlyNumbers(value).padRight(11, _specialChar).substring(0, 11);
    _workingValue = '${_workingValue.substring(0, 3)}.'
        '${_workingValue.substring(3, 6)}.'
        '${_workingValue.substring(6, 9)}/'
        '${_workingValue.substring(9, 10)}';
    return _removeSpecialChar(_workingValue);
  }

  static String _removeSpecialChar(String value) {
    var _workingValue = value;
    if (_workingValue.contains(_specialChar)) {
      _workingValue =
          _workingValue.substring(0, _workingValue.indexOf(_specialChar));
    }
    return _workingValue;
  }
}
