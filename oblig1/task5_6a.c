#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// struct for parameter passed to process
struct ProcessParams {
    int number;
    int time;
};

// Print number and sleep for time seconds (simulates work)
void* process(void* p) {

    // cast params
    struct ProcessParams* params = p;

    // do stuff
    printf("Prosess %d kjører\n", params->number);
    sleep(params->time);
    printf("Prosess %d kjørte i %d sekunder\n", params->number, params->time);

    // kill thread
    pthread_exit(NULL);
}

// wrapper around thread creation. Creates thread and starts it off with the 
// 'process' function as a job
void startThread(int number, int time, pthread_t* thread) {

    // prepare the arguments to send with thread
    struct ProcessParams* params = 
        (struct ProcessParams*) malloc(sizeof(struct ProcessParams));

    params->number = number;
    params->time = time;

    // start thread
    int status = pthread_create(&*thread, NULL, process, params);

    // if something went wrong -> print and exit
    if (status != 0) {
        printf("Oops. pthread create returned error code %d\n", status);
        exit(EXIT_FAILURE);
    }
}

int main(void) {

    const int NUM_THREADS = 6;

    pthread_t threads[NUM_THREADS];

    // start all threads with some test jobs
    for (int i = 0; i < NUM_THREADS; ++i) {
        startThread(i, i, &threads[i]);
    }

    // wait for all the threads to finish
    for (int i = 0; i < NUM_THREADS; ++i) {
        pthread_join(threads[i], NULL);
    }
}
