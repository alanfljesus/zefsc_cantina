CLASS zefsccl_002 DEFINITION
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



CLASS zefsccl_002 IMPLEMENTATION.


  METHOD validate.

    DATA(ls_cantina) = CORRESPONDING zefsct_001( cs_data ).

    IF ls_cantina-id IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_cantina-codigo_cantina IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_code
      ).
    ENDIF.

    IF ls_cantina-nome_cantina IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_name
      ).
    ENDIF.

    IF ls_cantina-centro IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_center
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
