# Oblig 1

## Oppgave 4.5 i kompendiet

### Kvalitetsikring

* Bruker (enkel) make-fil til å holde styr på automatiske kvalitetstester:
    * Kjører gcc med -Wall flagget
    * Kjører clang-tidy med alle checks på all kode som skal igjennom kompilatoren.
* Fokus på å kommentere kode heller for mye eller for lite.
* Kode som kan feile (`fork()` og `waitpid(..)`) er wrappet i funksjoner som gir samme funksjonalitet, men håndterer potensielle feil ved å avslutte programmet med en debug-melding.

### Hvordan validere kvalitetsikringen

Gjør `make task4_5.out`. Dette skal bygge out-filen til denne oppgaven. Kommandoen skal ikke generere noe warnings eller errors. Se `Makefile` for detaljer.

### Forklaring

*TBA*

### Forventet utskrift

Prosesser på samme linje kjører i vilkårlig rekkefølge. (Skjer Samtidig).

```
Prosess 0 kjører
Prosess 2 kjører

Prosess 0 kjørte i 1 sekunder
Prosess 1 kjører
Prosess 4 kjører

Prosess 1 kjørte i 2 sekunder
Prosess 2 kjørte i 3 sekunder
Prosess 3 kjører

Prosess 4 kjørte i 3
Prosess 5 kjører

Prosess 3 kjørte i 2 sekunder

Prosess 5 kjørte i 3 sekunder
```
