
### Modify Hist_v1 and use a factory to create data source

Use `SourceFactory` to create the `EventSource`.
The execution command should be:
```
execName input fileName
or
execName sim numberOfEvents [seed seedNumber]
```


Take following files from example `braggPlot_v2`:
`AnalysisInfo.h`
`AnalysisInfo.cc`
`SourceFactory.h`
`SourceFactory.cc`
All these files can be used with no modification



Modify `main.cc` taking `braggPlot_v2` as reference:
- create an `AnalysisInfo` object and use it to store command line parameters
- remove the code to create the `EventSource` and use a `SourceFactory` 
  in its place
- remove unnecessary header files
