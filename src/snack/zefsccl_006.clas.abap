class ZEFSCCL_006 definition
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



CLASS ZEFSCCL_006 IMPLEMENTATION.


  METHOD validate.
    DATA(ls_hora_valor_refeicao) = CORRESPONDING zefsct_004( cs_data ).

    IF ls_hora_valor_refeicao-refeicao IS INITIAL.
      RAISE EXCEPTION NEW zefsccl_003(
      textid = zefsccl_003=>has_no_snack
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

  ENDMETHOD.
ENDCLASS.
