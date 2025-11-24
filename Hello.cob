      * Formål: Test, om COBOL er korrekt installeret, og lær 
      *    grundlæggende struktur for et COBOL-program.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VAR-TEXT         PIC X(30) VALUE "HELLO med Variabel".
       PROCEDURE DIVISION.
      *Nedenfor kommet en display - Cobols måde at skrive i konsollen
       DISPLAY VAR-TEXT
       STOP RUN.
