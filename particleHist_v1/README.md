### Modify Mean_v4 and produce histograms of invariant mass

Include histograms inside `ParticleMass` class.


In `ParticleMass.h`:
- define a `Particle` struct to hold
  - a string to be used as name,
  - a pointer to `MassMean`,
  - a pointer to `TH1F`,
- modify the STL array to hold pointers to `Particle` objects,
- declare a function `pCreate` to create a `decay mode` (use `bCreate`
  function in `ElementReco` as example).



In `MassMean.h,cc`
- change the `add` function to `bool` and return true or false for events
  in the mass range or not.



In `ParticleMass.cc`:
- implement the function `pCreate` taking 3 arguments, one string and min-max
  masses; use the name as name for `TH1F` and min-max masses 
  to create the `MassMean` object; store the pointers of the objects;
- in `beginJob` replace the direct creation of `MassMean` object with 
  calls to `pCreate` for the 2 decay modes (use 0.495-0.500 and
  1.115-1.116 as ranges);
- in `endJob` loop over the Particle objects and for each one 
  get the event number, mean and rms masses and printout them, then
  save the histogram to file;
- in `process` loop over the ParticleMass objects, call the 
  `add` function for each `MassMean` object and fill the histogram
  with the invariant mass for the accepted events.
  Do not worry about multiple calls to `mass` function for the same event.
