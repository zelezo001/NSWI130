## Features - Use cases

#### Garant

1. Jako garant předmětu chci definovat požadavky na rozvrhnutí (např. preference časů a místnosti), aby rozvrhář mohl vytvořit kvalitní rozvrh.

#### Učitel

9. Jako učitel chci smazat předmět, protože už nemám čas ho přednášet.
10. Jako učitel chci vyrobit předět, protože nechci přednášet v prázdné místnosti.
11. Jako učitel chci upravit předět, protože něco napsal špatně.

#### Rozvrhář

2. Jako rozvrhář chci mít možnost rozvrhnout cvičení/přednášku a přiřadit jí místnost/čas abych mohl efektivně tvořit rozvrhy.
3. Jako rozvrhář chci interaktivně vidět volné sloty v rozvrhu (WIP) pro konkrétní místnost, učitele nebo studijní skupinu, abych mohl efektivně plánovat.
4. Jako rozvrhář chci, aby mě systém upozornil na kolize při plánování (stejný učitel/místnost ve stejný čas), abych předešel chybám.

#### Student

5. Jako student si chci vložit předmět do košíku, abych si mohl naplánovat semestr před oficiálním zápisem.

#### Manažer

6. Jako manažer fakulty chci zobrazit statistiky a reporty o úspěšnosti předmětů, abych mohl optimalizovat zdroje.
  
#### Společné

7. Jako student/učitel/host chci zobrazit existující rozvrh pro předmět, místnost, vyučujícího nebo svůj osobní rozvrh, neboť chci vidět příslušné rozvržené entity.
8. Jako student/učitel chci být automatcky notifikován o změně v mém rozvrhu (změna času, místnosti, zrušení hodiny).

12. Jako student/učitel chci exportovat rozvrh do osobního kalendáře, protože chci mít všechny budoucí události na jednom místě.

## Oblasti

- Definování požadavků a preferencí k rozvrhu (1, )
- Vytvoření a úprava rozvrhové akce (2, 3, 4, 5, 8)
- Zobrazení rozvrhu (7, 12)
- Předměty (9, 10, 11)
- Statistiky a reporty (6, )

##  Detailní Features

### garant chce vyrobit předět PROTOŽE nechce přednášet prázdné místnosti

#### Detailně:

- učitel si otevře sis
  - vybere 'předměty'
  - vybere vyrobit předmět
  - systém ukáže formulář
    - zodpovědnost zobrazování dat
      - %
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
      - číst data
      - 

### garant chce upravit předět PROTOŽE něco napsal špatně

#### Detailně:

  - učitel si otevře sis
  - vybere 'předměty'
  - vybere konkrétní předmět
  - systém ukáže vyplnění formulář
  - učitel upraví formulář
  - odešle formulář nebo odešle sudo formulář
  - systém zkontroluje údaje
  - pokud bylo něco špatně, pošle zpátky chybu
  - pokud upravil chráněné vlastnosti a neodeslal sudo, pošle zpátky chybu
  - jinak pošle zpátky ack
  - zapíše do předmětu referenci na předchodí revizi
  - zapíše novou revizi předmětu do databáze
  - notifikuje zapsané studenty a možná další?

### někdo si chce zobrazit rozvrh předmětu, neboť chce vidět příslušné rozvržené entity

#### Detailně:

- člověk otevře SIS
- vybere 'předměty'
- vyhledá předmět
  - technická zodpovědnost
- systém zobrazí formulář pro hledání předmětu
- z databází získá data na dropdown pole
- proběhne validace formuláře
- proběhne odeslání formuláře
- systém se podívá do databáze
- systém najde v databázi odpovídající předměty
- systém vrátí odpovídající předměty
  - technická zodpovědnost
- databáze nejdříve vrátí pouze identifikátory předmětu
- po vybrání konkrétního předmětu dojde k dalšímu dotazu
- databáze vrátí jeden konkrétní předmět včetně příslušných detailů
- člověk vybere konkrétně z vrácených předmětů
- systém zobrazí podrobnosti o vybraném předmětu
- člověk vybere 'rozvrh'
- systém zobrazí rozvrh pro současný semestr

