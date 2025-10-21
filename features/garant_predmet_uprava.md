# garant chce upravit předmět PROTOŽE něco napsal špatně

## Detailně:

- učitel si otevře sis
- vybere 'předměty'
- vybere konkrétní předmět
- systém ukáže vyplněný formulář
- učitel upraví formulář
- odešle formulář nebo odešle sudo formulář
- systém zkontroluje údaje
- pokud bylo něco špatně, pošle zpátky chybu
- pokud upravil chráněné vlastnosti a neodeslal sudo, pošle zpátky chybu
- jinak pošle zpátky ack
- zapíše do předmětu referenci na předchodí revizi
- zapíše novou revizi předmětu do databáze
- notifikuje zapsané studenty a možná další?

## Požadavky

- Systém musí umět zobrazovat předvyplněný formuláře
- Systém musí umět komunikovat s uživatelem
- Systém musí umět validovat údaje
- Systém musí umět číst perzistentně uložená data
