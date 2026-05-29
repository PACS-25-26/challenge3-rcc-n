#include <iostream>
#include <mpi.h>
#include "laplace2d/iteration.hpp"

int main(int argc, char** argv) {

    stampa(0); // Chiamata iniziale con rank 0


    MPI_Init(&argc, &argv);

    int rank; // L'ID del processo corrente (chi sono io?)
    int size; // Il numero totale di processi (quanti siamo in tutto?)

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    MPI_Comm_size(MPI_COMM_WORLD, &size);

    std::cout << "Hello World! Sono il processo " << rank << " di " << size << std::endl;
    
    MPI_Finalize();

    return 0;
}