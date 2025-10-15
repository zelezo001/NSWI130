### Povolení zápisového období

#### Feature breakdown

1. Administrátor/studijní odd. se přihlásí do studijního systému
2. Administrátor/studijní odd. otevře modul "zápis"
3. Administrátor/studijní odd. otevře podmodul "nastavení zápisového období"
4. Modul nastavení zobrazi seznam predmetu, ktere odpovidaji popisu.
5. Administrátor zadá počáteční a koncové datum zápisového období, případně další parametry (např. omezení pro konrétní předměty, zápis volný/přednostní).
6. Systém validuje zadané údaje (formát dat, kolize s jinými obdobími, oprávnění uživatele).
7. Po potvrzení systém uloží nastavení do databáze.
8. Systém informuje administrátora o úspěšném nastavení období.
9. Systém automaticky aktivuje/deaktivuje zápisové funkce pro studenty dle nastaveného období.
10. Systém zaloguje změny nastavení zápisového období.

### Responsibilities

#### Authorization responsibility
- Ověření identity a oprávnění uživatele (pouze administrátor/studijní oddělení může měnit počty zápisů).

#### Data validation responsibility

#### Data persistence responsibility
- Uložení nastavení počtu zápisů do databáze.

#### Notification responsibility
- Notifikace administrátora o úspěšném nastavení.
-

#### Error handling responsibility

- Zpracování chyb při zadávání dat (špatný formát, kolize, nedostatečná oprávnění).
- Zobrazení chybových hlášek uživateli.

#### User interface responsibility
- Historie změn

#### Logging responsibility

- Zaznamenání všech změn nastavení počtu zápisů do logu.
