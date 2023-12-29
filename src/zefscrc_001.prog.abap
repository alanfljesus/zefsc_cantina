*&---------------------------------------------------------------------*
*& Report zefscrc_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zefscrc_001.

TABLES: zefsct_001,
        zefsct_002,
        zefsct_003,
        zefsct_004.

INCLUDE zefscrc_002.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_cant FOR zefsct_001-id.
SELECTION-SCREEN: END OF BLOCK b1.

CLASS lcl_main DEFINITION INHERITING FROM lcl_alv CREATE PRIVATE.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_alv,
             id_cantina     TYPE zefsct_001-id,
             codigo_cantina TYPE zefsct_001-codigo_cantina,
             nome_cantina   TYPE zefsct_001-nome_cantina,
             colaborador    TYPE zefsct_002-nome_colaborador,
             refeicao       TYPE zefsct_003-tipo_refeicao,
             hora_refeicao  TYPE zefsct_003-hora_refeicao,
             centro_custo   TYPE zefsct_003-centro_custo,
             total          TYPE zefsct_003-valor_refeicao,
           END OF ty_alv.

    DATA: lt_alv TYPE TABLE OF ty_alv.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.
    METHODS get_data     REDEFINITION.
    METHODS set_fieldcat REDEFINITION.

ENDCLASS.
CLASS lcl_main IMPLEMENTATION.

  METHOD create.
    r_result = NEW #(  ).
  ENDMETHOD.

  METHOD run.
    get_data(  ).
    display_report( CHANGING lt_alv = lt_alv ).
  ENDMETHOD.

  METHOD get_data.

    SELECT
         z001~id,
         z001~nome_cantina,
         z001~codigo_cantina,
         z002~nome_colaborador,
         z003~centro_custo,
         z003~tipo_refeicao,
         z003~hora_refeicao,
         z003~valor_refeicao
    FROM zefsct_002 AS z002
        INNER JOIN zefsct_001 AS z001 ON z002~centro = z001~centro
        INNER JOIN zefsct_003 AS z003 ON z002~id = z003~id_colaborador
    INTO TABLE @DATA(lt_canteen)
    WHERE z001~id IN @s_cant
    GROUP BY z001~id, z001~nome_cantina, z001~codigo_cantina, z002~nome_colaborador, z003~centro_custo, z003~tipo_refeicao, z003~valor_refeicao, z003~hora_refeicao.


    LOOP AT lt_canteen REFERENCE INTO DATA(lrf_canteen).


      APPEND VALUE ty_alv(  id_cantina     = lrf_canteen->id
                            codigo_cantina = lrf_canteen->codigo_cantina
                            nome_cantina   = lrf_canteen->nome_cantina
                            refeicao       = lrf_canteen->tipo_refeicao
                            hora_refeicao  = lrf_canteen->hora_refeicao
                            colaborador    = lrf_canteen->nome_colaborador
                            centro_custo   = lrf_canteen->centro_custo
                            total          = lrf_canteen->valor_refeicao ) TO lt_alv.

    ENDLOOP.



  ENDMETHOD.

  METHOD set_fieldcat.

    fieldcat_change(
        _column   = `ID_CANTINA`
        _longtxt  = `ID Cantina`
        _position = 1
    ).

    fieldcat_change(
        _column   = `CODIGO_CANTINA`
        _longtxt  = `Código Cantina`
        _position = 2
    ).

    fieldcat_change(
        _column    = `NOME_CANTINA`
        _longtxt   = `Nome da Cantina`
        _position  = 3
        _outputlen = 20
    ).

    fieldcat_change(
        _column    = `HORA_REFEICAO`
        _longtxt   = `Horário da Refeição`
        _position  = 4
        _outputlen = 10
    ).

    fieldcat_change(
        _column   = `REFEICAO`
        _longtxt  = `Refeição`
        _position = 5
    ).

    fieldcat_change(
        _column   = `COLABORADOR`
        _longtxt  = `Colaborador`
        _position = 6
    ).

    fieldcat_change(
        _column    = `CENTRO_CUSTO`
        _longtxt   = `Centro de Custo`
        _position  = 7
        _outputlen = 6
        _align     = 3
    ).

    fieldcat_change(
        _column    = `TOTAL`
        _longtxt   = `Total`
        _position  = 8
        _outputlen = 6
        _align     = 3
    ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create(  )->run(  ).
