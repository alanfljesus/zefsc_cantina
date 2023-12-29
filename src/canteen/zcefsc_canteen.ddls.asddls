@EndUserText.label: 'CDS Consumer - Cantina'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

define root view entity ZCEFSC_CANTEEN
  as projection on ZIEFSC_CANTEEN
{
  key IdCantina,
  key CodigoCantina,
      NomeCantina,
      Centro,
      CriadoEm,
      ModificadoEm
}
