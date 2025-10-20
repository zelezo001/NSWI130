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

## Dekompozice architektury:

- Prezentační úroveň:
    - Základní UI:
        - Zobrazit formulář
        - Zobrazit seznam nalezených předmětů
    - Služba na zobrazení předmětu:
        - Zobrazit detaily předmětu
    - Služba na zobrazení rozvrhu:
        - Zobrazit rozvrh

- Aplikační úroveň:
    - Služba na načtení formuláře:
        - Z databáze získá nutná data pro jednotlivé položky formuláře
    - Služba na ověření formuláře:
        - Validace datových položek
        - Sanitizace inputů
    - Služba na hledání předmětů:
        - Přijmout formulář
        - Efektivně najít odpovídající předměty
        - Vrátit nalezené předměty
    - Služba pro správu práv:
        - Jaké akce smí uživatel vykonat
        - Jaká data smí uživatel vidět
    - Služba pro export rozvrhu:
        - Exportuje rozvrh v daném formátu

- Perzistenční úroveň:
    - Univerzitní databáze:
        - Repozitář informací k vyhledávání předmětů
    - Předmětová databáze:
        - Repozitář předmětů
    - Rozvrhová databáze:
        - Načíst aktuální rozvrh
        - Načíst historické rozvrhy
    - Cache v období očekávaného vytížení:
        - Uchovávat si pouze předměty vypsané v aktuálním semestru

## Závislosti:

- `Uživatel` interaguje se:
    - `základním UI`, kde hledá předmět

- `Základní UI` interaguje se:
    - `službou pro načtení formuláře`, kde požádá o jeho načtení pro následné vyhledávání
    - `službou pro ověření formuláře`, kde ověří formulář na hledání předmětu
    - `službou na hledání předmětů`, kam podá ověřený formulář na vyhledání předmětu a která odpovídající předměty vrátí
    - `službou pro export rozvrhu`, kam podá požadavek na export do daného formátu
    - `službou na zobrazení předmětu`, kde si nechá zobrazit daný předmět
    - `službou na zobrazení rozvrhu`, kde si nechá zobrazit rovzrh daného předmětu

- `Služba na zobrazení předmětu` interaguje s:
    - `předmětovou databází`, kde získá potřebné datové položky
    - `službou pro správu práv`, kde se dozví, co smí uživateli zobrazit

- `Služba na zobrazení rozvrhu` interaguje s:
    - `rozvrhovou databází`, kde získá potřebné datové položky
    - `službou pro správu práv`, kde se dozví, co smí uživateli zobrazit

- `Služba pro načtení formuláře` interaguje s:
    - `univerzitní databází`, kde získává možná data pro datové položky

- `Služba na hledání předmětů` interaguje s:
    - `předmětovou databází`, kde získává předměty odpovídající danému vyhledávání