import 'package:test/test.dart';
import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';

void main() {
  group('CNPJ tests', () {
    test('CNPJ valid with mask', () {
      expect(CnpjCpfBase.isCnpjValid('07.170.188/0001-65'), isTrue);
    });
    test('CNPJ valid without mask', () {
      expect(CnpjCpfBase.isCnpjValid('07170188000165'), isTrue);
    });

    test('CNPJ invalid with mask', () {
      expect(CnpjCpfBase.isCnpjValid('07.170.188/0001-00'), isFalse);
    });
    test('CNPJ invalid without mask', () {
      expect(CnpjCpfBase.isCnpjValid('07170188000100'), isFalse);
    });
  });

  group('CPF tests', () {
    test('CPF valid with mask', () {
      expect(CnpjCpfBase.isCpfValid('335.742.720-65'), isTrue);
    });
    test('CPF valid without mask', () {
      expect(CnpjCpfBase.isCpfValid('33574272065'), isTrue);
    });

    test('CPF invalid with mask', () {
      expect(CnpjCpfBase.isCpfValid('335.742.720-00'), isFalse);
    });
    test('CPF invalid without mask', () {
      expect(CnpjCpfBase.isCpfValid('33574272000'), isFalse);
    });
  });
}
