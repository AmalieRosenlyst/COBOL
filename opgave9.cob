      * Formål: Skriv data til arrays og brug array'et 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReadFile.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INPUT-CUSTOMERS ASSIGN TO "customer-info.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT OUTPUT-FILE ASSIGN TO "customers-w-account2.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT INPUT-ACCOUNTS ASSIGN TO "account-info.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD INPUT-CUSTOMERS.
       01 CUSTOMER-RECORD.
           COPY "customers.cpy".
       FD OUTPUT-FILE.
       01 CLIENT-INFO.
           02 INFO                     PIC X(80).
       FD INPUT-ACCOUNTS.
       01 ACCOUNT-RECORD.
           COPY "account-info.cpy".

       WORKING-STORAGE SECTION.
      * Variable used as condition in while loop
       01 END-OF-FILE              PIC X VALUE "N".

       01 ACCOUNT-ARRAY            OCCURS 5 TIMES INDEXED BY i-acc.
           COPY "account-info.cpy".
       01 idx                      PIC 99 VALUE 1.

      * Variables trimming strings
       01 clean-text               PIC X(200).
       01 raw-text                 PIC X(200).
       01 out-ptr                  PIC 9(4).
       01 in-ptr                   PIC 9(4).
       01 cur-char                 PIC X.
       01 prev-char                PIC X.

       PROCEDURE DIVISION.

       OPEN INPUT INPUT-CUSTOMERS
       OPEN INPUT INPUT-ACCOUNTS
       OPEN OUTPUT OUTPUT-FILE

      * Read account file into array :) 
       PERFORM UNTIL END-OF-FILE = "Y"
           READ INPUT-ACCOUNTS INTO ACCOUNT-RECORD
               AT END 
                   MOVE "Y" TO END-OF-FILE
               NOT AT END
                   MOVE ACCOUNT-RECORD TO ACCOUNT-ARRAY(idx)
                   ADD 1 TO idx
           END-READ
       END-PERFORM.

       MOVE "N" TO END-OF-FILE.

       PERFORM UNTIL END-OF-FILE = "Y"
           READ INPUT-CUSTOMERS INTO CUSTOMER-RECORD
               AT END
                   MOVE "Y" TO END-OF-FILE
               NOT AT END
                   MOVE client-id OF CUSTOMER-RECORD TO INFO
                   WRITE CLIENT-INFO

                   PERFORM FORMAT-NAME
                   WRITE CLIENT-INFO

                   PERFORM FORMAT-ADDRESS
                   WRITE CLIENT-INFO

                   PERFORM FORMAT-POSTAL-CITY
                   WRITE CLIENT-INFO

                   MOVE SPACES TO INFO
                   MOVE phone TO INFO
                   WRITE CLIENT-INFO

                   MOVE SPACES TO INFO
                   MOVE email TO INFO
                   WRITE CLIENT-INFO
                   
      * Check if customer has an account
                   SEARCH ACCOUNT-ARRAY 
                       WHEN 
                       client-id OF ACCOUNT-ARRAY(i-acc) 
                       = client-id OF CUSTOMER-RECORD
                           MOVE ACCOUNT-ARRAY(i-acc) TO ACCOUNT-RECORD
                           PERFORM FORMAT-ACCOUNT
                           WRITE CLIENT-INFO
                   END-SEARCH
                   MOVE 1 TO i-acc

                   MOVE SPACES TO INFO
                   WRITE CLIENT-INFO
           END-READ
       END-PERFORM.
       
       CLOSE INPUT-CUSTOMERS
       CLOSE INPUT-ACCOUNTS
       CLOSE OUTPUT-FILE

       STOP RUN.

      * --------------------- PARAGRAPH SECTION ------------------------
       FORMAT-NAME.
           MOVE SPACES TO RAW-TEXT
           STRING first-name DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   last-name DELIMITED BY SIZE 
                   INTO RAW-TEXT

           PERFORM CLEAN-SPACES
           MOVE SPACES TO INFO
           MOVE CLEAN-TEXT TO INFO
       EXIT.

       FORMAT-ADDRESS.
           MOVE SPACES TO RAW-TEXT
           STRING road-name DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   house-number DELIMITED BY SIZE
                   " " DELIMITED BY SIZE 
                   floor DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   side DELIMITED BY SIZE 
                   INTO RAW-TEXT

           PERFORM CLEAN-SPACES
           MOVE SPACES TO INFO
           MOVE CLEAN-TEXT TO INFO
       EXIT.

       FORMAT-POSTAL-CITY.
           MOVE SPACES TO RAW-TEXT
           STRING postal-code DELIMITED BY SIZE 
           " " DELIMITED BY SIZE
           city DELIMITED BY SIZE
           " " DELIMITED BY SIZE 
           country-code DELIMITED BY SIZE 
           INTO RAW-TEXT

           PERFORM CLEAN-SPACES
           MOVE SPACES TO INFO
           MOVE CLEAN-TEXT TO INFO
       EXIT.

       FORMAT-ACCOUNT.
           MOVE SPACES TO RAW-TEXT
           STRING 
           account-number OF ACCOUNT-RECORD 
               DELIMITED BY SIZE
           " " DELIMITED BY SIZE
           account-type OF ACCOUNT-RECORD 
               DELIMITED BY SIZE
           " " DELIMITED BY SIZE
           balance OF ACCOUNT-RECORD 
               DELIMITED BY SIZE
           " " DELIMITED BY SIZE
           valuta-code OF ACCOUNT-RECORD 
               DELIMITED BY SIZE
           INTO RAW-TEXT

           PERFORM CLEAN-SPACES
           MOVE CLEAN-TEXT TO INFO
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
