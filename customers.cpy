           02 client-id                PIC X(10) VALUE SPACES.
           02 first-name               PIC X(20) VALUE SPACES.
           02 last-name                PIC X(20) VALUE SPACES.
           02 account-info.
               03 account-number       PIC X(20) VALUE SPACES.
               03 balance              PIC 9(7)V99 VALUE ZEROES.
               03 valuta-code          PIC X(3) VALUE SPACES.
           02 c-address.
               03 road-name            PIC X(30).
               03 house-number         PIC X(5).
               03 floor                PIC X(5).
               03 side                 PIC X(5).
               03 city                 PIC X(20).
               03 postal-code          PIC X(4).
               03 country-code         PIC X(2).
           02 contact-info.
               03 phone                PIC X(8).
               03 email                PIC X(50).
