### Modify Mean_v2 and use STL

Replace native arrays with STL `vectors` in the class `Event`,
as described in the following.


Modify the class `Event`:
- replace the array of pointers with a `std::vector` ,
- remove the number of particles, corresponding to the size of the vector,
- remove the maximum number of particles,
- modify the member functions to use the vector in place of the native array.
In the constructor reserve for the vector a number of elements equal to 10.


Modify the `main` function to use a `std::string` for the input file name.
