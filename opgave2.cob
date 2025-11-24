      * Formål: Lær hvordan man opretter forskellige typer variabler og 
      *    flytter data mellem dem i COBOL.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 kunde-id         PIC X(10) VALUE SPACES.
       01 fornavn          PIC X(20) VALUE SPACES.
       01 efternavn        PIC X(20) VALUE SPACES.
       01 kontonummer      PIC X(20) VALUE SPACES.
       01 balance          PIC 9(7)V99 VALUE ZEROES.
       01 valutakode       PIC X(3) VALUE SPACES.
       PROCEDURE DIVISION.

       MOVE "1337 66666" TO kunde-id.
       MOVE "Alice" TO fornavn.
       MOVE "Gunnarson" TO efternavn.
       MOVE "DK 123456789 666" TO kontonummer.
       MOVE 42.08 TO balance.
       MOVE "DKK" TO valutakode.

       DISPLAY kunde-id.
       DISPLAY fornavn efternavn.
       DISPLAY kontonummer.
       DISPLAY balance valutakode.
       
       STOP RUN.
