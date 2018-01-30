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

// error fork. prøv å forke, men exit med feilmelding hvis feil oppstår
int efork() {
    int pid = fork();

    if (pid < 0) {
        printf("Error! Kunne ikke lage ny pid (returnerte %d)", pid);
        exit(1);
    }

    return pid;
}

void ewaitpid(int pid) {

    int status = -1;

    if (!WIFEXITED(&status)) {
        printf("Error! Kunne ikke waitpid på pid %d. Status: %d", pid, status);
        exit(1); 
    }
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

    // efork to ganger. lagre pidene i pid 0 og 2
    if (getpid() == originalpid) {
        pid0 = efork();
    }

    if (getpid() == originalpid) {
        pid2 = efork();
    }

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
        ewaitpid(pid0);

        // lag ny efork, pid1
        pid1 = efork();

        // gjør bare i original prosess:
        if (getpid() == originalpid) {

            // lag ny efork, pid4
            pid4 = efork();
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
        ewaitpid(pid2);

        // efork til pid3
        pid3 = efork();
    }

    // vis utskrift av pid3
    if (pid3 == 0) {
        process(3, 2);
    }

    // gjør bare for original prosess:
    if (getpid() == originalpid) {

        // vent på pid4
        ewaitpid(pid4);

        // efork til pid5
        pid5 = efork();
    }

    // vis utskrift av pid5
    if (getpid() == originalpid) {
        process(5, 3);
    }


    // vent til den siste tråden er ferdig
    if (getpid() == originalpid) {
        ewaitpid(pid5);
    }

    return 0;
}
