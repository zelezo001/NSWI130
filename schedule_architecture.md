## Features - Use cases

#### Garant

1. Jako garant předmětu chci definovat požadavky na rozvrhnutí (např. preference časů a místnosti), aby rozvrhář mohl
   vytvořit kvalitní rozvrh.

#### Učitel

9. Jako učitel chci smazat předmět, protože už nemám čas ho přednášet.
10. Jako učitel chci vyrobit předět, protože nechci přednášet v prázdné místnosti.
11. Jako učitel chci upravit předět, protože něco napsal špatně.

#### Rozvrhář

2. Jako rozvrhář chci mít možnost rozvrhnout cvičení/přednášku a přiřadit jí místnost/čas abych mohl efektivně tvořit
   rozvrhy.
3. Jako rozvrhář chci interaktivně vidět volné sloty v rozvrhu (WIP) pro konkrétní místnost, učitele nebo studijní
   skupinu, abych mohl efektivně plánovat.
4. Jako rozvrhář chci, aby mě systém upozornil na kolize při plánování (stejný učitel/místnost ve stejný čas), abych
   předešel chybám.

#### Student

5. Jako student si chci vložit předmět do košíku, abych si mohl naplánovat semestr před oficiálním zápisem.

#### Manažer

6. Jako manažer fakulty chci zobrazit statistiky a reporty o úspěšnosti předmětů, abych mohl optimalizovat zdroje.

#### Společné

7. Jako student/učitel/host chci zobrazit existující rozvrh pro předmět, místnost, vyučujícího nebo svůj osobní rozvrh,
   neboť chci vidět příslušné rozvržené entity.
8. Jako student/učitel chci být automatcky notifikován o změně v mém rozvrhu (změna času, místnosti, zrušení hodiny).

12. Jako student/učitel chci exportovat rozvrh do osobního kalendáře, protože chci mít všechny budoucí události na
    jednom místě.

## Oblasti

- Definování požadavků a preferencí k rozvrhu (1)
- Vytvoření a úprava rozvrhu (2, 3, 4, 5, 8)
- Zobrazení rozvrhu (7, 12)
- Předměty (9, 10, 11)
- Statistiky a reporty (6)

## Detailní Features

- [Definování požadavků a preferencí k rozvrhu](features/garant_kriteria_predmetu.md)  
- [Detekce kolizí předmětu](features/rozvrhar_detekce_kolizi.md)  
- [Tvorba rozvrhu](features/rozvrhar_tvorba_rozvrhu.md)  
- [Tvorba předmětu](features/ucitel_tvorba_predmetu.md)  
- [Smazání předmětu](features/ucitel_predmet_smazani.md)
- [Zobrazení rozvrhu](features/uzivatel_zobrazeni_rozvrhu_predmetu.md)