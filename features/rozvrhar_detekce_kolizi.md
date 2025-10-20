# Jako rozvrhář chci, aby mě systém upozornil na kolize při plánování (stejný učitel/místnost ve stejný čas), abych předešel chybám.

## Scénáře:

- Při vytváření nové rozvrhové akce: Rozvrhář se pokouší umístit novou přednášku do času a místnosti, které jsou již obsazené.
- Při změně existující akce: Rozvrhář přesouvá existující cvičení na čas, kdy má daný vyučující již naplánovanou jinou výuku.

## Detailně:

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

## Požadavky:

- Systém musí být schopen ověřit validitu zadaných dat.
- Systém si musí pamatovat a evidovat všechny existující rozvrhové lístky (čas, místnost, vyučující, ...).
- Systém musí umět porovnat časový slot jedné akce se sadou existujících akcí.
- Systém musí spolehlivě identifikovat překryvy pro více zdrojů najednou (místnost, osoba).
- Systém musí umět zabránit uložení akce, která způsobuje kolizi.
- Systém musí umožnit vynucené uložení kolidující akce pro uživatele s dostatečným oprávněním.
- Systém musí mít implementovaný mechanismus pro okamžitou zpětnou vazbu v uživatelském rozhraní.
- Systém musí být schopen v uživatelském rozhraní zobrazovat různé typy zpráv (potvrzení, varování, chyby) v reálném čase.

## Dekompozice architektury

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

## Závislosti

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
