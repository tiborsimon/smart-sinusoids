# Smart Sinusoids

<img src="http://tiborsimon.github.io/images/smart-sinusoids/3d.png" />

The easiest way to generate a sine or cosine signal in MATLAB. With this library there are almost infinite ways to describe and generate a sinusoid signals. 

<a href="http://tiborsimon.github.io/programming/smart-sinusoids/" target="_blank"><img src="http://tiborsimon.github.io/images/core/corresponding-article.png" /></a>   <a href="http://tiborsimon.github.io/programming/smart-sinusoids/#discussion" target="_blank"><img src="http://tiborsimon.github.io/images/core/join-to-the-discussion.png" /></a>


## Dependecy
To use ssin or ssin, you need to download and add to your path 
Simple Input Parser which is a package that allows you to create
functions with a more convenient interface.
URL: https://github.com/tiborsimon/simple-input-parser


## Features
- fast and easy signal generation
- flexible parameter handling

# Possible parameters

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
-`f`  - signal frequency
-`N`  - periods in the signal
-`fs` - with a given sample frequency

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

## No output parameter

In this case Smart Sinusouds will output the signal vector in place.
This could be useful during plotting

```
stem( ssin('f N fs', 440, 1.3, 48e3) )

```
## One output parameter

With this configuration you can save the signal vector into a variable.

```
s = ssin('f N fs', 440, 1.3, 48e3);
stem(s)
```

## Two output parameter mode

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


