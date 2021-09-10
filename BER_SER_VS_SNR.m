clear all
close all
clc


NS =100;   % Number of random numbers generated
M = 64;    % Number of levels 

out = randi([0 M-1],NS,1); % the random numbers generated


x2 = @(t) [((t>=0)&(t<NS)).*(0)];  % Creating the transmitted signal

for i =1:NS
    % we are using x(t)to help x2(t) to build its shape
	x=@(t) [((t>=i-1)&(t<i)).*(out(i))]; % gives each duration T 'its own the random number'.
	x2= @(t) x(t)+ x2(t);
end

t=0:0.1:NS; % linespace
% Gives the figure a name, a ylabel, a xlabel, and a title
figure('NumberTitle','Off','Name','The transmitted signal m(t) versus Time');
subplot(2,1,1);
plot(t,x2(t));xlabel('Time(s)'); ylabel('Transmitted signal m(t)');
title('baseband (Transmitted pulse)');
grid on;

% Uncomment the following lines if you want to see the transmitted noisy
% signal

receievedSignal = awgn(x2(t),5,'measured');
subplot(2,1,2);
plot(t,receievedSignal);xlabel('Time(s)'); ylabel('r(t)');title('Received signal');
grid on;


% Defining some variables
EbNoVec = (1:0.25:10)';
if (M == 2)
    r2 = 1/30;
    var =  - sqrt(35);
else
    r2 = (sqrt(1/11));
    var = 10*log10((floor(log2(M-1))+ 2));
end
berEst = zeros(size(EbNoVec));



for n = 1:length(EbNoVec)
    
    snrdB = EbNoVec(n)+ var;    % setting the SNR in dB
    
    receievedSignal = awgn(x2(t),snrdB,'measured');   % using the awgn as a simulation of the channel 

    % Defining some variables
    x4 = @(t) [((t>=0)&(t<NS)).*(0)]; % singal we gonna use to carry the output signal of the matched filter
    final = zeros(NS,1);
    counter = 0;
    
    for i =1:NS
        % Matched filter
        x3 = @(t) [((t>=i-1)&(t<i)).*(receievedSignal)]; % correlation for each duration level with its self.
        w = conv(x3(t),x3(t)); 
        x4= @(t) x4(t)+ x3(t); % All corrlelation graph
        
        final(i) = round(sqrt(max(w)/10)); % received bits after passing through the matched filter.
        
        % a condition for modifing or managing some errors
        if(final(i) > M-1)
            final(i) = M-1;
        end
        
        %Discovering the number of errors 
        if(final(i) ~= out(i))
            counter = counter+1;
        end
    end

    % ratio of errors between the transmitted and received signal.
    ratio = counter/NS;
    berEst(n) = ratio*r2;
    % disp(berEst(n));
end


% Plotting the BER and SER


figure('NumberTitle','Off','Name','Task 2');

berTheory = berawgn(EbNoVec,'pam',M);
berTheory2 = berawgn(EbNoVec,'pam',8);
berTheory3 = berawgn(EbNoVec,'pam',16);

semilogy(EbNoVec,berEst,'o-')
hold on

if (M == 2)
    semilogy(EbNoVec,berTheory)
    grid on;
    legend('Estimated BER','Theoretical BER')
    ylabel('Bit Error Rate (BER)')
else
    semilogy(EbNoVec,[berTheory berTheory2 berTheory3])
    grid on;
    legend('Estimated SER with M = 64','Theoretical SER with M = 64','Theoretical SER with M = 8','Theoretical SER with M = 16')
    ylabel('Symbol Error Rate (SER)')
end

xlabel('Eb/No (dB)')


