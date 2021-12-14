# Cplusplus_Projects

Projects of the course of Object-Oriented Programming and C++ of the Bachelor's Degree in Physics of the University of Padua.
Professor. Paolo Ronchese

## particle_dump_v1

---- Read the text file "particle_events.txt" ----

The file contains a sequence of events, and for each event:

- an integer identifier,
- the 3 decay point coordinates
- the number of particles,
- for each particle the electric charge and the 3 momentum components

***
Create a function "read" taking as arguments:

- the reference to an input file stream,
- the reference to 3 floats to fill with the decay point coordinates,
- an array of integers to fill with electric charges,
- 3 arrays of float to fill with momenta components
and returning the number of particles.

***
Create a function "dump" taking as argument:

- the number of the event,
- the number of particles,
- 3 floats for the decay point coordinates,
- an array of integers containing electric charges,
- 3 arrays of float containing momenta components
and printing a dump on the screen.
Write on the screen only the numbers, do not add any text as "Event number:"
or "these are the particles:"; the output should be usable as input for
a following run of the program.

***
Create a "main" function taking the file name from the command string,
opening the file and calling the read and dump functions.
Dimension the arrays in the "main", using 10 as max number of particles.
For each event try to read the event identifier in the "main", and on
success call the "read" function to read the other data and then call
the "dump" function.

********* final list of functions *********

main                   to do

read                   to do

dump                   to do

## particle_dump_v2

---- Modify Dump_v1 and use structs ----

Create a "Particle" struct, with members corresponding to the data
for each particle (charge, 3 momentum components).
Create an "Event" struct, with members corresponding to the data
for each event (event identifier, 3 decay point coordinates,
number of particles, array of pointers to Particle structs, i.e. Particle**).

***
Use a dynamic array for the list of pointers to Particle; create
all the Particle structs dynamically, too.

***
Create a function "read" taking as argument an input file stream,
reading an event and returning a pointer to the event or zero
at the file end. Create the event dynamically.

***
Create a function "dump" taking as argument a reference to const-event
and printing a dump on the screen.
Write on the screen only the numbers, do not add any text as "Event number:"
or "these are the particles:"; the output should be usable as input for
a following run of the program.

***
Create a function "clear" deleting the event and its content, including
all the particles: first of all delete all the Particle structs, then
delete the array of the pointers and at last the Event struct.

***
Create a "main" function taking the file name from the command string,
reading the file and calling the dump and clear functions.

********* final list of functions *********

main                   to do

struct Event, Particle to do

read                   to do

clear                  to do

dump                   to do

## particleMean_v1

---- Modify Dump_v2 and compute mean and rms invariant mass ----

The file contains data corresponding to events with different decaying
particles (K0 and Lambda0), plus background events; signal events have
exactly two particles, one positive and one negative.
Compute mean and rms invariant mass selecting signal events with
invariant mass between 0.490 and 0.505 Gev/c^2.

The invariant mass rms is computed from the difference of very similar
numbers (square of sum and sum of squares), so the limited precision has
a non negligible effect. To solve this problems apply one or both of the
following:

- use double precision variables for mass sums, mean and rms, as well as
  for all calculations,
- subtract the min. invariant mass (i.e. 0.490) from the computed mass
  event by event, before updating the sums, and add it back to the mean
  after all the calculations.

Add four functions as described in the following.

***
Create two functions to compute energy or invariant mass from momentum
x,y,z components plus invariant mass or energy, respectively.
Both functions take 4 arguments: the first one takes the 3 momentum
components plus the invariant mass and returns the energy, the second
one takes the 3 momentum components plus the energy and returns the
invariant mass.

***
Create a "mass" function taking as argument a reference to const-Event
and returning the invariant mass of the decaying particle.
Use the following variables:

- 2   int variables to count negative and positive particles,
- 3 float variables for the 3 sums of the momentum components,
- 2 float variables for the total energy sums, for the hypotheses of a
  decaying K0 or Lambda0,
- 2 float variables for the invariant masses, for the hypotheses of a
  decaying K0 or Lambda0.
Use a typedef to declare pointers to const-Particle structs.
Loop over the particles, and for each one:
- increase the corresponding counter, according to charge,
- increase the 3 momentum components sum,
- compute particle energy for the hypothesis of a decaying K0,
  using the function described above and giving as arguments the 3 momentum
  components and the pion mass,
- compute particle energy for the hypothesis of a decaying Lambda0,
  using the function described above and giving as arguments the 3 momentum
  components and the pion mass for a negative particle or proton mass
  for a positive particle,
- update the total energy sum for both the K0 and Lambda0 hypotheses.

