CLASS zefsccl_001 DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA lv_table TYPE string .

    METHODS constructor
      IMPORTING
        !iv_table TYPE any .
    METHODS read
      EXPORTING
        !et_data TYPE ANY TABLE .
    METHODS create
      CHANGING
        !cs_data         TYPE any
      RETURNING
        VALUE(rs_result) TYPE bapiret2
      RAISING
        zefsccl_003 .
    METHODS update
      CHANGING
        !cs_data         TYPE any
      RETURNING
        VALUE(rs_result) TYPE bapiret2
      RAISING
        zefsccl_003 .
    METHODS delete
      IMPORTING
        !cs_data         TYPE any
      RETURNING
        VALUE(rs_result) TYPE bapiret2
      RAISING
        zefsccl_003 .
    METHODS validate
      IMPORTING
        !cs_data      TYPE any
        !iv_is_delete TYPE xfeld OPTIONAL
      RAISING
        zefsccl_003 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zefsccl_001 IMPLEMENTATION.


  METHOD constructor.

    me->lv_table = iv_table.

  ENDMETHOD.


  METHOD create.
    GET TIME STAMP FIELD DATA(lv_timestamp).

    ASSIGN COMPONENT 'CRIADO_EM' OF STRUCTURE cs_data TO FIELD-SYMBOL(<fs_criado_em>).
    ASSIGN COMPONENT 'ID' OF STRUCTURE cs_data TO FIELD-SYMBOL(<fs_id>).

    IF <fs_criado_em> IS ASSIGNED.
      <fs_criado_em> = lv_timestamp.
    ENDIF.

    IF <fs_id> IS ASSIGNED.
      <fs_id> = cl_system_uuid=>create_uuid_x16_static(  ).
    ENDIF.

    TRY .
        me->validate( cs_data ).
      CATCH zefsccl_003 INTO DATA(lx_exc).
        DATA(lv_msg) = lx_exc->get_text(  ).

        rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
        ).
        RETURN.
    ENDTRY.

*   CRIAR REGISTRO
    MODIFY (lv_table) FROM cs_data.
*    COMMIT WORK AND WAIT.

    rs_result = VALUE bapiret2(
    type    = 'S'
    message = `Criado com sucesso`
    message_v1 = <fs_id>
    ).
  ENDMETHOD.


  METHOD delete.
    ASSIGN COMPONENT 'ID' OF STRUCTURE cs_data TO FIELD-SYMBOL(<fs_delete_id>).

    TRY .
        me->validate( EXPORTING cs_data = cs_data iv_is_delete = abap_true ).
      CATCH zefsccl_003 INTO DATA(lx_exc).
        DATA(lv_msg) = lx_exc->get_text(  ).

        rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
        ).
        RETURN.
    ENDTRY.

    DELETE (me->lv_table) FROM cs_data.

    rs_result = VALUE bapiret2(
    type = 'S'
    message = `Deletado com sucesso`
    message_v1 = <fs_delete_id>
    ).
  ENDMETHOD.


  METHOD read.

    SELECT * FROM
      (lv_table)
      INTO TABLE et_data.

  ENDMETHOD.


  METHOD update.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    ASSIGN COMPONENT 'MODIFICADO_EM' OF STRUCTURE cs_data TO FIELD-SYMBOL(<fs_modificado_em>).

    IF <fs_modificado_em> IS ASSIGNED.
      <fs_modificado_em> = lv_timestamp.
    ENDIF.

    ASSIGN COMPONENT 'ID' OF STRUCTURE cs_data TO FIELD-SYMBOL(<fs_modificado_id>).

    TRY .
        me->validate( cs_data ).
      CATCH zefsccl_003 INTO DATA(lx_exc).
        DATA(lv_msg) = lx_exc->get_text(  ).

        rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
        ).
        RETURN.
    ENDTRY.

*   CRIAR REGISTRO
    MODIFY (lv_table) FROM cs_data.

    rs_result = VALUE bapiret2(
    type    = 'S'
    message = `Modificado com sucesso`
    message_v1 = <fs_modificado_id>
    ).

  ENDMETHOD.


  METHOD validate.

  ENDMETHOD.
ENDCLASS.
