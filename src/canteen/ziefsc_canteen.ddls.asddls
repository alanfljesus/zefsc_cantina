@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Cantina'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZIEFSC_CANTEEN
  as select from zefsct_001
{
  key id             as IdCantina,
  key codigo_cantina as CodigoCantina,
      nome_cantina   as NomeCantina,
      centro         as Centro,
      criado_em      as CriadoEm,
      modificado_em  as ModificadoEm
}
