import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
  String pathInputData = '/home/catalunha/myapps/split_csv_newsheet/inputData';
  String pathOutputData =
      '/home/catalunha/myapps/split_csv_newsheet/outputData';
  File fileChildrenByComunity = File('$pathOutputData/inicio.csv');
  var fileSink = fileChildrenByComunity.openWrite(mode: FileMode.append);
  String lineHeader = 'num|letra';
  // 'Nome,NumeroMatricula,FoneCelular,FoneComercial,Atendente,FoneResidencial,Email,Endereco,CEP,Bairro,Cidade,DataCadastro,CPF,RG,Sexo,DataNascimento,ComplementoEndereco,LoginSponteNet,SenhaSponteNet,LoginRespFinanceiro,SenhaRespFinanceiro,Situacao,NomePai,NomeMae,NomeRespFin,FoneResidencialRespFin,FoneCelularRespFin,FoneComercialRespFin,EmailRespFin,TurmaInteresse,EmailPai,EmailMae,CPFRespFinanceiro,FoneRespPai,CelularRespPai,FoneRespMae,CelularRespMae,NomeUnidade,NumeroEndereco,UFEndereco,EnderecoPai,NumeroEnderecoPai,ComplementoEnderecoPai,BairroPai,CidadePai,UFEnderecoPai,CEPPai,EnderecoMae,NumeroEnderecoMae,ComplementoEnderecoMae,BairroMae,CidadeMae,UFEnderecoMae,CEPMae,EnderecoResFinanceiro,NumeroEnderecoRespFinanceiro,ComplementoEnderecoRespFinanceiro,BairroRespFinanceiro,CidadeRespFinanceiro,UFEnderecoRespFinanceiro,CEPRespFinanceiro,ParentescoRespFin,RGMae,CPFMae,FoneComercialMae,DtNascimentoMae,RGPai,CPFPai,FoneComercialPai,DtNascimentoPai,RGRespFin,DtNascimentoRespFin,CPFRespDid,DtNascimentoRespDid,Turma';

  var fileChildrenAll = File('$pathInputData/teste.csv');
  fileChildrenAll
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .forEach((line) {
    List<String> lineList = line.split('|');
    if (fileChildrenByComunity.path.split('/').last != '${lineList[1]}.csv') {
      fechandoArquivo(fileSink);
      print('Criando novo arq csv');
      fileChildrenByComunity = File('$pathOutputData/${lineList[1]}.csv');
      fileSink = fileChildrenByComunity.openWrite(mode: FileMode.append);
      fileSink.writeln(lineHeader);
      fileSink.writeln(lineList.join(','));
    } else {
      fileSink.writeln(lineList.join(','));
    }
    print('line: $line');
  });
}

Future<void> fechandoArquivo(IOSink sink) async {
  await sink.flush();
  await sink.close();
}
