# Cplusplus_Projects

Object-Oriented Programming and C++ course A.Y. 2019/2020.

Prof. Paolo Ronchese

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

EventReadFromFile è classe derivata di EventSource, quindi il distruttore
è virtual. Stessa cosa vale per EventSim.

EventDump è derivata da AnalysisSteering. Cosi come ParticleMass

## particleHist_v1


----  Leggi il file di testo "particle_events.txt"  ----

Il file contiene una sequenza di eventi e per ciascun evento:

- un intero per identificare l'evento,
- le 3 coordinate del punto di decadimento,
- il numero delle particelle
- per ogni particella la carica elettrica e le 3 componenti del momento.

***
Creare un funzione "read" che prende come argomenti:

- la referenza a un input file stream,
- la referenza a 3 floats da riempire con le coordinate del punto di decadimento,
- un array di interi da riempire con le cariche elettriche,
- 3 array di float da riempire con le componenti del momento
e che restituisce il numero delle particelle.

***
Creare una funzione "dump" che prende come argomenti:

- il numero di eventi,
- il numero di particelle,
- 3 float per le coordinate del punto di decadimento,
- un array di interi contente le cariche elettriche,
- 3 array di float contenti le componenti del momento angolare
e stampare un dump sullo schermo.
Scrivere sullo schermo solo i numeri, non aggiungere nessun testo come "Event number:"
o "queste sono le particelle:"; l'output dovrebbe essere usare come input per
un successivo run del programma.

***

Creare una funzione "main" che prende il nome del file dalla 
stringa di comando, apre il file e chiama le funzioni read e dump.
Dimensionare gli array nel main, usando 10 come numero massimo di particelle.
Per ogni evento provare a leggere il numero identificativo dell'evento nel main, 
e in caso di successo chiamare la funzione "read" per leggere gli alti dati 
e poi chiamare la funzione "dump".

## particleHist_v2

---- Modificare Hist_v1 e usare un factory per creare data source ----

Usare "SourceFactory" per creare l'"EventSource".
Il comando di esecuzione dovrebbe essere:

execName input fileName
or
execName sim numberOfEvents [seed seedNumber]

***
Prendere i file seguenti  dall'esempio "braggPlot_v2":
AnalysisInfo.h
AnalysisInfo.cc
SourceFactory.h
SourceFactory.cc
Tutti questi file possono essere usati senza modifiche.

***
Modificare "main.cc" prendendo "braggPlot_v2" come referenza:

- creare un oggetto "AnalysisInfo" e usarlo per contenere i parametri
  della linea di comando 
- rimuovere il codice per creare l'"EventSource" e usare una 
  SourceFactory" al suo posto
- rimuovere gli header files non necessari

## particleHist_v3

---- Modify Hist_v2 and use a factory to create data analyzers ----

***
Take the following from "braggPlot_v3":

- the new versions of "AnalysisSteering.h,cc"
  (and look at the differences with the v2 version),
- "AnalysisFactory.h,cc".

***
Modify "EventDump.h,cc" and "ParticleMass.h,cc" taking "braggPlot_v3" as 
reference:

- add an "AnalysisInfo*" as parameter to the constructor, and use it to 
  initialize the "AnalysisSteering" base,
- add a concrete Factory class and object, as in braggPlot_v3,
- get from the "AnalysisInfo" object the name of the output ROOT file
  (only for "ParticleMass.cc")

***
Modify the "main" function to use "AnalysisFactory".

## particleHist_v4

---- Modificare Hist_v3 e usare dispatcher&observers per fare un ciclo sugli eventi ----

**** Parte A ****

***
Scaricare i pacchetti "Utilities" e istallarli da qualche parte, quindi
aggiungere il percorso corrispondente nella compilazione:
cd ..../corsocxx
tar -xzf util.tgz
c++ -I ..../corsocxx

***
In "AnalysisSteering.h" rimuovere la dichiarazione della funzione process.

***
In "EventDump.h,cc" e "ParticleMass.h,cc":

- includere l'header dell'Observer:
#include "util/include/ActiveObserver.h"
- ereditare da "ActiveObserver<Event>" in aggiunta alla base esistente,
- rinominare la funzione "process" in "update".

***
In "EventSource.h,cc":

- dichiarare la funzione "get" come "private",
- dichiarare e implementare un funzione "public" "run",
- spostare il ciclo sugli eventi dalla funzione "main" alla nuova funzione
  "run" e usare "Dispatcher<Event>::notify" nel ciclo sugli eventi.

