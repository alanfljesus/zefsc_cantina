class ZEFSCCL_005 definition
  public
  inheriting from ZEFSCCL_001
  final
  create public .

public section.

  methods VALIDATE
    redefinition .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZEFSCCL_005 IMPLEMENTATION.


  METHOD validate.
    DATA(ls_refeicao) = CORRESPONDING zefsct_003( cs_data ).

    IF ls_refeicao-refeicao IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_snack_type
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_refeicao-hora_refeicao IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
        textid = zefsccl_003=>has_no_snack_hour
      ).
    ENDIF.

    IF ls_refeicao-centro_custo IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_center
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
