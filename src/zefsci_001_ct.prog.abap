*&---------------------------------------------------------------------*
*& Include zefsci_001_ct
*&---------------------------------------------------------------------*

CLASS lcl_business_ct DEFINITION.
  PUBLIC SECTION.

    DATA:
      lt_canteen          TYPE TABLE OF zefsct_001,
      lo_canteen_business TYPE REF TO zefsccl_002.

    METHODS:
      constructor,
      get_canteen,
      set_canteen IMPORTING VALUE(it_canteen) TYPE any,
      delete_canteen IMPORTING VALUE(it_delete_rows) TYPE lvc_t_moce.

ENDCLASS.

CLASS lcl_business_ct IMPLEMENTATION.

  METHOD constructor.

    lo_canteen_business = NEW zefsccl_002( iv_table = 'ZEFSCT_001').

  ENDMETHOD.

  METHOD get_canteen.
*    SELECT *
*    FROM zefsct_001
*    INTO TABLE lt_canteen.

    lo_canteen_business->read( IMPORTING et_data = lt_canteen ).
  ENDMETHOD.

  METHOD set_canteen.

    CHECK it_canteen IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_timestamp).

*    DATA ls_return TYPE bapiret2.

    DATA(lt_canteen) = CORRESPONDING zefsctt_001( it_canteen ).

    LOOP AT lt_canteen INTO DATA(ls_canteen).

      IF ls_canteen-id EQ space.
        DATA(ls_return_create) = lo_canteen_business->create( CHANGING cs_data = ls_canteen ).
      ELSE.
        DATA(ls_return_update) = lo_canteen_business->update( CHANGING cs_data = ls_canteen ).
      ENDIF.

      MESSAGE ls_return_create-message TYPE ls_return_create-type.
*      ls_canteen-criado_em = lv_timestamp.
*      ls_canteen-modificado_em = lv_timestamp.
*
*      MODIFY zefsct_001 FROM ls_canteen.
    ENDLOOP.

    COMMIT WORK.

    MESSAGE 'Registros processados com sucesso!' TYPE 'S'.
  ENDMETHOD.

  METHOD delete_canteen.

    CHECK it_delete_rows[] IS NOT INITIAL.

    LOOP AT it_delete_rows INTO DATA(ls_deleted_rows).
      DATA(ls_canteen) = lt_canteen[ ls_deleted_rows-row_id ].

*      DELETE FROM zefsct_001 WHERE codigo_cantina = ls_canteen-codigo_cantina.
      DATA(ls_return_delete) = lo_canteen_business->delete( EXPORTING cs_data = ls_canteen ).
      CLEAR ls_canteen.
    ENDLOOP.

    COMMIT WORK.

    MESSAGE 'Registros deletados com sucesso!' TYPE 'S'.
  ENDMETHOD.

ENDCLASS.
