      * Formål: Lær, hvordan man håndterer filer i COBOL, herunder 
      *    hvordan man åbner, læser og arbejder.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReadFile.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INPUT-FILE ASSIGN TO "customer-info.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD INPUT-FILE.
       01 INPUT-RECORD.
           COPY "customers.cpy".
       WORKING-STORAGE SECTION.
      * Variable used as condition in while loop
       01 END-OF-FILE PIC X VALUE "N".

       PROCEDURE DIVISION.

       OPEN INPUT INPUT-FILE

       PERFORM UNTIL END-OF-FILE = "Y"
           READ INPUT-FILE INTO INPUT-RECORD
               AT END
                   MOVE "Y" TO END-OF-FILE
               NOT AT END
                   DISPLAY "-------------------------------------------"
                   "------------"
                   DISPLAY "| Client ID            :  " client-id
                   DISPLAY "| Name                 :  " first-name 
                   " " last-name
                   
                   Display "| "
                   DISPLAY "| Account info" 
                   DISPLAY "|      Account number  :  " account-number
                   DISPLAY "|      Balance         :  " balance " " 
                   valuta-code
                   
                   Display "| "
                   Display "| Address info"
                   DISPLAY "|      Address         :  " road-name 
                   " " house-number " " floor " " side
                   DISPLAY "|      City            :  " city
                   DISPLAY "|      Postal code     :  " postal-code
                   DISPLAY "|      Country code    :  " country-code
                  
                   Display "| "
                   DISPLAY "| Contact info"
                   DISPLAY "|      Phone number    :  " phone
                   DISPLAY "|      Email           :  " email
                   DISPLAY "-------------------------------------------"
                   "------------"
           END-READ
       END-PERFORM.
       
       CLOSE INPUT-FILE

       STOP RUN.
