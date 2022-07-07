## particleHist_v3

### Modify Hist_v2 and use a factory to create data analyzers


Take the following from `braggPlot_v3`:

- the new versions of `AnalysisSteering.h,cc`
  (and look at the differences with the v2 version),
- `AnalysisFactory.h,cc`.


Modify `EventDump.h,cc` and `ParticleMass.h,cc` taking `braggPlot_v3` as 
reference:

- add an `AnalysisInfo*` as parameter to the constructor, and use it to 
  initialize the `AnalysisSteering` base,
- add a concrete Factory class and object, as in braggPlot_v3,
- get from the `AnalysisInfo` object the name of the output ROOT file
  (only for `ParticleMass.cc`)


Modify the `main` function to use `AnalysisFactory`.