### Jako rozvrhář chci mít možnost rozvrhnout cvičení/přednášku a přiřadit jí místnost/čas abych mohl efektivně tvořit rozvrhy.

#### Detailně:

1. Uživatel si otevře SIS (nebo rozvrhovou aplikaci) a a zvolí "tvorba nového rozvrhového lístku".
2. Systém zobrazí formulář pro vyhledání předmětu.
    - Možné filtry: název, kód předmětu, kód paralelky, fakulta (výčet), katedra (výčet)
3. Uživatel vyplní formulář a odešle ho.
4. Systém zpracuje formulář.
    1. Systém ověří vyplněné hodnoty. 
    2. Systém načte z databáze cvičení/přednášky podle zvoleného filtru.
    3. Systém vykreslí stránku s formulářem (bod 2) s vyplněnými hodnotami a pod něj vypíše cvičení/přednášky odpovídající filtru.
5. Uživatel si volí, který cvičení/přednášku chce rozvrhout.
6. Systém zobrazí uživateli formulář s volbou místnosti a časového slotu a možností rozvrhnout lístek opakovaně (možnosti: jednou za týden, 2 týdny, měsíc)
7. Uživatel zvolí místnost, do které chce cvičení/přednášku rozvrhnout.
8. Po zvolení místnosti načte systém z databáze časové sloty pro danou místnost a zobrazí je uživateli (s jasnou indikací které jsou volné a které ne).
9. Uživatel zvolí vyhovující slot(y) a opakování a odešle formulář.
10. Systém zpracuje odeslání formuláře.
    1. Systém ověří správnost hodnot formuláře.
    2. Systém ověří, že slot je opravdu volný. V případě, že se lístek překrývá vyžádá si od uživatele potvrzení.
    3. Systém uloží do databáze vytvořené rozvrhové lístky.

#### Requirements:

- Systém musí umět vyhledávat mezi cvičeními/přednáškami podle jejich kódu
a podle vlastností předmětu (kód, název, katedra, fakulta).
- Systém musí znát fakulty/katedry na škole.
- Systém musí držet seznam všech místností.
- Systém si musí pamatovat kde a kdy jsou rozvrh. lístky rozvrženy.
- Systém musí umět hledat v rozvrhových lístcích podle místnosti.
- Systém musí umět efektivně ověřit kolizi mezi rozvrhovými lístky.
- Systém musí umožnit variabilní délku rozvrhových lístků (např. po slotech)

### Jako rozvrhář chci, aby mě systém upozornil na kolize při plánování (stejný učitel/místnost ve stejný čas), abych předešel chybám.

#### Scénáře:

- Při vytváření nové rozvrhové akce: Rozvrhář se pokouší umístit novou přednášku do času a místnosti, které jsou již obsazené.
- Při změně existující akce: Rozvrhář přesouvá existující cvičení na čas, kdy má daný vyučující již naplánovanou jinou výuku.

#### Detailně:

1. Uživatel si v informačním systému (SIS) v modulu pro správu rozvrhů vybeere možnost vytvořit novou akci.
2. Uživatel vyplní potřebné údaje (předmět, vyučjící, místnost, čas).
3. Uživatel potvrdí volbu (např. kliknutím na tlačítko "Uložit").
4. Systém přijme požadavek na vytvoření rozvrhové akce.
5. Systém zpracuje požadavek.
    1. Systém ověří validitu zadaných dat (kontrola existence předmětu, vyučujícího, místnosti, ...). 
    2. Systém identifikuje klíčové zdroje náchylné ke kolizi: místnosti & učitele. 
    3. Systém načte z databáze všechny existující rozvrhové lístky, které se týkají daných zdrojů v požadovaném časovém intervalu. 
    4. Systém porovná časový slot nové akce se všemi nalezenými sloty v databázi a vyhodnotí, zda dochází ke kolizi.
