      * Formål: Copybooks er en vigtig del af COBOL-programmering og 
      *    bruges til at genbruge kode og opretholde konsistens i større 
      *    programmer. De fungerer som små stykker kode, der kan 
      *    inkluderes i andre COBOL-programmer ved hjælp af en COPY-
      *    kommando. Copybooks bruges primært til at definere 
      *    datastrukturer, konstante værdier eller proceduresektioner, 
      *    der ofte genbruges.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 customer-info.
           COPY "customers.cpy".
       PROCEDURE DIVISION.

      * Set values for account info
       MOVE "1337 66666" TO client-id.
       MOVE "Alice" TO first-name.
       MOVE "Gunnarson" TO last-name.

      * Set values for account info
       MOVE "DK 123456789 666" TO account-number.
       MOVE 42.08 TO balance.
       MOVE "DKK" TO valuta-code.
       
      * Set values for customer address
       MOVE "Folievaenget" TO road-name.
       MOVE "666" TO house-number.
       MOVE "2." TO floor.
       MOVE "tv." TO side.
       MOVE "Sim City" TO city.
       MOVE "8210" TO postal-code.
       MOVE "DK" TO country-code.

      * Set values for contact info
       MOVE "45156685" TO phone.
       MOVE "ulla1337@mail.com" TO email.

       DISPLAY customer-info.

       DISPLAY "-----------------------------------------------".
       DISPLAY "| Client ID          :   " client-id.
       DISPLAY "| Name               :   " first-name " " last-name.
       DISPLAY "| Account number     :   " account-number.
       DISPLAY "| Balance            :   " balance " " valuta-code.
       DISPLAY "-----------------------------------------------".
       
       
       STOP RUN.
