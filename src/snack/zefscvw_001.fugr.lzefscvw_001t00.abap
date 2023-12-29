*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZEFSCVW_001.....................................*
TABLES: ZEFSCVW_001, *ZEFSCVW_001. "view work areas
CONTROLS: TCTRL_ZEFSCVW_001
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZEFSCVW_001. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZEFSCVW_001.
* Table for entries selected to show on screen
DATA: BEGIN OF ZEFSCVW_001_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZEFSCVW_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEFSCVW_001_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZEFSCVW_001_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZEFSCVW_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEFSCVW_001_TOTAL.

*.........table declarations:.................................*
TABLES: ZEFSCT_004                     .
