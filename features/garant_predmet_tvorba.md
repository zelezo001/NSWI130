# Jako garant chci vyrobit předmět, protože chci přednášet studentům

## Scénáře:

- Vytvoření zcela nového předmětu

## Detailně:

1. Garant otevře modul "Předměty"
2. Vybere akci "Vytvořit předmět"
3. Systém zobrazí formulář
4. Garant vyplní údaje (název, kód, popis, kredity)
5. Garant odešle formulář
6. Systém přijme požadavek
7. Systém zpracuje data: 
    - validuje formát a úplnost
    - ověří unikátnost kódu
    - vygeneruje UID (prefix + increment)
8. Při chybě validace vrátí chybovou zprávu
9. Při úspěchu:
    - uloží předmět do databáze
    - vrátí potvrzení
    - zobrazí detail předmětu

## Požadavky

- Ověření oprávnění garanta
- Dynamické formuláře s validací
- Generování unikátních ID
- Validace povinných polí a formátů
- Atomicita operace (UID + uložení)
