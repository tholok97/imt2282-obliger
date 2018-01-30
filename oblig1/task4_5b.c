#include <stdio.h>      /* printf */
#include <stdlib.h>     /* exit */
#include <unistd.h>     /* fork */
#include <sys/wait.h>   /* waitpid */
#include <sys/types.h>  /* pid_t */


// Skriv ut number og sleep i time sekunder (simuler arbeid)
void process(int number, int time) {
    printf("Prosess %d kjører\n", number);
    sleep(time);
    printf("Prosess %d kjørte i %d sekunder\n", number, time);
}

int main(void) {

    // lagrer pid til original tråd
    pid_t originalpid = getpid();

    // variabel for piden til hver av trådene
    pid_t pid0, pid1, pid2, pid3, pid4, pid5;

    // fork frem de første trådene (BARE I ORIGINAL TRÅDEN)
    if (getpid() == originalpid) pid0 = fork();
    if (getpid() == originalpid) pid1 = fork();
    if (getpid() == originalpid) pid2 = fork();
    if (getpid() == originalpid) pid3 = fork();
    if (getpid() == originalpid) pid4 = fork();
    if (getpid() == originalpid) pid5 = fork();


    // Oppgavene hver av trådene skal gjøre. Tråd x vil gjøre arbiedet som står
    //  under pidx == 0. Bruker sleep på å vente på tur
    if (pid0 == 0) {
        process(0, 1);
    } else if (pid1 == 0) {
        sleep(1);
        process(1, 2);
    } else if (pid2 == 0) {
        process(2, 3);
    } else if (pid3 == 0) {
        sleep(3);
        process(3, 2);
    } else if (pid4 == 0) {
        sleep(1);
        process(4, 3);
    } else if (pid5 == 0) {
        sleep(4);
        process(5, 3);
    } else {
        sleep(7);
    }

    return 0;
}