***
Creare una classe "ParticleReco" per calcolare l'energia totale e la massa invariante:

- dichiararla per ereditare dal template "Singleton" nella cartella util,
- dichiararla per ereditare dal template "LazyObserver",
- dichiarare 3 variabili membro private per le proprietà del decadimento
    tipo di decadimento (un enum),
    energia totale,
    massa invariante,
- calcolare queste variabili nella funzione "update", usare il codice 
  precedentemente nella funzione globale "mass",
- dichiarare e implementare funzioni per verificare i nuovi eventi e 
  restituire le proprietà del decadimento.

***
In "MassMean.cc" e "ParticleMass.cc" prendere la massa invariante da
"ParticleReco" prendendo la sua istanza e chiamare la funzione che
restituisce la massa invariante.

***
In "ParticleMass.cc" chiamare l'istogramma come "mass" seguito dal nome
dato al primo parametro nella funzione "pCreate".

***
Modificare la funzione "main" e sostituire il ciclo sugli eventi con una
chiamata alla funzione "run" in "EventSource".

**** Part B ****

***
Aggiungere una nuova quantità "lightVelocity" in Constants.h,cc e settarla
come 0.029979246 cm/ps

***
Duplicare le classi seguenti:
ParticleReco -> ProperTime
MassMean     -> LifetimeFit
ParticleMass -> ParticleLifetime
Questo può essere fatto facilmente usando il comando
..../util/class/cloneClass XXX YYY
dove XXX è la classe esistente (e.g. ParticleReco)
and  YYY è la classe nuova     (e.g. ProperTime)

***
In "ProperTime.h" dichiarare una variabile membro "time" e una funzione
"decayTime" che la restituisce dopo aver verificato il nuovo evento.
In "ProperTime.cc" nella funzione "update" calcolare il tempo di decadimento
proprio dalla distanza "d" del punto di decadimento dall'origine usando la 
formula                   t = d*m/(p*c)
dove "m" è la massa invariante, "c" è la velocità della luce e "p" il momento
dato a sua volta da       p = sqrt(e^2-m^2)
dove "e" è l'energia totale; trovare la massa invriante e l'energia totale
da "ParticleReco".

***
In "LifetimeFit.h" dichiarare le stesse variabili membro e funzioni come in
"MassMean", ma rimuovere le variabili membro che tengono somme, media e rms
e le funzioni che le restituiscono; lasciare le variabile membro per tenere
il minimo e massimo della massa e il numero di eventi più la funzione che
restituisce l'ultimo numero.
In "LifetimeFit.cc" nella funzione "add" semplicemente controllare se la massa
invariante è all'interno del range e aggiornare il numero di eventi accettati
in accordo; la funzione "compute" può essere lasciata vuota.

***
In "ParticleLifetime.h" sostituire il pointer a "MassMean" con un pointer
a "LifetimeFit" nella struttura "Particle" e aggiungere due parametri 
aggiuntivi "timeMin" e "timeMax" per la funzione "pCreate", per i tempi 
propri di decadimento minimo e massimo.
In "ParticleLifetime.cc" nella funzione "beginJob" chiamare "pCreate" con
gli stessi argomenti come in "ParticleMass", più il tempo minimo e massimo
(usare come range 10.0-500.0 e 10-1000.0); nella funzione "endJob" lasciare
le stesse operazioni come in "ParticleMass" tranne le scritture di media e
rms (lasciare la chiamata alla funzione "compute", che non fa nulla per ora,
sarà implementata nella prossima versione); prendere dall'oggetto
"AnalysisInfo" il nome del file ROOT di output.
Nella funzione "pCreate" chiamare l'istogramma come "time" seguito dal nome
dato come primo parametro nella funzione "pCreate" e usaer il minimo e il
massimo tempo di decadimento come range.
Nella funzione "update" chiamare la funzione "add" dell'oggetto "LifetimeFit",
e riempire l'istogramma in accordo con il risultato (usare la stessa logica
usata in "ParticleMass").

**** opzionale ****

Salvare gli istogrammi per la massa e per il tempo di decadimento nello stesso
file ROOT; usare un TFileProxy (nel pacchetto "util") per gestire accessi
multipli agli stessi file ROOT nella stessa esecuzione.

## particleHist_v5

---- Modify Hist_v4 and use dispatcher&observers to handle begin/end job ----

**** Part A ****

***
Use the "Utilities" package already downloaded in version 4

