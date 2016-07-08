# Smart Sinusoids

[![Join the chat at https://gitter.im/tiborsimon/smart-sinusoids](https://badges.gitter.im/tiborsimon/smart-sinusoids.svg)](https://gitter.im/tiborsimon/smart-sinusoids?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="http://tiborsimon.io/images/smart-sinusoids/3d.png" width="600" />

The easiest way to generate a sine or cosine signal in MATLAB. With this library there are almost infinite ways to describe and generate a sinusoid signals. 

<a title="Latest version" href="https://github.com/tiborsimon/smart-sinusoids/releases/latest" target="_blank">
   <img src="https://img.shields.io/badge/version-v1.3.0-green.svg?style=flat" />
</a>
<a title="Goto article" href="http://tiborsimon.io/dsp/generating-sinusoid-signals/" target="_blank">
   <img src="https://img.shields.io/badge/article-read-blue.svg?style=flat" />
</a>
<a title="Goto discussion" href="http://tiborsimon.io/dsp/generating-sinusoid-signals/#discussion" target="_blank">
   <img src="https://img.shields.io/badge/discussion-join-orange.svg?style=flat" />
</a>
<a title="Dependency" href="#dependency" href="https://github.com/tiborsimon/simple-input-parser">
   <img src="http://img.shields.io/badge/dependency-simple--input--parser-red.svg?style=flat" />
</a>
<a title="License" href="#license">
   <img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat" />
</a>

## Dependecy
To use _ssin_ or _scos_, you need to download and add to your path <a title="Simple Input Parser" href="http://tiborsimon.io/projects/TSPR0002/" target="_blank"><b>Simple Input Parser</b></a> which is a package that allows you to create functions with a more convenient interface for the users.

## Installation

#### 1. Installing the dependency: 
- Download the [latest release of Simple Input Parser](https://github.com/tiborsimon/simple-input-parser/releases/latest).
- Run the `install.m` script or the `install` command inside the downloaded `simple-input-parser` folder.
- Done. Now you have __Simple Input Parser__ on your system.


#### 2. Installing __Smart Sinusoids__ 
- Download the [latest release](https://github.com/tiborsimon/smart-sinusoids/releases/latest).
- Run the `install.m` script or the `install` command inside the downloaded `smart-sinusoids` folder.
- Done. You can use __Smart Sinusoids__ (and of course _Simple Input Parser_ too).

_This installation method is powered by the <a href="http://tiborsimon.io/projects/TSPR0001/" target="_blank" >MATLAB Library System</a>._

## Features
- fast and easy signal generation
- flexible parameter handling
- arbitrary parameter configurations
- optional time vector generation

# Possible parameters

<img src="http://tiborsimon.io/images/smart-sinusoids/detailed.png" width="700" />


| Symbol | Unit | Name |
|:-----:|:---:|:------|
| __A__   | []   | signal amplitude 
| __phi__ | [°]  | phase in degrees 
| __f__   | [Hz] | signal frequency 
| __fs__  | [Hz] | sample rate
| __T__   | [s]  | signal period
| __dt__  | [s]  | sample time
| __N__   | []   | number of periods in the signal
| __n__   | []   | sample count
| __L__   | [s]  | signal length
| __x__   | [st] | optional time vector scaling (see details later)

# Possible use cases

With these parameters there are 5 main generation methods for sinusoid signals. Each of them have alternatives that doesn't count as an individual generation method due to the used parameters can be derived from the others if you apply the following formulas: _fs = 1/dt_, _T = 1/f_ and _L=n*dt_.

| Method index | Required parameters | CT DT lock     | Description  |
|:-------------:|:------------------|:--------------|:-------------|
| 1 | `n`, `N`          | No  | a signal consisting of `n` data points with `N`<br> periods in it
| 2 | `L`, `N`, `fs`    | Yes | `L` seconds long signal consisting `N` periods<br> with the frequency `f`
| 3 | `f`, `N`, `fs`    | Yes | a signal sampled at `fs` sampling rate with `N` <br>periods in it with the frequency `f`
| 4 | `f`, `n`, `fs`    | Yes | Generating a sinusoid signal consisting of `n` <br>data points sampled at `fs` sampling rate with the frequency `f`
| 5 | `f`, `L`, `fs`    | Yes | a signal sampled at `fs` sampling rate with the <br>duration of `L` seconds with the frequency `f`

### Case 1
- `n` - number of samples
- `N` - periods in it

```
stem( ssin('n N', 200, 1.5) )
```

### Case 2
- `L`  - signal lenght
- `N`  - periods in the signal
- `fs` - with a given sample frequency

``` 
stem( ssin('L N fs', 0.001, 3, 48e3) )
```

### Case 3
- `f`  - signal frequency
- `N`  - periods in the signal
- `fs` - with a given sample frequency

```
stem( ssin('f N fs', 440, 1.3, 48e3) )
```

### Case 4
- `f`  - signal frequency
- `n`  - number of samples
- `fs` - with a given sample frequency

```
stem( ssin('f n fs', 440, 200, 48e3) )
```

### Case 5
- `f`  - signal frequency
- `L`  - signal lenght
- `fs` - with a given sample frequency

```
stem( ssin('f L fs', 800, 0.001, 48e3) )
```

In every case every parameter can be substituted with the eqvivalent
counterparst. ie. f~T, fs~dt, L~n,dt ...

The amplitude (A) and phase (phi) are optional with the defualt values
A=1 and phi=0.

# Output parameter configurations

There are three output parameter configurations

### No output parameter

In this case Smart Sinusouds will output the signal vector in place.
This could be useful during plotting

```
stem( ssin('f N fs', 440, 1.3, 48e3) )

```
### One output parameter

With this configuration you can save the signal vector into a variable.

```
s = ssin('f N fs', 440, 1.3, 48e3);
stem(s)
```

### Two output parameter mode

If you would like to use the time vector as well, you can generate it
too. The possibble values are the following:

| Time vector type | x parameter    | Description                                     |
|------------------|----------------|-------------------------------------------------|
| Sample count     | index          | Sample indexes from 1 to the number of samples. |
| Normalized       | norm           | Normalized vector spans from 0 to 1.            |
| Time [s]         | time or s      | Time duration of the signal in seconds.         |
| Time [ms]        | militime or ms | Time duration of the signal in seconds.         |

```
[t,s] = ssin('f N fs x', 440, 1.3, 48e3, 'ms');
stem(t,s)
```

## License

This project is under the __MIT license__. 
See the included license file for further details.

