CLASS zefsccl_004 DEFINITION
  PUBLIC
  INHERITING FROM zefsccl_001
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS validate
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zefsccl_004 IMPLEMENTATION.


  METHOD validate.
    DATA(ls_colaborador) = CORRESPONDING zefsct_002( cs_data ).

    IF ls_colaborador-id IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_colaborador-cpf IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
        textid = zefsccl_003=>has_no_cpf
      ).
    ENDIF.

    IF ls_colaborador-nome_colaborador IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_name
      ).
    ENDIF.


    IF ls_colaborador-centro IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_center
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
