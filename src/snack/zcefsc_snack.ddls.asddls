@EndUserText.label: 'CDS Consumer - Refeição'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

define root view entity ZCEFSC_SNACK
  as projection on ZIEFSC_SNACK
{
      @Consumption.valueHelpDefinition: [{
      entity: { name: 'ZCEFSC_SNACK', element: 'Refeicao'}
      }]
  key Refeicao,
      HoraRefeicao,
      ValorRefeicao,
      @Consumption.valueHelpDefinition: [{
      entity: { name: 'ZCEFSC_COLLABORATOR', element: 'IdColaborador' },
      additionalBinding: [{ localElement: 'IdColaborador', element: 'IdColaborador' }]
      }]
      @ObjectModel.text.element: ['NomeColaborador']
      @UI.textArrangement: #TEXT_ONLY
      IdColaborador,
      NomeColaborador,
      @Consumption.valueHelpDefinition: [{
      entity: { name: 'ZCEFSC_CANTEEN', element: 'Centro'}
      }]
      CentroCusto,
      /* Associations */
      _SnackHV : redirected to composition child ZCEFSC_SNACK_H_V
}
