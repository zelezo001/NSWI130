# Jako garant chci smazat předmět, protože už nemám čas ho přednášet

## Scénáře:

- Smazání existujícího předmětu

## Detailně:

1. Garant otevře modul "Předměty"
2. Systém zobrazí list existujících předmětů
3. Garant vybere "Smazat předmět" vedle předmětu který chce smazat
4. Systém ověří že interakce nebyla omyl ("Jste si jistý/á?")
5. Pokud garant nepotvrdí, systém akci odmítne
6. Jinak systém:
    - označí předmět jako smazaný
    - odepíše všechny studenty
    - pošle notifikaci studentům
    - ohlásí úspěch

## Požadavky:

### Business
- Systém musí umět vyhledávat mezi předměty podle jejich kódu, názvu a podle relace k vyhledávajícímu ("předmět, co garantuju").
- Systém musí umět smazat předmět

### Technické
- Systém musí umět vyhledávat v předmětech
- Systém musí umět uložit "smazanou" revizi předmětu
- Systém musí umět uložit "smazanou" revizi rozvrhového lístku
- Systém musí umět odepsat studenty ze smazaného lístku
- Notifikace uživatelů

### Kvalitativní
- Systém musí umět při mazání předmětu uvést do konsistentího stavu
