# garant chce smazat předmět PROTOŽE už nemá čas ho přednášet

## Detailně:

- učitel si otevře sis
- vybere 'předměty'
- vybere konkrétní předmět
- systém ukáže vyplnění formulář
- odešle "smazat" formulář nebo sudo formulář
- pokud neodeslal sudo, pošle zpátky chybu
- systém "smaže" rozvrhové lístky předmětu:
    - vyrobí novou revizi s vypnoutou existencí
    - odepíše všechny studenty
    - pošle studentům notifikaci
- systém vyrobí novou revizi s vypnoutou existencí
- systém pošle zpátky ack

## Požadavky:

- Systém musí umět vyhledávat mezi předměty podle jejich kódu, názvu a podle relace k vyhledávajícímu ("předmět, co garantuju").
- Systém musí umět uložit zmizení předmětu, odepsat studenty.

