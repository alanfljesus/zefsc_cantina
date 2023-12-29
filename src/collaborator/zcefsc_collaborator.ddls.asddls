@EndUserText.label: 'CDS Consumer - Colaborador'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity ZCEFSC_COLLABORATOR
  as projection on ZIEFSC_COLLABORATOR
{
  key    IdColaborador,
  key    Cpf,
         NomeColaborador,
         @Consumption.valueHelpDefinition: [{
           entity: { name: 'ZIEFSC_CANTEEN', element: 'Centro' } }]
         Centro
}
