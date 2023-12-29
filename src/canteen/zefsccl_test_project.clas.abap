CLASS zefsccl_test_project DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS .

  PUBLIC SECTION.

    DATA go_canteen TYPE REF TO zefsccl_002 .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_name
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS has_no_center
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS has_no_code
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



CLASS zefsccl_test_project IMPLEMENTATION.


  METHOD delete.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = `Codigo Cantina`
    nome_cantina   = `Nome Cantina`
    centro         = `1005`
    ).

    DATA(ls_result_create) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    canteen-id = ls_result_create-message_v1.
    canteen-nome_cantina = `Deletado`.

    DATA(ls_result_delete) = me->go_canteen->delete( canteen ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = `Codigo Cantina`
    nome_cantina   = `Nome Cantina`
    centro         = `1005`
    ).

    DATA(ls_result_create) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    canteen-id = ls_result_create-message_v1.
    canteen-nome_cantina = `Modificado`.

    DATA(ls_result_update) = me->go_canteen->update(
                            CHANGING is_data = canteen
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).

  ENDMETHOD.


  METHOD filled.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = `Codigo Cantina`
    nome_cantina   = `Nome Cantina`
    centro         = `1005`
    ).

    DATA(ls_result) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_center.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = `Codigo Cantina`
    nome_cantina   = `Nome Cantina`
    centro         = ``
    ).

    DATA(ls_result) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_code.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = ``
    nome_cantina   = `Nome Cantina`
    centro         = `1005`

    ).

    DATA(ls_result) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  ENDMETHOD.


  METHOD has_no_name.
    DATA(canteen) = VALUE zefsct_001(
    codigo_cantina = `Codigo Cantina`
    nome_cantina   = ``
    centro         = `1005`

    ).

    DATA(ls_result) = me->go_canteen->create(
                            CHANGING is_data = canteen
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD setup.
    me->go_canteen = NEW zefsccl_002('ZEFSCT_001').
  ENDMETHOD.


  METHOD teardown.
    FREE: me->go_canteen.
  ENDMETHOD.
ENDCLASS.
