CLASS zefsccl_test_collaborator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS .

  PUBLIC SECTION.

    DATA go_collaborator TYPE REF TO zefsccl_004 .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_cpf
      FOR TESTING
      RAISING
        zefsccl_003 .
    METHODS has_no_name
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



CLASS zefsccl_test_collaborator IMPLEMENTATION.


  METHOD delete.
    DATA(collaborator) = VALUE zefsct_002(
      id = ''
      cpf = `12345678910`
      nome_colaborador = `Nome Colaborador`
      centro = `1005`
    ).

    DATA(ls_result_create) = me->go_collaborator->create(
                                CHANGING is_data = collaborator
                             ).

    collaborator-id = ls_result_create-message_v1.
    collaborator-nome_colaborador = `Deletado`.

    DATA(ls_result_delete) = me->go_collaborator->delete( collaborator ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(collaborator) = VALUE zefsct_002(
      id = ''
      cpf = `12345678910`
      nome_colaborador = `Nome Colaborador`
      centro = `1005`
    ).

    DATA(ls_result_create) = me->go_collaborator->create(
                                CHANGING is_data = collaborator
                             ).

    collaborator-id = ls_result_create-message_v1.
    collaborator-nome_colaborador = `Modificado`.

    DATA(ls_result_update) = me->go_collaborator->update(
                                CHANGING is_data = collaborator
                             ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  ENDMETHOD.


  METHOD filled.
    DATA(collaborator) = VALUE zefsct_002(
      id = ''
      cpf = `12345678910`
      nome_colaborador = `Nome Colaborador`
      centro = `1005`
      ).

    DATA(ls_result) = me->go_collaborator->create(
                            CHANGING is_data = collaborator
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_center.
    DATA(collaborator) = VALUE zefsct_002(
    id = ''
    cpf = `12345678910`
    nome_colaborador = `Nome Colaborador`
    centro = ''
    ).

    DATA(ls_result) = me->go_collaborator->create(
                            CHANGING is_data = collaborator
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_cpf.
    DATA(collaborator) = VALUE zefsct_002(
    id = ''
    cpf = ''
    nome_colaborador = `Nome Colaborador`
    centro = `1005`
    ).

    DATA(ls_result) = me->go_collaborator->create(
                            CHANGING is_data = collaborator
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_name.
    DATA(collaborator) = VALUE zefsct_002(
    id = ''
    cpf = `12345678910`
    nome_colaborador = ''
    centro = `1005`
    ).

    DATA(ls_result) = me->go_collaborator->create(
                            CHANGING is_data = collaborator
                          ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.

  METHOD setup.
    me->go_collaborator = NEW zefsccl_004('ZEFSCT_002').
  ENDMETHOD.


  METHOD teardown.
    FREE: me->go_collaborator.
  ENDMETHOD.
ENDCLASS.
