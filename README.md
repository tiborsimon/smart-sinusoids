# Smart Sinusoids

The easiest way to generate a sine or cosine signal in MATLAB. With this library there are almost infinite ways to describe and generate a sinusoid signals. 

<a href="http://tiborsimon.github.io/tools/solarized-theme-for-embedded-gists/" target="_blank"><img src="http://tiborsimon.github.io/images/core/corresponding-article.png" /></a>   <a href="http://tiborsimon.github.io/tools/solarized-theme-for-embedded-gists#discussion" target="_blank"><img src="http://tiborsimon.github.io/images/core/join-to-the-discussion.png" /></a>   <a href="http://tiborsimon.github.io/tools/solarized-theme-for-embedded-gists#demo" target="_blank"><img src="http://tiborsimon.github.io/images/core/live-demo.png" /></a>

# Generating sinusoids

Generating a sinusoid signal is often the first step for other computations. It should be a 

### The old way

```
t = [0:1:40];
f = 500;
fs = 8000;
x = sin(2*pi*f/fs*t);
figure(1)
stem(t,x,'r');
```
