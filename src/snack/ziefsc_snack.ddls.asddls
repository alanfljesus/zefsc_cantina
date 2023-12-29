@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Refeição'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZIEFSC_SNACK
  as select from zefsct_003 as z003
  composition [1..*] of ZIEFSC_SNACK_H_V as _SnackHV
  association to ZIEFSC_COLLABORATOR as _Colab on $projection.IdColaborador = _Colab.IdColaborador
{
  key z003.refeicao       as Refeicao,
      z003.hora_refeicao  as HoraRefeicao,
      z003.valor_refeicao as ValorRefeicao,
      z003.id_colaborador as IdColaborador,
      _Colab.NomeColaborador as NomeColaborador,
      z003.centro_custo   as CentroCusto,

      _SnackHV
}
