# Jako garant chci vyrobit předmět protože chci přednášet studentům

## Scénáře:

- Vytvoření zcela nového předmětu

## Detailně:

- Garant otevře modul "Předměty"
- Vybere akci "Vytvořit předmět"
- Systém zobrazí formulář
- Garant vyplní údaje (název, kód, popis, kredity)

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

## Požadavky

- Ověření oprávnění garanta
- Dynamické formuláře s validací
- Generování unikátních ID
- Validace povinných polí a formátů
- Atomicita operace (UID + uložení)
