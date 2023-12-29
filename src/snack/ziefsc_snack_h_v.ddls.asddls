@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Horário Valor Refeição'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIEFSC_SNACK_H_V
  as select from zefsct_004 as z004
  association to parent ZIEFSC_SNACK as _Snack on $projection.Refeicao = _Snack.Refeicao
{

  key z004.refeicao       as Refeicao,
      z004.hora_inicio    as HoraInicio,
      z004.hora_fim       as HoraFim,
      z004.codigo_cantina as CodigoCantina,
      z004.valor          as Valor,
      
      _Snack
}
