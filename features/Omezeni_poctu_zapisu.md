### Omezení počtu zápisů

#### Feature breakdown
1. Administrátor/studijní odd. se přihlásí do studijního systému
2. Administrátor/studijní odd. otevře modul "zápis"
3. Administrátor/studijní odd. otevře podmodul "předměty"
4. Administrátor/studijní odd. se zobrazi rozhraní, ve kterém vyhledá předmět, u kterého chce nastavit omezení počtu zápisů
5. Systém zobrazí formulář pro nastavení omezení počtu zápisů.
6. Administrátor/studijní odd. zadá maximální počet zápisů pro vybraný předmět.
7. Systém validuje zadané údaje (formát dat, oprávnění uživatele).
8. Po potvrzení systém uloží nastavení do databáze.
9. Systém informuje administrátora o úspěšném nastavení omezení.
10. Systém automaticky aplikuje omezení při zápisu studentů do předmětu.
11. Systém zaloguje změny nastavení omezení počtu zápisů.

#### Responsibilities

#### Authorization responsibility
- Ověření identity a oprávnění uživatele (pouze administrátor/studijní oddělení může měnit omezení počtu zápisů).

#### Data persistence responsibility
- Uložení nastavení omezení počtu zápisů do databáze.

#### Notification responsibility
- Notifikace administrátora o úspěšném nastavení.

#### Error handling responsibility
- Zpracování chyb při zadávání dat (špatný formát, nedostatečná oprávnění).
- Zobrazení chybových hlášek uživateli.

#### User interface responsibility
- Historie změn

#### Logging responsibility
- Zaznamenání všech změn nastavení počtu zápisů do logu.