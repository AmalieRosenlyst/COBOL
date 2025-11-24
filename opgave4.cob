      * Formål: Forstå konceptet bag strukturer i COBOL og hvordan de 
      *    anvendes til at organisere og arbejde med relaterede data som 
      *    én enhed. Fokus vil være på opbygning af strukturer, 
      *    manipulation af data og udskrivning af strukturen som helhed.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 customer-info.
           02 kunde-id         PIC X(10) VALUE SPACES.
           02 fornavn          PIC X(20) VALUE SPACES.
           02 efternavn        PIC X(20) VALUE SPACES.
           02 account-info.
               03 kontonummer      PIC X(20) VALUE SPACES.
               03 balance          PIC 9(7)V99 VALUE ZEROES.
               03 valutakode       PIC X(3) VALUE SPACES.
       PROCEDURE DIVISION.

       MOVE "1337 66666" TO kunde-id.
       MOVE "Alice" TO fornavn.
       MOVE "Gunnarson" TO efternavn.
       MOVE "DK 123456789 666" TO kontonummer.
       MOVE 42.08 TO balance.
       MOVE "DKK" TO valutakode.

       DISPLAY customer-info.
       
       STOP RUN.
