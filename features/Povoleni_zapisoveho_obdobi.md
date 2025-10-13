# Povolení zápisového období

1. Administrátor/studijní odd. se přihlásí do studijního systému
2. Administrátor/studijní odd. otevře modul "zápis"
3. Administrátor/studijní odd. otevře podmodul "nastavení zápisového období"
4. Systém zobrazí formulář pro nastavení období.
5. Administrátor zadá počáteční a koncové datum zápisového období, případně další parametry (např. omezení pro konrétní předměty, zápis volný/přednostní).
6. Systém validuje zadané údaje (formát dat, kolize s jinými obdobími, oprávnění uživatele).
7. Po potvrzení systém uloží nastavení do databáze.
8. Systém informuje administrátora o úspěšném nastavení období.
9. Systém automaticky aktivuje/deaktivuje zápisové funkce pro studenty dle nastaveného období.
10. Systém zaloguje změny nastavení zápisového období.

## Responsibilities

### Authorization responsibility

- Ověření identity a oprávnění uživatele (pouze administrátor/studijní oddělení může měnit zápisové období).

### Data validation responsibility

- Kontrola formátu zadaných dat (datum, čas).
- Ověření, že počáteční datum je před koncovým datem.
- Validace dalších parametrů (omezení předmětů, typ zápisu).

### Data persistence responsibility

- Uložení nastavení zápisového období do databáze.

### Activation/deactivation responsibility

- Automatické zapnutí/vypnutí možnosti zápisu pro studenty dle nastaveného období.
- Informování ostatních modulů systému o změně stavu zápisového období.

### Notification responsibility

- Notifikace administrátora o úspěšném nastavení.
- Notifikace studentů/pedagogů o blížícím se začátku/konci zápisového období.

### Error handling responsibility

- Zpracování chyb při zadávání dat (špatný formát, kolize, nedostatečná oprávnění).
- Zobrazení chybových hlášek uživateli.

### User interface responsibility

- Přehledné zobrazení aktuálního nastavení zápisového období.
- Formulář pro zadání/úpravu období.
- Zobrazení historie změn.

### Logging responsibility

- Zaznamenání všech změn nastavení zápisového období do logu.
