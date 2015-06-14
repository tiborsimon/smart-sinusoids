# Smart Sinusoids

<img src="http://tiborsimon.github.io/images/smart-sinusoids/3d.png" width="600" />

The easiest way to generate a sine or cosine signal in MATLAB. With this library there are almost infinite ways to describe and generate a sinusoid signals. 

<a href="http://tiborsimon.github.io/programming/smart-sinusoids/" target="_blank"><img src="http://tiborsimon.github.io/images/core/corresponding-article.png" /></a>   <a href="http://tiborsimon.github.io/programming/smart-sinusoids/#discussion" target="_blank"><img src="http://tiborsimon.github.io/images/core/join-to-the-discussion.png" /></a>   <a href="https://github.com/tiborsimon/simple-input-parser" target="_blank"><img src="http://tiborsimon.github.io/images/core/dependency.png" /></a>


## Dependecy
To use ssin or ssin, you need to download and add to your path 
Simple Input Parser which is a package that allows you to create
functions with a more convenient interface.
URL: https://github.com/tiborsimon/simple-input-parser

## Installation

- Download the latest release of __Smart Sinusoids__ <a href="https://github.com/tiborsimon/simple-input-parser/releases/latest" target="_blank"><img src="http://tiborsimon.github.io/images/core/latest-release.png" /></a> 
- Download the latest release of __Simple Input Parser__ <a href="https://github.com/tiborsimon/smart-sinusoids/releases/latest" target="_blank"><img src="http://tiborsimon.github.io/images/core/latest-release.png" /></a>

## Features
- fast and easy signal generation
- flexible parameter handling
- arbitrary parameter configurations
- optional time vector generation

# Possible parameters

<img src="http://tiborsimon.github.io/images/smart-sinusoids/detailed.png" width="700" />


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


