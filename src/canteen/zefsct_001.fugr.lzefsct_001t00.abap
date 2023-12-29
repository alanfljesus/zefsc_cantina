*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZEFSCT_001......................................*
DATA:  BEGIN OF STATUS_ZEFSCT_001                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEFSCT_001                    .
CONTROLS: TCTRL_ZEFSCT_001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZEFSCT_001                    .
TABLES: ZEFSCT_001                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
