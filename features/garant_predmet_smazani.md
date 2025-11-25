# garant chce smazat předmět PROTOŽE už nemá čas ho přednášet

## Detailně:

- učitel si otevře sis
- vybere 'předměty'
- vybere konkrétní předmět
- systém ukáže vyplnění formulář
- odešle "smazat" formulář s potvrzením
- systém "smaže" rozvrhové lístky předmětu:
    - vyrobí novou revizi s vypnoutou existencí
    - odepíše všechny studenty
    - pošle studentům notifikaci
- systém vyrobí novou revizi s vypnoutou existencí
- systém pošle zpátky ack

## Požadavky:

### Business
- Systém musí umět vyhledávat mezi předměty podle jejich kódu, názvu a podle relace k vyhledávajícímu ("předmět, co garantuju").
- Systém musí umět smazat předmět

### Technické
- Systém musí umět vyhledávat v předmětech
- Systém musí umět uložit "smazanou" revizi předmětu
- Systém musí umět uložit "smazanou" revizi rozvrhového lístku
- Systém musí umět odepsat studenty ze smazaného lístku

### Kvalitativní
- Systém musí umět při mazání předmětu uvést do konsistentího stavu
