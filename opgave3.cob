      * Formål: Lær at oprette løkker og håndtere/modificere strenge i 
      *    COBOL. Du vil lære at kombinere data fra flere variabler, 
      *    fjerne overskydende mellemrum og arbejde med loop-baserede 
      *    datamodifikationer.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 client-id                PIC X(10) VALUE SPACES.
       01 first-name               PIC X(20) VALUE SPACES.
       01 last-name                PIC X(20) VALUE SPACES.
       01 fullname                 PIC X(40) VALUE SPACES.
       01 account-number           PIC X(20) VALUE SPACES.
       01 balance                  PIC 9(6)V99 VALUE ZEROES.
       01 valuta-code              PIC X(3) VALUE SPACES.

       01 idx                      PIC 9(2) VALUE ZEROES.
       01 idx-output               PIC 9(2) VALUE ZEROES.
       01 current-char             PIC X(1) VALUE SPACES.
       01 prev-char                PIC X(1) VALUE SPACES.
       01 fullname-clean           PIC X(40) VALUE SPACES.

       PROCEDURE DIVISION.

       MOVE "1337 66666" TO client-id.
       MOVE "Alice" TO first-name.
       MOVE "Gunnarson" TO last-name.
       MOVE "DK 1234567890000 666" TO account-number.
       MOVE 42.08 TO balance.
       MOVE "DKK" TO valuta-code.

       STRING first-name DELIMITED BY SIZE " "
              DELIMITED BY SIZE last-name
              DELIMITED BY SIZE 
              INTO fullname

       PERFORM VARYING idx FROM 0 BY 1 UNTIL idx > 40
           MOVE fullname(idx:1) TO current-char

           IF current-char NOT = SPACE OR prev-char NOT = SPACE THEN
               MOVE current-char TO fullname-clean(idx-output:1)
               ADD 1 TO idx-output
           END-IF

           MOVE current-char TO prev-char
       END-PERFORM.

       DISPLAY "-----------------------------------------------".
       DISPLAY "| Client ID          :   " client-id.
       DISPLAY "| Name               :   " fullname-clean.
       DISPLAY "| Account number     :   " account-number.
       DISPLAY "| Balance            :   " balance " " valuta-code.
       DISPLAY "-----------------------------------------------".
       
       STOP RUN.
