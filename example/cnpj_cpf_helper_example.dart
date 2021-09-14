import 'package:cnpj_cpf_helper_nullsafety/cnpj_cpf_helper.dart';

void main() {
  // generate a random cnpj
  var _cnpj = CnpjCpfBase.randomCnpj(withMask: true);
  print('a random CNPJ: $_cnpj');

  // masking a cnpj
  var _fromCnpj = '26954374000130';
  _cnpj = CnpjCpfBase.maskCnpj(_fromCnpj);
  print('masking a CNPJ, from this: $_fromCnpj to this: $_cnpj');
  // it's possible to masking partially
  _fromCnpj = '2695437';
  _cnpj = CnpjCpfBase.maskCnpj(_fromCnpj);
  print('masking partially a CNPJ, from this: $_fromCnpj to this: $_cnpj');

  // unmasking a cnpj
  _fromCnpj = '03.451.682/0001-47';
  _cnpj = CnpjCpfBase.onlyNumbers(_fromCnpj);
  print('unmasking  a CNPJ, from this: $_fromCnpj to this: $_cnpj');

  // validate a cnpj
  // there are two kinds of validation
  // the first one (the simplest one) just returns a bool value
  if (CnpjCpfBase.isCnpjValid(_cnpj)) {
    print('$_cnpj is a valid CNPJ');
  }

  // the second one returns a enum that describe the status
  _cnpj = '48.608.581/0005-00'; // invalid digit
  var _status = CnpjCpfBase.cnpjValidate(_cnpj);
  switch (_status) {
    case EDocumentStatus.DIGIT:
      print('CNPJ\'s digit is wrong!');
      break;
    case EDocumentStatus.FORMAT:
      print('CNPJ\'s format is wrong!');
      break;
    case EDocumentStatus.EMPTY:
      print('CNPJ is empty!');
      break;
    default:
      print('$_cnpj is a valid CNPJ');
  }

  // generate a random cpf
  var _cpf = CnpjCpfBase.randomCpf(withMask: true);
  print('a random CPF: $_cnpj');

  // masking a cpf
  var _fromCpf = '89638567040';
  _cpf = CnpjCpfBase.maskCpf(_fromCpf);
  print('masking a CPF, from this: $_fromCpf to this: $_cpf');
  // it's possible to masking partially
  _fromCpf = '89638567';
  _cpf = CnpjCpfBase.maskCpf(_fromCpf);
  print('masking partially a CPF, from this: $_fromCpf to this: $_cpf');

  // unmasking a cpf
  _fromCpf = '510.867.680-86';
  _cpf = CnpjCpfBase.onlyNumbers(_fromCpf);
  print('unmasking a CPF, from this: $_fromCpf to this: $_cpf');

  // validate a cnpj
  // there are two kinds of validation
  // the first one (the simplest one) just returns a bool value
  if (CnpjCpfBase.isCpfValid(_cpf)) {
    print('$_cpf is a valid CPF');
  }

  // the second one returns a enum that describe the status
  _cpf = '';
  _status = CnpjCpfBase.cpfValidate(_cpf);
  switch (_status) {
    case EDocumentStatus.DIGIT:
      print('CPF\'s digit is wrong!');
      break;
    case EDocumentStatus.FORMAT:
      print('CPF\'s format is wrong!');
      break;
    case EDocumentStatus.EMPTY:
      print('CPF is empty!');
      break;
    default:
      print('$_cpf is a valid CPF');
  }
}
