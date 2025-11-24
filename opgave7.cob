      * Formål: skriv data til en fil. 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReadFile.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INPUT-FILE ASSIGN TO "customer-info.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT OUTPUT-FILE ASSIGN TO "customers-pretty-print.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD INPUT-FILE.
       01 INPUT-RECORD.
           COPY "customers.cpy".
       FD OUTPUT-FILE.
       01 CLIENT-INFO.
           02 INFO                     PIC X(80).

       WORKING-STORAGE SECTION.
      * Variable used as condition in while loop
       01 END-OF-FILE PIC X VALUE "N".

       01 idx                      PIC 9(2) VALUE ZEROES.
       01 idx-output               PIC 9(2) VALUE ZEROES.
       01 current-char             PIC X(1) VALUE SPACES.
       01 prev-char                PIC X(1) VALUE SPACES.
       01 fullname                 PIC X(40) VALUE SPACES.
       01 full-address             PIC X(80) VALUE SPACES.

       PROCEDURE DIVISION.

       OPEN INPUT INPUT-FILE
       OPEN OUTPUT OUTPUT-FILE

       PERFORM UNTIL END-OF-FILE = "Y"
           READ INPUT-FILE INTO INPUT-RECORD
               AT END
                   MOVE "Y" TO END-OF-FILE
               NOT AT END
                   MOVE client-id TO INFO
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

                   MOVE SPACES TO INFO
                   WRITE CLIENT-INFO
           END-READ
       END-PERFORM.
       
       CLOSE INPUT-FILE
       CLOSE OUTPUT-FILE

       STOP RUN.

       FORMAT-NAME.
           STRING first-name DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   last-name DELIMITED BY SIZE 
                   INTO fullname
                   
           MOVE 1 TO idx-output
           PERFORM VARYING idx FROM 1 BY 1 
           UNTIL idx > LENGTH OF fullname
               MOVE fullname(idx:1) TO current-char
             
               IF current-char NOT = SPACE 
               OR prev-char NOT = SPACE THEN
                    MOVE current-char TO 
                    INFO(idx-output:1)
                    ADD 1 TO idx-output
               END-IF
             
               MOVE current-char TO prev-char
           END-PERFORM
       EXIT.

       FORMAT-ADDRESS.
           STRING road-name DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   house-number DELIMITED BY SIZE
                   " " DELIMITED BY SIZE 
                   floor DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   side DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   postal-code DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   city DELIMITED BY SIZE 
                   " " DELIMITED BY SIZE 
                   country-code DELIMITED BY SIZE 
                   INTO full-address

           MOVE 1 TO idx-output
           MOVE SPACES TO prev-char
           MOVE SPACES TO INFO
           PERFORM VARYING idx FROM 1 BY 1 
           UNTIL idx > LENGTH OF full-address
               MOVE full-address(idx:1) TO current-char

               IF current-char NOT = SPACE 
               OR prev-char NOT = SPACE THEN
                    MOVE current-char TO 
                    INFO(idx-output:1)
                    ADD 1 TO idx-output
               END-IF
             
               MOVE current-char TO prev-char
           END-PERFORM
       EXIT.

       FORMAT-POSTAL-CITY.
           MOVE SPACES TO INFO
           STRING postal-code DELIMITED BY SIZE 
           " " DELIMITED BY SIZE
           city DELIMITED BY SIZE
           INTO INFO
       EXIT.
