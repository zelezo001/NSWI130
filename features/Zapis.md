# Zapis studentu do predmetu

1. Student se prihlasi do informacniho systemu  
2. Student otevre modul zapisu
3. Studentovi se zobrazi rozhrani ve kterem vyhleda predmet, ktery si mini zapsat podle kodu, nazvu, atd. 
    - System se pta rozvrhoveho modulu na informace o predmetech
4. Zapisovy modul zobrazi seznam predmetu, ktere odpovidaji popisu
5. Student vybere pozadovany predmet
6. Studentovi se zobrazi konkretni listky pro obdobi zapisu
    - System se opet pta rozvrhoveho modulu na informace pro konkretni predmet
7. Student vybira prednasku (+ optional cviceni) a potvrdi zapis. Pokud je vynuceno u predmetu zapsat prednasku i cviceni, student zaklikne listek prednasky a listek cviceni, teprve potom je mu umozneno potvrdit zapis.
8. Kontroluje se kapacita zvolenych listku
    - Informace zjistujeme z interniho modulu, ktery udrzuje udaje o aktualnich kapacitach
9. Pokud fronty nejsou, student dostane hlaseni o uspesnem zapisu. V opacnem pripade je student zarazen do cekaci fronty.
    - System nabidne alternativni rozvrhove listky (s volnou kapacitou) pro tento predmet - v pripade ze cviceni je nutne s prednaskou, student si z alternativ **musi** vybrat, do te doby neni potvrzen zapis.


