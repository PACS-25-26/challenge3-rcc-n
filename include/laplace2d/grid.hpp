#ifndef LAPLOCE2D_GRID_HPP
#define LAPLOCE2D_GRID_HPP

#include <vector>

/** 
 * @brief struct that represents the grid of the laplace 2d solver.
 * it uses row-major ordering to store the grid values in a 1D vector.
 */
 struct Grid {
    std::vector<double> grid; // 2D grid
    int rows; // number of rows
    int cols; // number of columns

    Grid(int r, int c) : rows(r), cols(c) {
        grid.resize(rows * cols, 0.0); // initialize grid with zeros
    }

    double& operator()(int i, int j) { return grid[i * cols + j]; }
    double  operator()(int i, int j) const { return grid[i * cols + j]; }
 };


#endif //LAPLACE2D_GRID_HPP