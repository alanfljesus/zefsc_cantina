CLASS zefsccl_test_snack_value_hour DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS .

  PUBLIC SECTION.

    DATA go_snack_value_hour TYPE REF TO zefsccl_006.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_snack
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS filled
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS edit
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS delete
      FOR TESTING
      RAISING
        zefsccl_003 .
ENDCLASS.



CLASS zefsccl_test_snack_value_hour IMPLEMENTATION.

  METHOD delete.
    DATA(snack_value_hour) = VALUE zefsct_004(
    refeicao       = `ALMOÇO`
    hora_inicio    = `12:30`
    hora_fim       = `13:30`
    codigo_cantina = `CANTINA_A01`
    valor          = 15
    ).

    DATA(ls_result_create) = me->go_snack_value_hour->create(
                            CHANGING cs_data = snack_value_hour
                          ).

    snack_value_hour-id = ls_result_create-message_v1.
    snack_value_hour-codigo_cantina = `Deletado`.

    DATA(ls_result_delete) = me->go_snack_value_hour->delete( snack_value_hour ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(snack_value_hour) = VALUE zefsct_004(
    refeicao       = `ALMOÇO`
    hora_inicio    = `12:30`
    hora_fim       = `13:30`
    codigo_cantina = `CANTINA_A01`
    valor          = 15
    ).

    DATA(ls_result_create) = me->go_snack_value_hour->create(
                            CHANGING cs_data = snack_value_hour
                          ).

    snack_value_hour-id = ls_result_create-message_v1.
    snack_value_hour-codigo_cantina = `Modificado`.

    DATA(ls_result_update) = me->go_snack_value_hour->update(
                                CHANGING cs_data = snack_value_hour
                             ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  ENDMETHOD.


  METHOD filled.
    DATA(snack_value_hour) = VALUE zefsct_004(
    refeicao       = `ALMOÇO`
    hora_inicio    = `12:30`
    hora_fim       = `13:30`
    codigo_cantina = `CANTINA_A01`
    valor          = 15
    ).

    DATA(ls_result) = me->go_snack_value_hour->create(
                            CHANGING cs_data = snack_value_hour
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.

  METHOD has_no_snack.
    DATA(snack_value_hour) = VALUE zefsct_004(
*   refeicao       = ''
    hora_inicio    = `12:30`
    hora_fim       = `13:30`
    codigo_cantina = `CANTINA_A01`
    valor          = 15
    ).

    DATA(ls_result) = me->go_snack_value_hour->create(
                            CHANGING cs_data = snack_value_hour
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.

  METHOD setup.
    me->go_snack_value_hour = NEW zefsccl_006('ZEFSCT_004').
  ENDMETHOD.


  METHOD teardown.
    FREE: me->go_snack_value_hour.
  ENDMETHOD.
ENDCLASS.
