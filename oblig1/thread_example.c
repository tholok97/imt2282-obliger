#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int NUMBER_OF_THREADS = 3;

void *print_hello_world(void *tid) {
    printf("Hello World. Greetings from thread %ld\n", (long int) tid);
    pthread_exit(NULL);
}

int main(void) {

    // the threads
    pthread_t threads[NUMBER_OF_THREADS];

    for (long int i=0; i < NUMBER_OF_THREADS; i++) {

        // Print as main
        printf("Main here. Creating thread %ld\n", i);

        // create new thread 
        int status = pthread_create(&threads[i], NULL, print_hello_world, (void *)i);

        // if status was bad -> indicate so
        if (status != 0) {
            printf("Oops. pthread create returned error code %d\n", status);
            exit(EXIT_FAILURE);
        }
    }

    // wait for all the threads
    for(int j=0;j<NUMBER_OF_THREADS;j++) {
        pthread_join(threads[j], NULL);
    }

    return 0;
}
