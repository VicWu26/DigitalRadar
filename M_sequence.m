close all;  clear all;  clc;
code = [];
for i=1:32
    y = m_seq(11,flag);
    code = [code;y];
end

function  y = m_seq(n,flag)
switch n
    case 5
        taps=2;
        tap1=2;
        tap2=5;
    case 10
       taps=2;
       tap1=3;
       tap2=10;
    case 11
       taps=2;
       tap1=2;
       tap2=11;
    case 12
       taps=4;
       tap1=1;
       tap2=4;
       tap3=6;
       tap4=12;
    case 13
       taps=4;
       tap1=1;
       tap2=3;
       tap3=4;
       tap4=13;
end

    if (nargin == 1) 
        flag = 0;
    end

    if flag == 1
        abuff = ones(1,n);
    else
        rand('state',sum(100*clock))

        while 1
            abuff = round(rand(1,n));
            %make sure not all bits are zero
            if find(abuff==1)
                break
            end
        end
    end

    for i = (2^n)-1:-1:1

       xorbit = xor(abuff(tap1),abuff(tap2));		%feedback bit

       if taps==4
          xorbit2 = xor(abuff(tap3),abuff(tap4));%4 taps = 3 xor gates & 2 levels of logic
          xorbit = xor(xorbit,xorbit2);				%second logic level
       end

        abuff = [xorbit abuff(1:n-1)];
        y(i) = (-2 .* xorbit) + 1;  	%yields one's and negative one's (0 -> 1; 1 -> -1)
    end
end