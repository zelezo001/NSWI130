### Fronta (čekací listina)

#### Feature breakdown

1. Student/učitel se přihlásí do informačního systému
2. Student/učitel si otevře modul Zápis
3. Student/učitel si otevře podmodul Čekací listina
4. Systém zobrazí tabulku, kde pro každý předmět, ve kterém je student na čekací listině, bude záznam o konkrétním lístku a počtu lidí ve frontě před ním
5. Pod ní bude tabulka rozvrhových lístků vyučovaných touto osobou. ID lístku bude odkaz
6. Po kliknutí na tento odkaz zobrazí systém seřazenou tabulku studentů ve frontě
7. Bude zde navíc sloupeček s tlačítkem na zápis studenta na lístke
   - po kliknutí na něj zobrazí systém dialog s tím, že přijmutím tohoto studenta se navýší kapacita lístku o 1
   - po potvrzení dialogu se zavolá api na zápis studenta

Pozn.: učitel může být i student, takže uvidí dvě tabulky

### Responsibilities

#### Authentication and authorization

- Podmodul si může zobrazit student/učitel, pro které potřebuji vědět, jaké mají zapsané/učí předměty

#### Data persistence responsibility

- Provedení zápisu studenta na předmět při uvolnění kapacity
- Přidání studenta do fronty při zápisu na čekací listinu

#### Notification responsibility

- notifikace studenta, když se pro něj uvolní místo

#### Validation responsibility

- limit maximálního počtu čekajících

#### Activation/deactivation responsibility

- aktivace čekací listiny pouze u předmětů s omezenou kapacitou
- deaktivace po ukončení zápisového období nebo naplnění všech kapacit

#### Error handling responsibility

- zobrazení správné chybové hlášky v možných scénářích (nedostupná databáze, server)

#### User interface responsibility

- přehledné zobrazení tabulek se studenty

#### Logging responsibility

- zaznamenání chybových hlášek do logu