Check the number of positive and negative particles, and return a
negative (unphysical) value if one of the two is different than one.
Compute the invariant mass for both the K0 and Lambda0 hypotheses, and
compute the difference of each one with the known mass of the K0 or Lambda0
respectively. Return the invariant mass for which the corresponding
difference is the smallest.

***
Create a function "add" taking as arguments:

- a reference to const-Event,
- two float for min and max invariant mass
- two references to double for the sum of invariant masses
  and the the sum of squares,

Inside the function compute the invariant mass of the decay particle,
using the "mass" function described above.

If the mass is comprised between the minimum and maximum increase the sums
of masses and squares, otherwise leave those sums unchanged.
Return true or false if the mass was in the range or not, respectively.
If you chose to subtract the min. mass event by event, use the same
parameter used to select events inside the mass range.

***
Modify the main function as follows.
Add 5 variables:

- one to contain the number of accepted events,
- one to contain the sum of invariant masses,
- one to contain the sum of squares of invariant masses,
- one to contain the mean invariant mass,
- one to contain the rms  invariant mass.

In the event loop call the "add" function, using 0.490 and 0.505 as
min and max invariant mass; disable the call to the "dump" function
with "//", if you prefer.

Compute the number of events by increasing the counter according to
the return value of the "add" function.

Compute mean and rms mass from the sum of masses and squares and
print the results on the screen.

********* final list of files/functions *********

main                   modify Dump_v2

struct Event           copy   Dump_v2

read                   copy   Dump_v2

clear                  copy   Dump_v2

dump                   copy   Dump_v2

mass                   to complete

add                    to do

## particleMean_v2

---- Modify Mean_v1 and introduce classes ----

Replace the struct "Event" with a class "Event" and 
the function "add" with a class "MassMean", as described in the following.

The invariant mass rms is computed from the difference of very similar
numbers, so the limited precision has a non negligible effect. To solve
this problems apply one or both of the suggestions given for particleMean_v1.

***
Create a class "Event" with the same members as the previous struct "Event":
declare those memebers private. Include an additional const private member,
to contain the maximum number of particles (10).
Add to the class:

- a constructor taking as parameters the event-id and the decay point
  coordinates,
- a destructor,
- a function "add" to append a particle to the event, taking as argument
  the 3 momentum components and the charge,
- 4 functions "eventNumber", "x", "y", "z" returning the event number and
  the 3 decay point coordinates,
- a function "nParticles" returning the number of particles,
- a function "particle" taking an int as argument and returning the pointer 
  to the corresponding particle, if existing, or a null pointer if the
  particle does not exist (i.e. when the argument is bigger than the number
  of particles).

Declare "const" the functions returning event data
("eventNumber", "x", "y", "z").

Create and delete the array of pointers to the particles in the constructor
and destructor, using the maximum number of particles as size; in the
destructor delete all the particles too, before deleting the array.
In the function "add" check if the max number of particles has been reached, 
if not append the new particle and increase the number of particles.

***
Modify the "read" function, to use the new functions in the "Event" class:

- pass the event number and the decay point coordinates to the constructor,
- call the "add" function in the loop reading particles.

***
Remove the "clear" function.

***
Modify the "dump" functions to access event data through the "Event" class
functions.

***
Create a Utilities class, and move inside this new class the two functions
computing the energy or the mass from the 3 momentum components and the
mass or the energy, respectively. Declare those functions as "static".

***
Create a Constants class and move inside this new class the masses of
pion, proton, K0 and Lambda0. Initialize those values properly.

***
Modify the "mass" function to:

- access event data through the "Event" class functions,
- use the functions and values in the "Utilities" and "Constants" classes. 

***
Create a class "MassMean" with the following private members:

- two numbers for min and max invariant mass,
- the number of selected events,
- two numbers for sum of masses and sum of squares,
- two numbers for mean and rms.

Add to the class:

- a constructor taking the min and max invariant mass as parameters,
- a destructor,
- a function "add" taking as argument a reference to const-Event,
  to update the sum of masses and squares
- a function "compute" to compute mean and rms,
- a function "nEvents" returning the number of selected events,
- two functions "mMean" and "mRMS" returning the mean and rms.

Initialize all the variables in the costructor.
In the function "add" compute the invariant mass calling the "mass" function, 
check if the result is in the required range, if yes increase the event
counter and the sums, otherwise do nothing.
Declare "const" the functions returning results (number of selected events,
mean and rms ).
If you chose to subtract the min. mass event by event, use the same
parameter used to select events inside the mass range.

***
In the "main" function create 2 instances of "MassMean", to select 
events with invariant mass in the ranges:

K0      : min = 0.490 , max = 0.505

Lambda0 : min = 1.114 , max = 1.118

In the event loop call the function "add" for both instances and replace the 
call to the "clear" function with a call to the operator "delete"; at the end 
call the function "compute" and print the results for both instances as well.

********* final list of functions *********

