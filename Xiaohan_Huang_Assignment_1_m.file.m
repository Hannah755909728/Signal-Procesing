%There are three parts I use the function sound(),if let all three parts' sound
%be available , the sound wil be played at the same time.So I use ¡®%¡¯to let
%only one function of sound() be available .


%recit the FarEndSignal.wav file
x=audioread('FarEndSignal.wav');
%sound(x,8000);
xf=x; 
[y,N]=room(xf,201920667);
N

%Design a filter h3 and its N-fold expansion and plot its impulsse and
%magnitude responses
h3 = fir1(23,0.4);
h = zeros(1,N*length(h3));
h(1:N:end) = h3;

figure(1);
impz(h3);

figure(2);
fs=8000;
f=(0:length(h)-1)/length(h)*fs;
plot(f,abs(fft(h)));
xlabel('Frequency/[Hz]');
ylabel('Magnitude');

%Design a filter g3[n] = (( 1)nh3[n] and its N-fold expansion g[n] = g3[nN].
%Plots its impulse and magnitude responses.
g3=h3;
g3(2:2:end) = -g3(2:2:end);
g3 = (-1).^(0:23).*h3;
g = zeros(1,N*length(g3));
g(1:N:end) = g3;

figure(3);
impz(g3);

figure(4);
fs=8000;
f=(0:length(g)-1)/length(g)*fs;
plot(f,abs(fft(g)));
xlabel('Frequency/[Hz]');
ylabel('Magnitude');

% % %calculate CONVOLUTION
% C1=conv(g3,h3);
% figure(5);
% impz(C1);

% C2=conv(C1,x);
% figure(6);
% impz(C2)



%recit the FarEndSignal.wav file and filter it 
x=audioread('FarEndSignal.wav');
xf=filter(g,1,x);
[y,N]=room(xf,201920667);
yf=filter(h,1,y);
% sound(yf,8000);

%3.3 NOTE 264/306 FIR Filter Implementation
N1=length(h);                                % filter length
y_tdl=zeros(N1,1);                           % TDL vector initialisation
for n=1:length(y)                            % iteration --- once per sampling period

% step 1: update TDL with latest samples
y_tdl = [y(n); y_tdl(1:(N1-1))];

% step 2: calculate output y[n] using scalar product
yfn(n) = h*y_tdl;
end;
figure(22);
plot(yfn);


%inspecting the time domain waveform y[n] 
figure(6);
stem(y);

%Provide plots for the time domain segment in Q4.1 and the magnitude spectrum in Q4.2
figure(7);
fs=8000;
f=(0:length(y)-1)/length(y)*fs;
plot(f,abs(fft(y)));
xlabel('Frequency/[Hz]');
ylabel('Magnitude');

%Plot the magnitude response |H2(ej?)| in Matlab
figure(5)
f1=(0:0.0001:1)*2*pi;
c=cos(3200*2*pi/8000);
H2=(1-2*c*exp(f1*i*(-1))+exp(i*f1*(-2)))./(1-1.8*c*exp(i*(-1)*f1)+0.81*exp(i*f1*(-2)));
f=(0:length(H2)-1)/length(H2)*fs;
plot(f,abs(H2));
xlabel('Frenquency/Hz');
ylabel('Magnitude');

%fifilter music signal y with the IIR notch fifilter
a=[1 -1.8*cos(2*pi*3200/8000) 0.81];
b=[1 -2*cos(2*pi*3200/8000) 1];
yff = filter(b,a,yf);		 % yf is the input of filter q 
% sound(yff,8000);			 % play back the filtered signal 

figure(8);
fs=8000;
f=(0:length(yff)-1)/length(yff)*fs;
plot(f,abs(fft(yff)));
xlabel('Frequency/[Hz]');
ylabel('Magnitude');

figure(9);
fs=8000;
f=(0:length(yf)-1)/length(yf)*fs;
plot(f,abs(fft(yf)));
xlabel('Frequency/[Hz]');
ylabel('Magnitude');

figure(10);
stem(yf);

figure(11);
stem(yff);

%Q5.5 without q[n] to attenuate the noise
x=audioread('FarEndSignal.wav');
xf=filter(h,1,x);
[y,N]=room(xf,201920667);
yf=filter(g,1,y);
sound(yf,8000);

figure(12);
stem(y);

figure(13);
stem(yf);





