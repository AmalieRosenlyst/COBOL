      * Formål: Generér kontoudskrift for en kunde.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReadFile.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INPUT-BANKS ASSIGN TO "banks.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT INPUT-TRANSACTIONS ASSIGN TO "transactions.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT OUTPUT-ACCOUNT-STATEMENTS 
       ASSIGN TO "account-statements.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD INPUT-BANKS.
       01 BANK-RECORD.
           COPY "banks.cpy".
       FD INPUT-TRANSACTIONS.
       01 TRANSACTION-RECORD.
           COPY "transactions.cpy".
       
       FD OUTPUT-ACCOUNT-STATEMENTS.
       01 ACCOUNT-STATEMENT-INFO.
           02 INFO                     PIC X(250).

       WORKING-STORAGE SECTION.
      * Variable used as condition in while loop
       01 EOF-TRANSACTIONS              PIC X VALUE "N".
       01 EOF-BANKS                     PIC X VALUE "N".
       01 BANK-ARRAY                    OCCURS 10 TIMES 
                                        INDEXED BY idx-bank.
           COPY "banks.cpy".

      * Variables trimming strings
       01 clean-text                    PIC X(200).
       01 raw-text                      PIC X(200).
       01 out-ptr                       PIC 9(4).
       01 in-ptr                        PIC 9(4).
       01 cur-char                      PIC X.
       01 prev-char                     PIC X.

       PROCEDURE DIVISION.

       OPEN INPUT INPUT-BANKS.
       OPEN INPUT INPUT-TRANSACTIONS.
       OPEN OUTPUT OUTPUT-ACCOUNT-STATEMENTS.

       PERFORM LOAD-BANKS.

       PERFORM UNTIL EOF-TRANSACTIONS = "Y"
           READ INPUT-TRANSACTIONS INTO TRANSACTION-RECORD
               AT END
                   MOVE "Y" TO EOF-TRANSACTIONS
               NOT AT END
                   MOVE "----------------------------" TO INFO
                   WRITE ACCOUNT-STATEMENT-INFO

                   MOVE SPACES TO INFO
                   STRING "Kunde: " DELIMITED BY SIZE
                       OWNER DELIMITED BY SIZE
                       INTO INFO
                   WRITE ACCOUNT-STATEMENT-INFO

                   MOVE SPACES TO INFO
                   STRING "Adresse: " DELIMITED BY SIZE
                       STREET-ADDRESS DELIMITED BY SIZE 
                       INTO INFO
                   WRITE ACCOUNT-STATEMENT-INFO

                   MOVE SPACES TO INFO
                   STRING 
           "                                                           "
                       DELIMITED BY SIZE
                       "Registreringsnummer: " DELIMITED BY SIZE
                       REG-NR DELIMITED BY SIZE
                       INTO INFO
                   WRITE ACCOUNT-STATEMENT-INFO
                   
                   STRING 
           "                                                           "
                       DELIMITED BY SIZE
                       "Bank " DELIMITED BY SIZE
                       BANK-NAME OF BANK-RECORD(1) delimited by size
                       INTO INFO


                   PERFORM WRITE-BLANKS
           END-READ
       END-PERFORM.
       
       CLOSE OUTPUT-ACCOUNT-STATEMENTS.
       CLOSE INPUT-TRANSACTIONS.
       CLOSE INPUT-BANKS.

       STOP RUN.

      * --------------------- PARAGRAPH SECTION ------------------------
       LOAD-BANKS.
           SET idx-bank TO 1
           PERFORM UNTIL EOF-BANKS = "Y"
           READ INPUT-BANKS INTO BANK-RECORD
               AT END 
                   MOVE "Y" TO EOF-BANKS
               NOT AT END
                   MOVE BANK-RECORD TO BANK-ARRAY(idx-bank)
                   SET idx-bank UP BY 1
           END-READ
           END-PERFORM.
       EXIT.

       WRITE-BLANKS.
           MOVE SPACES TO INFO
           WRITE ACCOUNT-STATEMENT-INFO
           MOVE SPACES TO INFO
           WRITE ACCOUNT-STATEMENT-INFO
           MOVE SPACES TO INFO
           WRITE ACCOUNT-STATEMENT-INFO
       EXIT.

       CLEAN-SPACES.
           MOVE 1 TO IN-PTR
           MOVE 1 TO OUT-PTR
           MOVE SPACE TO PREV-CHAR
           MOVE SPACES TO CLEAN-TEXT
       
           PERFORM UNTIL IN-PTR > LENGTH OF RAW-TEXT
               MOVE RAW-TEXT(IN-PTR:1) TO CUR-CHAR
       
               IF CUR-CHAR NOT = SPACE
                   OR PREV-CHAR NOT = SPACE
                   MOVE CUR-CHAR TO CLEAN-TEXT(OUT-PTR:1)
                   ADD 1 TO OUT-PTR
               END-IF
       
               MOVE CUR-CHAR TO PREV-CHAR
               ADD 1 TO IN-PTR
           END-PERFORM.
       EXIT.
