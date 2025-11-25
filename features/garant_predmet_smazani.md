# Jako garant chci smazat předmět protože už nemám čas ho přednášet

## Scénáře:

- Smazání existujícího předmětu

## Detailně:

- Garant otevře modul "Předměty"
- Systém zobrazí list existujících předmětů
- Garant vybere "Smazat předmět" vedle předmětu který chce smazat
- Systém ověří že interakce nebyla omyl ("Jste si jistý/á?")
- Pokud garant nepotvrdí, systém akci odmítne
- Jinak systém:
  - označí předmět jako smazaný
  - odepíše všechny studenty
  - pošle notifikaci studentům
  - ohlásí úspěch

## Požadavky:

- Ověření oprávnění garanta
- Potvrzení destruktivní akce
- Vypisování/filtrování všech předmětů
- Notifikace uživatelů
- Verzování záznamů v databázi

