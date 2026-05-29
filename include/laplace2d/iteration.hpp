#ifndef LAPLACE2D_ITERATION_HPP
#define LAPLACE2D_ITERATION_HPP

#include "grid.hpp"
#include "boundary_condition.hpp"

#include <iostream>
void stampa(int world_rank) {
    std::cout << "world rank " << world_rank << std::endl;
} 

#endif //LAPLACE2D_ITERATION_HPP