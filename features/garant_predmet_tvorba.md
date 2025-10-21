# garant chce vyrobit předmět PROTOŽE nechce přednášet prázdné místnosti

## Detailně:

- učitel si otevře systém
- vybere 'předměty'
- vybere vyrobit předmět
- systém ukáže formulář
    - zodpovědnost zobrazování dat
- vyplní formulář
- odešle formulář
    - komunikační zodpovědnost
- systém zkontroluje údaje
    - Validační zodpovědnost
- pokud bylo něco špatně, pošle zpátky chybu
- jinak pošle zpátky ack
- vygeneruje UID předmětu (prefix+increment)
- zapíše do databáze
    - zodpovědnost ukladání dat

## Požadavky

- Systém musí umět zobrazovat formuláře
- Systém musí umět komunikovat s uživatelem
- Systém musí umět validovat údaje
- Systém musí umět perzistentně ukládat data
