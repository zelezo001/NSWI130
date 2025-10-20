# Příslušník univerzity si chce zobrazit rozvrh předmětu, aby viděl příslušné rozvržené entity.

## Scénáře:

- Student chce vidět rozvrh předmětu, protože chce vědět, jestli má časové dispozice na jeho zápis.
- Učitel chce vidět rozvrh předmětu, protože ho zajímá, kdy probíhají semináře oproti přednášce.
- Rozvrhář chce vidět rozvrh předmětu, protože chce dva rozvrhy porovnat.

## Detailně:

1. Příslušník univerzity se příhlásí do informačního systému.
2. Vybere 'předměty'.
3. Vyhledá konkrétní předmět.
4. Systém zobrazí formulář pro hledání předmětu.
5. Proběhne odeslání formuláře.
6. Systém najde v databázi odpovídající předměty.
7. Systém vrátí odpovídající předměty.
8. Člověk vybere konkrétně z vrácených předmětů.
9. Systém najde v databázi detaily předmětu a jeho rozvrh.
10. Systém zobrazí podrobnosti o vybraném předmětu.
11. Člověk vybere 'rozvrh'.
12. Systém zobrazí rozvrh pro současný semestr.

## Požadavky:

- Uživatelské:
    - Systém musí umět přívětivě zobrazit rozvrh.
    - Systém musí umět exportovat rozvrh v rozumném formátu.
    - Systém musí umět zobrazit rozvrh i u starších semestrů.

- Datové:
    - Systém musí umět k předmětu najít rozvrh.
    - Systém musí umět k předmětu najít historické rozvrhy.

- Technické:
    - Systém musí umět načíst hodnoty pro formulář na hledání předmětu.
    - Systém musí umět validovat datové položky ve formuláři.
    - Systém musí umět efektivně hledat mezi všemi předměty.
    - Systém musí umět na jednotlivé dotazy vracet pouze efektivní data.
    - Systém musí umět na základě role zobrazit pouze relevantní informace.

- Bezpečnostní:
    - Systém musí umět sanitizaci inputů v rámci formuláře.

- Kvalitativní:
    - Systém musí umět zvládnout očekávanou zátěž v období zápisu.
