# Rozvrhy

Cílem našeho projektu bylo navrhout část SISu starající se o správu předmětů a rozvrhů.

## Rozdělení zodpovědností

### Rozvrhovadlo
- Systém musí zvládnout rozvrhnutí velkého množství rozvrhových lístků.
- Systém musí být schopný efektivně a přehledně zaplněnost jedné místnosti po celý semestr.
- Systém musí umět rozvrhout do všech dostupných místností po škole v časech jejich dostupnosti.
- Systém musí umožnit variabilní délku rozvrhových lístků (např. po slotech).
- Systém musí umožnit rozvrhovat lístky na v každý den (včetně víkendů).

### SIS frontend
- Systém musí umět přívětivě zobrazit rozvrh.
- Systém musí umět exportovat rozvrh v rozumném formátu.
- Systém musí umět zobrazit rozvrh i u starších semestrů.
- Systém musí umět validovat datové položky ve formuláři.

### SIS backend
- Systém musí umět validovat vstupy požadavků.
- Systém musí umět zvládnout očekávanou zátěž v období zápisu.
- Systém musí umět zobrazit rozvrh i u starších semestrů.
- Systém musí umět vyhledávat mezi předměty podle jejich atributů a podle relace k vyhledávajícímu ("předmět, co garantuju").

### SIS admin backend
- Systém musí umět validovat vstupy požadavků.
- Systém musí umět odepsat studenty ze smazaného lístku.
- Systém musí odespané studenty notifikovat o změnách v předmětech.
- Systém musí umět smazat předmět.
- Systém musí umět při mazání předmětu uvést do konsistentího stavu
- Systém musí umět uporoznit uživatele na kolizi mezi rozvrhovými lístky.
- Systém musí být schopen ověřit validitu zadaných dat.
- Systém musí umět porovnat časový slot jedné akce se sadou existujících akcí.
- Systém musí spolehlivě identifikovat překryvy pro více zdrojů najednou (místnost, osoba).
- Systém musí umět zabránit uložení akce, která způsobuje kolizi.
- Systém musí umožnit vynucené uložení kolidující akce pro uživatele s dostatečným oprávněním.

[//]: # (Možná na klasický BE, využívá rozvrhovátko)
- Systém musí umět hledat v rozvrhových lístcích podle místnosti.
- Systém musí umět vyhledávat mezi předmety podle jejich kódu.
  a podle vlastností předmětu (kód, název, katedra, fakulta).

### SIS admin frontend
- Systém musí mít implementovaný mechanismus pro okamžitou zpětnou vazbu v uživatelském rozhraní.
- Systém musí být schopen v uživatelském rozhraní zobrazovat různé typy zpráv (potvrzení, varování, chyby) v reálném čase.

### Databáze rozvrhů
- Systém musí umět uložit "smazanou" revizi rozvrhového lístku
- Systém si musí pamatovat kde a kdy jsou rozvrhové lístky rozvrženy.
### Databáze předmětů
- Systém musí umět uložit "smazanou" revizi předmětu
### Databáze rozvrhových slotů
- Systém musí znát fakulty/katedry na škole.

## Architektonické rozhodnutí

- Rozdělení BE na admin/public:
  - Do budoucna lze admin skrýt do privátní sítě.
  - Public část je read-only a lze ji do budoucna škálovat bez potřeby škálovat admin.
    - Nyní by to mělo jít bez zásahu do architektury.
  - Public část nepotřebuje autorizovat uživatele.
  - Na public část lze použít read oriented protokoly (graphQL).
- Rozdělení databází:
  - Rozvrhové sloty nejsou v gestci naší části a může ji do ní zapisovat někdo jiný (např. správa budov UK).
  - Ne všechny předměty budou pocházet z UK (meziuniverzitní dohody) a proto je potřeba separatovat 
  rozvrhy do vlastní DB.