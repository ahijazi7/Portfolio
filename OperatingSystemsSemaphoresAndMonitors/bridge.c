#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

//One Lane Bridge Monitor Solution
bool isSafe(int direc, int id);
void ArriveBridge(int direc, int id);
 void ExitBridge(int direc, int id);
 void CrossBridge (int direc, int id);

void *OneVehicle(void *carID) {


    int id = (long) carID + 1;

	int direc = rand() % 2;
    ArriveBridge(direc, id); // executing methods sending in direction and id
    CrossBridge(direc, id);
    ExitBridge(direc, id);
}


    //creating locks, conditions, and array
    const int SIZE = 50;
    
    int currentDirec;
    int currentNumber = 0; 
    pthread_mutex_t mutex; 

    pthread_cond_t safe;


    int main(){

        pthread_t cars[SIZE];       // creating array for 50 cars, then creating the threads
        for(long i = 0; i<SIZE; i++){
            pthread_create(&cars[i], NULL, OneVehicle, (void*)i);
        }



        for(int x=0; x< SIZE; x++) { //joining the threads after
            
        pthread_join(cars[x], NULL);
    }

        pthread_exit(0);
    }

    void CrossBridge (int direc, int id) {
	//crossing the bridge;
    printf("car %d dir %d crossing the bridge. Current dir: %d  #cars: %d\n", id, direc, direc, currentNumber);
   
}


    void ArriveBridge(int direc, int id) {
        
        pthread_mutex_lock(&mutex); //mutex lock for one car at a time 
        printf("car %d dir %d arrives at bridge.\n", id, direc); 
        while (!isSafe(direc, id) ) //if not safe, thread sleep
            pthread_cond_wait(&safe, &mutex);


        // When safe, increment currentNumber of cars and set direction 
        currentNumber++; 
        currentDirec = direc;
        pthread_mutex_unlock(&mutex); //unlock mutex
        sched_yield();
    }

    void ExitBridge(int direc, int id) {
        pthread_mutex_lock(&mutex); //lock mutex
        printf("car %d dir %d exits the bridge.\n", id, direc);
        currentNumber--; //decrement number of current cars
     

        if(currentNumber == 0)
            pthread_cond_broadcast(&safe); //if there are zero cars, wake up all threads

        pthread_mutex_unlock(&mutex); //unlock

        sched_yield();

        
    }

    bool isSafe(int direc, int id) {
        if ( currentNumber == 0 )
            return true;    // always safe when bridge is empty
        else if ((currentNumber < 3) && (currentDirec == direc))
            return true;    // room for us to follow others in direc
        else
            return false;   // bridge is full or has oncoming traffic.

            
    

}

