# Zruseni a uprava zapisu

1. Student/studijni se prihlasi do informacniho systemu
2. Student/studijni otevre modul zapisu, ktery obsahuje prehled predmetu
3. System zobraci seznam aktualne zapsanych predmetu
4. Student/studijni vybere predmet, ktery chce zrusit nebo upravit
5. Student zvoli akci
   - Zrusit zapis (pokracuj na krok 6)
   - Upravit zapis (system zobrazi alternativni rozvrhove listky pro predmet)
6. System zkontroluje opravneni
   - Pokud je student, zkontroluje se zda je v zapisovem obdobi
   - Pokud je studijni, nema zadne omezeni
7. Pokud je kontrola uspesna, system zobrazi potvrzovaci okno s detaily predmetu/vyber alternativnich listku
8. Student/studijni potvrdi zruseni zapisu
9. Pro **zruseni**:
   - System uvolni kapacitu v rozvrhovych listcich
   - System zkontroluje, zda existuje fronta pro dany listek
   - System automaticky zapise prvniho studenta z fronty (pokud fronta existuje)
   - System odesle notifikaci studentovi ze fronty
10. Pro **upravu**:
    - System zkontroluje kapacitu nove vybranych listku
    - Pokud je volno, system uvolni puvodni listky a zapise studenta na nove
    - Pokud neni, zaradi studenta do fronty
    - System zpracuje frontu (krok 9)
11. System zaznamena zruseni/upravu zapisu do logu/historie/whatever
12. System zobrazi potvrzeni o uspesnem zruseni/uprave zapisu

## Responsibilities

### Authorization and validation responsibility

- Overit identitu a opravneni uzivatele
- Kontrola casoveho okna (pro studenty)
- Validace existence predmetu a zapisu

### Data retrieval responsibility

- Nacteni seznamu zapsanych predmetu (modul Predmety?)
- Ziskat informace o rozvrhovych listcich (a kapacitach) daneho predmetu
- Ziskat informace o fronte (pokud existuje)

### Capacity management responsibility

- Uvolnit kapacitu v rozvrhovych listcich
- Aktualizovat pocet volnych mist na listku
- Spravne aktualizovat frontu (pokud je)

### Queue processing responsibility

- Exituje u listku fronta?
- Vzit prvniho studenta z fronty
- Automaticky zapsat studenta z fronty (pokud je misto) a odepsat z ekvivalentniho listku
- Odebrat studenta z fronty po uspesnem zapisu

### Notification responsibility

- Notifikovat studenta o uspesnem zruseni zapisu
- Notifikovat studenta z fronty, ktery byl prepsan
- Logging

### Data persistence responsibilities

- Odstranit zaznam o zapisu studenta na predmet z DB
- Ulozit historii o zruseni zapisu

### User interface responsibility

- Zobrazit seznam zapsanych predmetu (pokud mozno prehledne, ehm ehm)
- Vyber zapisu predmetu/vice predmetu pro zruseni
- Potvrzovaci dialogy
- Chybove hlasky
- Aktualizace UI po zruseni zapisu

### Error handling responsibility

- Kdyz predmet neni zapsany, vyhod chybu
- Kdyz neni kapacita, kric
- Chyby pri zpracovani fronty
- Potencialni rollback? (asi ne, ale kdo vi)

### Data consistency responsibility

- Pokud se chce student odepsat ze cvika, musi se odepsat i z prednasky

### Alternative offer responsibility

- Pri plne kapacite listku nabidnout alternativy (pokud existuji)
- Seradit podle vhodnosti (cas, kolize, apod.)
- Zobrazit pocet volnych mist/fronta