***
In "AnalysisSteering.h" remove the "process" function declaration.

***
Take the following from braggPlot_v5 (and look at the differences with 
the v4 version):

- the new version of "AnalysisInfo.h",  aggiunto enum AnalysisStatus { begin, end };
- the new version of "AnalysisSteering.h,cc", aggiunto la funzione update
- the new version of "main.cc".

***
In the "main" program handle begin/end job by dispatching
"AnalysisInfo::begin" or "AnalysisInfo::end" enums.

**** Part B ****

***
In "ParticleMass.cc":

- read the mass ranges from a text file ("massRanges") taking 
  the name from the command line through "AnalysisInfo" and allowing for
  different numbers of ranges

*** Include lifetim max. likelihood fit ***

In "LifetimeFit.h":

- add the following private members:

  - min and max time range (2 doubles),
  - min and max scan range (2 doubles),
  - scan step (1 double),
  - a container for all the decay times (1 std::vector<double>),
  - particle mean lifetime and error (2 doubles),

- remove the number of accepted events,
- add 5 parameters to the constructors for min. and max. time,
  min. and max. scan, scan step,
- add 2 functions "lifeTime" and "lifeTimeError" to return the mean lifetime
  and error.

In "LifetimeFit.cc":

- in the "add" function get the decay time from "ProperTime" and,
  if it's inside the min-max range, save it in the std::vector of all the
  decay times,
- in the functions "lifeTime" and "lifeTimeError" return the mean lifetime
  and error (their value is to be set in the "compute" function)
- in the "nEvents" function return the number of entries in the
  std::vector of all the decay times,
- in the "compute" function perform a max. likelihood fit to the lifetime,
  as described in the following.

The mean lifetime is estimated as the value "t" that minimizes the function:
L(t) = S_i=1^N ( (t_i/t) + log(t) + log( exp(-t_min/t) - exp(-t_max/t) ) )
where t_min and t_max are the min. and max. decay times accepted in the
analysis.

The minimum can be found performing a scan for "t" in the range [s_min,s_max],
fitting the L(t) function with a parabola L=a+bt+ct^2 and getting the
minimum as t=-b/2c . The error correspond to the range where L(t) is smaller
than Lmin+0.5 and can be computed as S(t)=1/sqrt(2c) .
The scan and fit can be performed using the "QuadraticFitter" class,
provided in the package.

So, in the "compute" function, do the following:

- instantiate a QuadraticFitter object,
- do a scan for t_s in [s_min,s_max] with steps t_step,
- for each value of t_s compute L(t_s), that implies a nested loop 
  over all the elements of the std::vector of all the decay times,
- call the "add" function giving as parameters t_s and L(t_s)
Then get mean lifetime and error using the formula given above, 
getting a, b and c from the functions "a", "b" and "c" of "QuadraticFitter".
 
***
In "ParticleLifetime.h,cc"

- get the mass and time ranges plus the fit parameters from text file 
  ("particleFitters"), and change the parameters of the "pCreate" function
  to handle the increased number of parameters needed by the LifetimeFit 
  constructor.


## particleHist_v6

---- Modify Hist_v5 and organize source files in packages ----

***
Create 4 directories

- AnalysisFramework
- AnalysisUtilities
- AnalysisObjects
- AnalysisPlugins

***
Move all the source files to those directories:

- to AnalysisFramework:
  - main.cc
  - AnalysisInfo.h,cc
  - Event.h,cc
  - EventSource.h,cc
  - EventReadFromFile.h,cc
  - EventSim.h,cc
  - SourceFactory.h,cc
  - AnalysisSteering.h,cc
  - AnalysisFactory.h,cc
- to AnalysisUtilities:
  - Constants.h,cc
  - Utilities.h,cc
  - QuadraticFitter.h,cc
- to AnalysisObjects:
  - ParticleReco.h,cc
  - ProperTime.h,cc
  - MassMean.h,cc
  - LifetimeFit.h,cc
- to AnalysisPlugins:
  - EventDump.h,cc
  - ParticleMass.h,cc
  - ParticleLifetime.h,cc

***
Update the paths in all the #include instructions

***
Compile the code in AnalysisFramework, AnalysisUtilities, AnalysisObjects
and produce a dynamic library for each package.
Modify the "braggPlot_v6/compile" script changing the names where needed.

***
Compile the code in AnalysisPlugins and produce a dynamic library for 
each class.

***
Create a dummy source file and compile it linking the libraries, 
to produce different executables (as in braggPlot_v6)