main                   to complete

read                   modify Mean_v1

dump                   modify Mean_v1

mass                   modify Mean_v1

********* final list of classes   *********

                       .h                            .cc
Event                  to complete                   to complete

MassMean               to complete                   to complete

Constants              to do                         to do

Utilities              to do                         to do

## particleMean_v3


---- Modificare Mean_v2 e usare STL ----

Sostituire gli array nativi con "vectors" STL nella classe "Event",
come destritto nel seguente.

***
Modificare la classe "Event":

- Sostituire l'array di pointers con un std::vector ,
- rimuovere il numero di particelle, corrispondenti alla dimensione del vector,
- rimuovere il numero massimo di particelle,
- modificare la funzione membro per usare il vettore al posto dell'array nativo.
Nel costruttore riservare per il vector un numero di elementi uguale a 10.

***
Modificare la funzione "main" per usare una std::string per l'input del nome del file.

********* final list of functions *********

main                   modify Mean_v2

read                   copy   Mean_v2

dump                   copy   Mean_v2

mass                   copy   Mean_v2

********* final list of classes   *********

                       .h                            .cc

Event                  modify Mean_v2                modify Mean_v2

MassMean               copy   Mean_v2                copy   Mean_v2

Constants              copy   Mean_v2                copy   Mean_v2

Utilities              copy   Mean_v2                copy   Mean_v2

## particleMean_v4

---- Modificare Mean_v3 e usare le interfacce per event read e process ----

Sostituire le funzioni globali "read" e "dump" per usare classi con
interfacce astratte, come descritto come segue.
L'esecuzione del comando dovrebbe essere

execName input fileName
or
execName sim numberOfEvents [seedNumber]

***
Prendere i seguenti file dall'esempio "braggMean_v4":

- AnalysisSteering.h ,
- AnalysisSteering.cc ,
- EventSource.h ,
- EventSource.cc ,
- EventReadFromFile.h ,
- EventDump.h .
Tutti questi file possono essere usati senza modifiche

***
Creare i file seguenti copiando i corrispondenti da
"braggMean_v4" e cambiando le funzioni "readFile" e "process",
rispettivamente:

- EventReadFromFile.cc ,
- EventDump.cc .
In EventReadFromFile.cc includere nella funzione "readFile" il codice che
era precedentemente nella funzione "read",
In EventDump.cc includere nella funzione "process" il codice 
precedentemente nella funzione "dump".

***
Creare una classe "ParticleMass", ereditando da "AnalysisSteering" e
contentente un STL array di puntatori a oggetti "MassMean"; usare come
esempio la classe "ElementReco" in "braggMean_v4".
Includere tra i membri privati un "std::vector pList" di puntatori
a oggetti MassMean (al posto del "bCurve" vector in "ElementReco").
Implementare le funzioni:

- "beginJob" per creare e immagazzinare i pointer a 2 oggetti "MassMean"
  per due modi di decadimento, usando gli stessi range di massa come le 
  precedenti verioni (nello stesso modo come i pointer a "BraggMean" sono 
  immagazzinati in "bCurve"),
- in "endJob" fare un loop sugli oggetti "MassMean" e per ognuno calcolare
  media e rms delle masse e stampare il risultato (nello stesso modo con 
  cui viene fatto nel loop sugli oggetti "BraggMean" per calcolare e 
  stampare i risultati),
- in "process" fare un loop sugli oggetti "MassMean" e per ognuno chiamare
  la funzione "add" (nello stesso modo con cui viene aggiunto ogni evento
  a tutti gli oggetti "BraggMean").

***
Modificare la fuzione "main" per usare le classi modificate usando il file
"main.cc" dall'esempio "braggMean_v4" come referenza (cambiare gli 
analizzatori: "ParticleMass" al posto di "ElementReco").
Per simulare gli eventi usare la classe "EventSim".

********* lista finale di funzElementRecoioni *********

main                   modify braggMean_v4
mass                   copy   Mean_v3

********* lista finale di classi   *********

                       .h                            .cc

Event                  copy   Mean_v3                copy   Mean_v3

EventReadFromFile      copy   braggMean_v4           to do

EventSim               done                          done

AnalysisSteering       copy   braggMean_v4           copy   braggMean_v4

EventSource            copy   braggMean_v4           copy   braggMean_v4

MassMean               copy   Mean_v3                copy   Mean_v3

ParticleMass           to do                         to do

EventDump              copy   braggMean_v4           to do

Constants              copy   Mean_v3                copy   Mean_v3

Utilities              copy   Mean_v3                copy   Mean_v3

EventReadFromFile è classe derivata di EventSource, quindi il distruttore
è virtual. Stessa cosa vale per EventSim.

EventDump è derivata da AnalysisSteering. Cosi come ParticleMass