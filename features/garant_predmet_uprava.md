# Jako garant chci upravit předmět, protože jsem něco napsal špatně

## Scénáře:

- Úprava existujícího předmětu

## Detailně:

1. Garant otevře modul "Předměty"
2. Systém zobrazí list existujících předmětů
3. Garant vybere "Upravit předmět" vedle předmětu který chce smazat
4. Systém zobrazí formulář vyplněný daty z DB
5. Garant upraví formulář
6. Garant odešle formulář
7. Systém přijme požadavek
8. Systém zpracuje data: 
    - validuje formát a úplnost
    - ověří unikátnost kódu
    - vygeneruje UID (prefix + increment)
9. Při chybě validace vrátí chybovou zprávu
10. Při úspěchu:
    - uloží předmět do databáze
    - vrátí potvrzení
    - zobrazí detail předmětu
    - notifikuje zapsané studenty

## Požadavky

- Ověření oprávnění garanta
- Čtení předmětů
- Dynamické formuláře s validací
- Generování unikátních ID
- Validace povinných polí a formátů
- Atomicita operace (UID + uložení)
