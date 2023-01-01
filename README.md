# nimcorpora
A Nim interface for Darius Kazemi's [Corpora](https://github.com/dariusk/corpora) project.


[**Documentation**](https://neroist.github.io/nimcorpora/)

Inspired by [pycorpora](https://github.com/aparrish/pycorpora).

## Installation 
Since at the moment nimcorpora is not on nimble you can install it by its Github or Git link:

```
nimble install https://github.com/neroist/nimcorpora
```

or 

```
nimble install https://github.com/neroist/nimcorpora.git
```

After installation, Corpora's data will be installed to the packages's directory. If this fails for whatever reason, [report an error](https://github.com/neroist/nimcorpora/issues/new) and install and put the data in the `data/` directory in the package directory.

## Documentation
See https://neroist.github.io/nimcorpora/

## Distribution
For distributing an application, make sure the directory containing Corpora's data is **neighboring the directory of the executable**

So, the preferred file structure for distributing is:
```
your_application/
  bin/
    your_executable
    ...
    
  data/
    ...
```

To install the data there, you can either use `installCorporaData()` or include the data by default in you application directory

In addition, `update()`, by default, updates the data in the package's directory. When compiling a release build, `update()` instead updates the data in the `data/` directory. So, make sure to compile with `-d:release` when distributing so `update()` works correctly for distributing.

###### Made with 
