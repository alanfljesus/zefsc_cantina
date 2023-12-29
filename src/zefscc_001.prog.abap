*&---------------------------------------------------------------------*
*& Report zefscc_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zefscc_001.

" COLABORADOR

" CANTINA


SELECTION-SCREEN: BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.
  PARAMETERS: cb_clear AS CHECKBOX.
SELECTION-SCREEN: END OF BLOCK b0.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
  PARAMETERS: cb_gener AS CHECKBOX.
SELECTION-SCREEN: END OF BLOCK b1.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.

    METHODS: run,
      clear_tables,
      generate_data,
      generate_collaborator     RETURNING VALUE(rv_collaborator_id)     TYPE zefscel_007,
      generate_canteen          RETURNING VALUE(rv_canteen_id)   TYPE zefscel_007,
      generate_snack            IMPORTING iv_collaborator_id TYPE zefscel_007
                                RETURNING VALUE(rv_snack_id) TYPE zefscel_007,
      generate_snack_value_hour RETURNING VALUE(rv_snack_value_hour_id) TYPE zefscel_007.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD run.
    clear_tables(  ).
    generate_data(  ).
  ENDMETHOD.

  METHOD clear_tables.

    CHECK cb_clear EQ abap_true.

    DELETE FROM zefsct_001.
    DELETE FROM zefsct_002.
    DELETE FROM zefsct_003.
    DELETE FROM zefsct_004.

    COMMIT WORK AND WAIT.
  ENDMETHOD.

  METHOD generate_data.

    CHECK cb_gener EQ abap_true.

    DATA(lv_collaborator_id) = generate_collaborator(  ).
    DATA(lv_canteen_id)      = generate_canteen(  ).
    DATA(lv_snack_id)        = generate_snack( lv_collaborator_id ).
    DATA(lv_snack_value_hour_id) = generate_snack_value_hour(  ).

  ENDMETHOD.

  METHOD generate_collaborator.

    DATA(lo_collaborator) = NEW zefsccl_004( 'ZEFSCT_002' ).

    DATA(ls_collaborator_1) = VALUE zefsct_002( id               = rv_collaborator_id
                                                nome_colaborador = `João`
                                                cpf              = `10948562735`
                                                centro           = 1003
                                                criado_em        = sy-datum ).

    DATA(ls_return_collaborator_1) = lo_collaborator->create( CHANGING cs_data = ls_collaborator_1 ).

    rv_collaborator_id = ls_return_collaborator_1-message_v1.

    MODIFY zefsct_002 FROM ls_collaborator_1.

  ENDMETHOD.

  METHOD generate_canteen.

    DATA(lo_canteen) = NEW zefsccl_002( 'ZEFSCT_001' ).

    DATA(ls_canteen_1) = VALUE zefsct_001( id             = rv_canteen_id
                                           codigo_cantina = `CANTINA_B02`
                                           nome_cantina   = `CANTINA MDA`
                                           centro         = 1003
                                           criado_em      = sy-datum ).

    DATA(ls_return_canteen_1) = lo_canteen->create( CHANGING cs_data = ls_canteen_1 ).

    rv_canteen_id = ls_return_canteen_1-message_v1.

    MODIFY zefsct_001 FROM ls_canteen_1.

  ENDMETHOD.

  METHOD generate_snack.

    DATA(lo_snack) = NEW zefsccl_005( 'ZEFSCT_003' ).

    DATA(ls_snack_1) = VALUE zefsct_003( id             = rv_snack_id
                                         refeicao  = `ALMOÇO`
                                         hora_refeicao  = `12:30`
                                         valor_refeicao = 15
                                         id_colaborador = iv_collaborator_id
                                         centro_custo   = 1003 ).

    DATA(ls_return_snack_1) = lo_snack->create( CHANGING cs_data = ls_snack_1 ).
    rv_snack_id = ls_return_snack_1-message_v1.

    MODIFY zefsct_003 FROM ls_snack_1.

  ENDMETHOD.

  METHOD generate_snack_value_hour.

    DATA(lo_snack_value_hour) = NEW zefsccl_006( 'ZEFSCT_004' ).

    DATA(ls_snack_value_hour_1) = VALUE zefsct_004( id             = rv_snack_value_hour_id
                                                    refeicao       = `ALMOÇO`
                                                    hora_inicio    = `12:30`
                                                    hora_fim       = `13:30`
                                                    codigo_cantina = `CANTINA_B02`
                                                    valor          = 15 ).

    DATA(ls_return_snack_value_hour_1) = lo_snack_value_hour->create( CHANGING cs_data = ls_snack_value_hour_1 ).
    rv_snack_value_hour_id = ls_return_snack_value_hour_1-message_v1.

    MODIFY zefsct_004 FROM ls_snack_value_hour_1.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA(lo_main) = NEW lcl_main(  ).
  lo_main->run(  ).
