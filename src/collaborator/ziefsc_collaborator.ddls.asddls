@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Colaborador'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZIEFSC_COLLABORATOR
  as select from zefsct_002 as z002
{
  key    z002.id               as IdColaborador,
  key    z002.cpf              as Cpf,
         z002.nome_colaborador as NomeColaborador,
         z002.centro           as Centro
}
