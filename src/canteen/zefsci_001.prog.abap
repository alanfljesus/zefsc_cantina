*&---------------------------------------------------------------------*
*& Modulpool ZEFSCI_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zefsci_001.

DATA: custom_container TYPE REF TO cl_gui_custom_container,
      grid_alv         TYPE REF TO cl_gui_alv_grid.

INCLUDE zefsci_001_ct.

CLASS lcl_business DEFINITION.

  PUBLIC SECTION.

    DATA lo_business_ct TYPE REF TO lcl_business_ct.

    DATA: lv_screen  TYPE string.

    METHODS:
      constructor IMPORTING VALUE(iv_screen) TYPE string,
      run,
      run_canteen,
      refresh,
      active_change_handle,
      handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

DATA: go_custom_control TYPE REF TO cl_gui_custom_container,
      go_grid           TYPE REF TO cl_gui_alv_grid,
      gt_fieldcat       TYPE lvc_t_fcat,
      gs_layout         TYPE lvc_s_layo.

CLASS lcl_business IMPLEMENTATION.

  METHOD constructor.
    lv_screen = iv_screen.
    lo_business_ct = NEW lcl_business_ct(  ).
  ENDMETHOD.

  METHOD run.
    CALL METHOD (lv_screen).
  ENDMETHOD.

  METHOD run_canteen.
    CHECK go_custom_control IS INITIAL.

    go_custom_control = NEW cl_gui_custom_container( 'CC_CANTEEN' ).

    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZEFSCT_001'
      CHANGING
        ct_fieldcat      = gt_fieldcat.


    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
      CASE <fs_fieldcat>-fieldname.
        WHEN 'ID'.
        WHEN 'CODIGO_CANTINA'.
          <fs_fieldcat>-edit = 'X'.
        WHEN 'NOME_CANTINA'.
          <fs_fieldcat>-edit = 'X'.
          <fs_fieldcat>-outputlen = 25.
        WHEN 'CENTRO'.
          <fs_fieldcat>-just      = 'C'.
          <fs_fieldcat>-outputlen = 5.
          <fs_fieldcat>-edit = 'X'.
        WHEN 'CRIADO_EM'.
          <fs_fieldcat>-reptext   = 'Criado Em'.
          <fs_fieldcat>-scrtext_s = 'Criado Em'.
          <fs_fieldcat>-scrtext_m = 'Criado Em'.
          <fs_fieldcat>-scrtext_l = 'Criado Em'.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-reptext   = 'Mod. Em'.
          <fs_fieldcat>-scrtext_s = 'Mod. Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
        WHEN OTHERS .
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.
    ENDLOOP.

    go_grid->set_table_for_first_display(
        EXPORTING
            i_structure_name = 'ZEFSCT_001'
            is_layout        = gs_layout
        CHANGING
            it_fieldcatalog  = gt_fieldcat
            it_outtab        = lo_business_ct->lt_canteen
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh(  ).
  ENDMETHOD.

  METHOD refresh.
    go_grid->refresh_table_display(  ).
    cl_gui_cfw=>flush(  ).
  ENDMETHOD.

  METHOD active_change_handle.
    go_grid->check_changed_data(  ).
  ENDMETHOD.

  METHOD handle_data_changed.

    ASSIGN er_data_changed->mp_mod_rows->* TO FIELD-SYMBOL(<modified_rows>).
    ASSIGN er_data_changed->mt_deleted_rows TO FIELD-SYMBOL(<deleted_rows>).

    CASE lv_screen.
      WHEN 'RUN_CANTEEN'.
        lo_business_ct->set_canteen( <modified_rows> ).
        lo_business_ct->delete_canteen( <deleted_rows> ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.


*&---------------------------------------------------------------------*
*& Module SET_STATUS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA lo_business TYPE REF TO lcl_business.

MODULE set_status OUTPUT.

  IF lo_business IS INITIAL.
    lo_business = NEW lcl_business(
       COND #(
           WHEN sy-dynnr = `2001` THEN `RUN_CANTEEN`
       )
     ).
  ENDIF.
  lo_business->run(  ).

  SET PF-STATUS 'STANDARD'.
  SET TITLEBAR sy-dynnr.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command INPUT.

  CASE sy-ucomm.
    WHEN '&F03' OR '&F15' OR '&F12'.
      LEAVE PROGRAM.
    WHEN 'BTN_CANTEEN'.
      lo_business->lo_business_ct->get_canteen(  ).
      lo_business->refresh(  ).
    WHEN 'BTN_CANTEEN_SAVE'.
      lo_business->active_change_handle(  ).
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
