# Jako garant chci upravit předmět protože jsem něco napsal špatně

## Scénáře:

- Úprava existujícího předmětu

## Detailně:

- Garant otevře modul "Předměty"
- Systém zobrazí list existujících předmětů
- Garant vybere "Upravit předmět" vedle předmětu který chce smazat
- Systém zobrazí formulář vyplněný daty z DB
- Garant upraví formulář

- Garant odešle formulář
- Systém přijme požadavek
- Systém zpracuje data: 
  - Validuje formát a úplnost
  - Ověří unikátnost kódu
  - Vygeneruje UID (prefix + increment)
- Při chybě validace:
  - Vrátí chybovou zprávu
- Při úspěchu:
  - Uloží předmět do databáze
  - Vrátí potvrzení
  - Zobrazí detail předmětu
  - Notifikuje zapsané studenty

## Požadavky

- Ověření oprávnění garanta
- Čtení předmětů
- Dynamické formuláře s validací
- Generování unikátních ID
- Validace povinných polí a formátů
- Atomicita operace (UID + uložení)
