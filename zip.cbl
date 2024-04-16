IDENTIFICATION DIVISION.
PROGRAM-ID. ZIPANDMOVE.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
   SPECIAL-NAMES.
       CALL-CONVENTION IS STDCALL.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 FOLDER-PATH PIC X(100) VALUE "/path/to/source/folder".
01 ZIP-FILE PIC X(100) VALUE "/path/to/destination/folder/archive.zip".
01 COMMAND PIC X(200).

PROCEDURE DIVISION.
    MOVE FUNCTION TRIM(FOLDER-PATH) TO COMMAND
    STRING "zip -r " ZIP-FILE " " FOLDER-PATH "/*" INTO COMMAND
    CALL "system" USING COMMAND.

    IF RETURN-CODE = 0
        DISPLAY "ZIP creation successful."
        MOVE FUNCTION TRIM(ZIP-FILE) TO COMMAND
        STRING "mv " ZIP-FILE " /path/to/new/location/" INTO COMMAND
        CALL "system" USING COMMAND
        IF RETURN-CODE = 0
            DISPLAY "Move successful."
        ELSE
            DISPLAY "Move failed."
        END-IF
    ELSE
        DISPLAY "ZIP creation failed."
    END-IF.

    STOP RUN.
