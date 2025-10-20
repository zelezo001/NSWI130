# někdo si chce zobrazit rozvrh předmětu, neboť chce vidět příslušné rozvržené entity

## Detailně:

- člověk otevře SIS
- vybere 'předměty'
- vyhledá předmět
    - technická zodpovědnost
- systém zobrazí formulář pro hledání předmětu
- z databází získá data na dropdown pole
- proběhne validace formuláře
- proběhne odeslání formuláře
- systém se podívá do databáze
- systém najde v databázi odpovídající předměty
- systém vrátí odpovídající předměty
    - technická zodpovědnost
- databáze nejdříve vrátí pouze identifikátory předmětu
- po vybrání konkrétního předmětu dojde k dalšímu dotazu
- databáze vrátí jeden konkrétní předmět včetně příslušných detailů
- člověk vybere konkrétně z vrácených předmětů
- systém zobrazí podrobnosti o vybraném předmětu
- člověk vybere 'rozvrh'
- systém zobrazí rozvrh pro současný semestr
