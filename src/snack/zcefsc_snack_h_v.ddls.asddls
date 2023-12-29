@EndUserText.label: 'CDS Consumer - Horário Valor Refeição'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

define view entity ZCEFSC_SNACK_H_V
  as projection on ZIEFSC_SNACK_H_V
{
  key Refeicao,
      HoraInicio,
      HoraFim,
      @Consumption.valueHelpDefinition: [{
      entity: { name: 'ZCEFSC_CANTEEN', element: 'CodigoCantina'}
      }]
      CodigoCantina,
      Valor,
      /* Associations */
      _Snack : redirected to parent ZCEFSC_SNACK 
}
