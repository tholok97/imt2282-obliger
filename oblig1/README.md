# Oblig 1

## Kvalitetsikring

* Bruker (enkel) make-fil til å holde styr på automatiske kvalitetstester:
    * Kjører `gcc` med `-Wall` flagget
    * Kjører `clang-tidy` med alle checks på på all kode som skal igjennom kompilatoren.
* Fokus på å kommentere kode heller for mye eller for lite.
* **Task 4.5 b**: Kode som kan feile (`fork()` og `waitpid(..)`) er wrappet i funksjoner som gir samme funksjonalitet, men håndterer potensielle feil ved å avslutte programmet med en debug-melding.

## Hvordan validere kvalitetsikringen

Gjør `make task4_5b.out` og `make task5_6a_2.out`. Dette skal bygge out-filene til denne oppgavene. Kommandoen skal ikke generere noe warnings eller errors. Se `Makefile` for detaljer.

## Oppgave 4.5b i kompendiet

### Forklaring

Løser den veldig sekvensielt. Lagrer unna pid til original prosess så jeg kan være sikker på at bare én prosess forker nye prosesser. 

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

## Oppgave 5.6a i kompendiet

### Forklaring

Baserer meg på fila `thread-start-stop-semafor-hjelp1a.c` fra github-siden til emnet. Fortsetter i samme baner som denne fila hinter til.

## Oppgave 5.6b i kompendiet

### Forklaring

Baserer meg på fila `3-en-producer-consumer-mutex-og-condvar.c` fra github-siden til emnet. Fortsetter i samme baner som denne fila hinter til.
