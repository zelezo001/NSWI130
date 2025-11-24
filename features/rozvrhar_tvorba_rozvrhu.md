# Tvorba rozvrhu rozvrhářem

## User story
Jako rozvrhář chci mít možnost rozvrhnout cvičení/přednášku a přiřadit jí místnost/čas abych mohl efektivně tvořit rozvrhy.

## Interakce mezi uživatelem a systémem

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

## Responsibilities:

### Business
- Systém musí znát fakulty/katedry na škole.
- Systém musí umět rozvrhout do všech dostupných místností po škole v časech jejich dostupnosti.
- Systém musí umožnit variabilní délku rozvrhových lístků (např. po slotech).
- Systém musí umožnit rozvrhovat lístky na v každý den (včetně víkendů).

### Technické:
- Systém musí umět hledat v rozvrhových lístcích podle místnosti.
- Systém musí umět vyhledávat mezi cvičeními/přednáškami podle jejich kódu.
  a podle vlastností předmětu (kód, název, katedra, fakulta).
- Systém si musí pamatovat kde a kdy jsou rozvrhové lístky rozvrženy.
- Systém musí být schopný ověřit všechny vstupy uživatele.

### Kvalitativní:
- Systém musí umět uporoznit uživatele na kolizi mezi rozvrhovými lístky.
- Systém musí zvládnout rozvrhnutí velkého množství rozvrhových lístků.
- Systém musí být schopný efektivně a přehledně zaplněnost jedné místnosti po celý semestr.