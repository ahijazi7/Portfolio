/*
 * boundedBuffer.c
 *
 * A complete example of simple producer/consumer program. The Producer
 * and Consumer functions are executed as independent threads.  They
 * share access to a single buffer, data.  The producer deposits a sequence
 * of integers from 1 to numIters into the buffer.  The Consumer fetches
 * these values and adds them.  Two semaphores,empty and full are used to
 * ensure that the producer and consumer alternate access to the buffer.
 *
 * SOURCE: adapted from example code in "Multithreaded, Parallel, and
 *         Distributed Programming" by Gregory R. Andrews.
 */
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#define SHARED 1


void *Producer (void *); // the two threads
void *Consumer (void *);

sem_t empty, full, mutex;       //global semaphores
int data;                // shared buffer, size = 1
int numIters;
int *buffer;
int front = 0, rear = 0;
int size;


// main() -- read command line and create threads
int main(int argc, char *argv[]) {

    buffer = (int*)malloc(atoi(argv[2]) * sizeof(int));
    size = atoi(argv[2]);
    

    pthread_t pid, pid2, pid3, cid, cid2, cid3;
    sem_init(&empty, SHARED, atoi(argv[2]));    // sem empty = 1
    sem_init(&full, SHARED, 0);
    sem_init(&mutex, SHARED, 1); //sem full = 0
    if (argc < 2) {
    printf("Usage: boundedBuffer <Number of Iterations>\n");
    exit(0);
    }
    numIters = atoi(argv[1]);
    pthread_create(&pid, NULL, Producer, NULL); //creating 3 producer and 3 consumer threads
    pthread_create(&cid, NULL, Consumer, NULL);

    pthread_create(&pid2, NULL, Producer, NULL);
    pthread_create(&cid2, NULL, Consumer, NULL);

    pthread_create(&pid3, NULL, Producer, NULL);
    pthread_create(&cid3, NULL, Consumer, NULL);

    pthread_join(pid, NULL);
    pthread_join(cid, NULL);
    pthread_exit(0);
}
// deposit 1, ..., numIters into the data buffer
void *Producer(void *arg) {
    int produced;
    for (produced = 0; produced < numIters; produced++) { 
        sem_wait(&empty); //Two locks, one to check if empty and one to make sure that there is only one producer in at a time
        sem_wait(&mutex);
        buffer[rear] = produced;
        rear = (rear + 1) % size;
        sem_post(&mutex); //unlocking the locks
        sem_post(&full);
        
    }
}
//fetch numIters items from the buffer and sum them
void *Consumer(void *arg) {
    int total = 0;
    int consumed;
    for (consumed = 0; consumed < numIters; consumed++) {
        sem_wait(&full); //similar scenario here, two locks, one to check if full/empty and one to keep only one consumer in at a time
        sem_wait(&mutex);
        total = total + buffer[front];
        front = (front + 1) % size;
        sem_post(&mutex);
        sem_post(&empty);

    }
    printf("the total is %d\n", total);
}