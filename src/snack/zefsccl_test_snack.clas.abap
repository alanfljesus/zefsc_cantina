CLASS zefsccl_test_snack DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.

    DATA go_snack TYPE REF TO zefsccl_005.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_snack_type
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS has_no_snack_hour
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS has_no_center
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



CLASS zefsccl_test_snack IMPLEMENTATION.

  METHOD delete.
    DATA(snack) = VALUE zefsct_003(
    tipo_refeicao  = `ALMOÇO`
    hora_refeicao  =  sy-timlo
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = '1005'
    ).

    DATA(ls_result_create) = me->go_snack->create(
                                CHANGING is_data = snack
                             ).

    snack-id = ls_result_create-message_v1.
    snack-tipo_refeicao = `Deletado`.

    DATA(ls_result_delete) = me->go_snack->delete( snack ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(snack) = VALUE zefsct_003(
    tipo_refeicao  = `ALMOÇO`
    hora_refeicao  =  sy-timlo
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = '1005'
    ).

    DATA(ls_result_create) = me->go_snack->create(
                                CHANGING is_data = snack
                             ).

    snack-id = ls_result_create-message_v1.
    snack-tipo_refeicao = `Modificado`.

    DATA(ls_result_update) = me->go_snack->update(
                                CHANGING is_data = snack
                             ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  ENDMETHOD.


  METHOD filled.
    DATA(snack) = VALUE zefsct_003(
    tipo_refeicao  = `ALMOÇO`
    hora_refeicao  =  sy-timlo
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = '1005'
    ).

    DATA(ls_result) = me->go_snack->create(
                            CHANGING is_data = snack
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.

  METHOD has_no_center.
    DATA(snack) = VALUE zefsct_003(
    tipo_refeicao  = `ALMOÇO`
    hora_refeicao  =  sy-timlo
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = ''
    ).

    DATA(ls_result) = me->go_snack->create(
                            CHANGING is_data = snack
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.

  METHOD has_no_snack_hour.
    DATA(snack) = VALUE zefsct_003(
    tipo_refeicao  = `ALMOÇO`
*   hora_refeicao  =  ''
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = '1005'
    ).

    DATA(ls_result) = me->go_snack->create(
                            CHANGING is_data = snack
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.

  METHOD has_no_snack_type.
    DATA(snack) = VALUE zefsct_003(
*   tipo_refeicao  = ''
    hora_refeicao  =  sy-timlo
    valor_refeicao =  15
    id_colaborador = 'Id Colaborador'
    centro_custo   = '1005'
    ).

    DATA(ls_result) = me->go_snack->create(
                            CHANGING is_data = snack
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.

  METHOD setup.
    me->go_snack = NEW zefsccl_005('ZEFSCT_003').
  ENDMETHOD.

  METHOD teardown.
    FREE: me->go_snack.
  ENDMETHOD.
ENDCLASS.