6. Pokud systém detekuje kolizi:
    1. Systém neprovede uložení nové akce do databáze. 
    2. Systém vygeneruje přesnou zprávu o povaze kolize.
    3. Systém zobrazí rozvrháři v uživatelském rozhraní varování.
7. Pokud systém kolizi nedetekuje: 
    1. Systém uloží novou rozvrhovou akci do databáze. 
    2. Systém zobrazí rozvrháři potvrzení o úspěšném vytvoření akce.

#### Požadavky:

- Systém musí být schopen ověřit validitu zadaných dat.
- Systém si musí pamatovat a evidovat všechny existující rozvrhové lístky (čas, místnost, vyučující, ...).
- Systém musí umět porovnat časový slot jedné akce se sadou existujících akcí.
- Systém musí spolehlivě identifikovat překryvy pro více zdrojů najednou (místnost, osoba).
- Systém musí umět zabránit uložení akce, která způsobuje kolizi.
- Systém musí umožnit vynucené uložení kolidující akce pro uživatele s dostatečným oprávněním.
- Systém musí mít implementovaný mechanismus pro okamžitou zpětnou vazbu v uživatelském rozhraní.
- Systém musí být schopen v uživatelském rozhraní zobrazovat různé typy zpráv (potvrzení, varování, chyby) v reálném čase.

#### Dekompozice architektury

- Prezentace:
    - Editor rozvrhů:
       - Zobrazit formulář pro vytvoření/úpravu rozvrhové akce
       - Přijmout data zadaná uživatelem a odeslat ke zpracovaní
       - Zobrazit potvrzovací a varovné zprávy o kolizi
       - Poskytnout možnost vynuceného uložení
  
- Aplikační:
    - Služba pro správu rozvrhů:
       - Validovat vstupní data (existence předmětu, učitele, ...)
       - Rozhodnout o uložení/zamítnutí
    - Služba pro správu kolizí:
       - Identifikovat zdroje ke kontrole
       - Porovnat časové sloty a spolehlivě detekovat překryvy

- Perzistence:
    - Repozitář rozvrhů
       - Ukládat a načítat rozvrhové akce z databáze
    - Auditní logger
       - Zaznamenávat klíčové operace do logu (vytvoření akce, detekce kolize, vynucené uložení)
    - Notifikační služba
       - Generovat specifický text varovné zprávy o povaze kolize
       - Spustit odeslání notifikace do uživatelského rozhraní
  
#### Závislosti

1. Uživatel interaguje s komponentou `Editor rozvrhů`, kam zadá data pro novou rozvrhovou akci.
2. `Editor rozvrhů` odešle požadavek na vytvoření akce komponentě `Služba pro správu rozvrhů`.
3. `Služba pro správu rozvrhů` nejprve zvaliduje vstupní data a poté zavolá komponentu `Služba pro správu kolizí` a předá ji data o nové akci.
4. `Služba pro správu kolizí` si vyžádá od `Repozitář rozvrhů` všechny existující akce, které by mohly kolidovat.
5. Po provedení porovnání vrátí komponenta `Služba pro správu kolizí` výsledek (ANO/NE kolize) zpět komponentě `Služba pro správu kolizí`.
6. `Služba pro správu rozvrhů`:
    - Pokud nedošlo ke kolizi, zavolá `Repozitář rozvrhů`, aby novou akci uložil do databáze.
    - Pokud došlo ke kolizi, akci neuloží a připraví varovnou zprávu.
7. `Služba pro správu rozvrhů` v obou případech může zavolat `Audit logger` pro zaznamenání události.
8. `Služba pro správu rozvrhů` pošle finální odpověď (potvrzení o uložení nebo zprávu o kolizi) zpět do `Editor rozvrhů`, který ji zobrazí uživateli.


### + učitel chce smazat předmět PROTOŽE už nemá čas ho přednášet

#### Detailně:

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

#### Requirements:

- Systém musí umět vyhledávat mezi předměty podle jejich kódu, názvu a podle relace k vyhledávajícímu ("předmět, co garantuju").
- Systém musí umět uložit zmizení předmětu, odepsat studenty.


