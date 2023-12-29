*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZEFSCVW_002.....................................*
TABLES: ZEFSCVW_002, *ZEFSCVW_002. "view work areas
CONTROLS: TCTRL_ZEFSCVW_002
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZEFSCVW_002. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZEFSCVW_002.
* Table for entries selected to show on screen
DATA: BEGIN OF ZEFSCVW_002_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZEFSCVW_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEFSCVW_002_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZEFSCVW_002_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZEFSCVW_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEFSCVW_002_TOTAL.

*.........table declarations:.................................*
TABLES: ZEFSCT_003                     .
