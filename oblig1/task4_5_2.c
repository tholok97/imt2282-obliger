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

    // lagre pid til original prosess. Brukes senere til å garantere at bare 
    //  denne tråden utfører visse oppgaver
    int originalpid = getpid();

    // klargjør pid variabler
    int pid0 = -1;
    int pid1 = -1;
    int pid2 = -1;
    int pid3 = -1;
    int pid4 = -1;
    int pid5 = -1;

    // fork to ganger. lagre pidene i pid 0 og 2
    if (getpid() == originalpid) pid0 = fork();
    if (getpid() == originalpid) pid2 = fork();

    // vis utskrift av pid0
    if (pid0 == 0) {
        process(0, 1);
    }

    // vis utskrift av pid2
    if (pid2 == 0) {
        process(2, 3);
    }

    // Gjør bare i original prosess:
    if (getpid() == originalpid) {

        // vent på pid0
        waitpid(pid0, NULL, 0); 

        // lag ny fork, pid1
        pid1 = fork();

        // gjør bare i original prosess:
        if (getpid() == originalpid) {

            // lag ny fork, pid4
            pid4 = fork();
        }
    }

    // vis utskrift av pid1
    if (pid1 == 0) {
        process(1, 2);
    }

    // vis utskrift av pid4
    if (pid4 == 0) {
        process(4, 3);
    }

    // Gjør bare for original prosess:
    if (getpid() == originalpid) {

        // vent på pid2
        waitpid(pid2, NULL, 0);

        // fork til pid3
        pid3 = fork();
    }

    // vis utskrift av pid3
    if (pid3 == 0) {
        process(3, 2);
    }

    // gjør bare for original prosess:
    if (getpid() == originalpid) {

        // vent på pid4
        waitpid(pid4, NULL, 0);

        // vis utskrift for pid5
        process(5, 3);
    }

    return 0;
}
