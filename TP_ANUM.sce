function [y,n] = Nweton(f, df, x0, e)
    function z = g(x)
        z=x-(f(x)/df(x));
    endfunction
    n=0;
    y=x0;
    while abs(f(y)) >= e then
        n=n+1;
        y=g(y);
    end
endfunction

function [y,n] = Nweton_table(f, df, x0,n)
    function z = g(x)
        z=x-(f(x)/df(x));
    endfunction
    colone = [0];
    k=0;
    y=x0;
    while k <> n then

        disp(string(k)+"|"+string(y)+"|"+string(f(y))+"|"+string(abs(g(y)-y)));
        colone = [colone;log10(abs(g(y)-y))];
        k=k+1;
        y=g(y);
    end

    line = [0:1:n];
    plot(line,colone);
endfunction

function [y,n] = Nweton_table1(f, df, x0,n)
    function z = g(x)
        z=x-(f(x)/df(x));
    endfunction
    xn_arr = [x0];
    dn_arr = [abs(g(x0)-x0)];
    k=0;
    y=x0;
    while k <> n then

        k=k+1;
        dn_arr = [dn_arr;abs(g(y)-y)];
        y=g(y);
        xn_arr = [xn_arr;y];
    end

    line = [0:1:n];
    // now to  draw the table 
      disp("the table : ");

        disp(string(line(1))+"|"+string(xn_arr(1))+"|"+string(dn_arr(1))+"|"+"----"+"|"+"----"+"|"+"----"+"|");
        disp(string(line(2))+"|"+string(xn_arr(2))+"|"+string(dn_arr(2))+"|"+string(dn_arr(2)/dn_arr(1))+"|"+string(log(dn_arr(2)/dn_arr(1)))+"|"+"----"+"|");

     for i = [2:1:n]
        disp(string(line(i+1))+"|"+string(xn_arr(i+1))+"|"+string(dn_arr(i+1))+"|"+string(dn_arr(i+1)/dn_arr(i))+"|"+string(log(dn_arr(i+1)/dn_arr(i)))+"|"+string(log(dn_arr(i+1)/xn_arr(i))/log(dn_arr(i)/dn_arr(i-1)))+"|");


     end  


    endfunction
     function [y,n] = Ostrowski_table1(f, df, x0, n)
    function y = Ost(x)
        y=x-(f(x)/df(x));
    endfunction

    function y = g(x)
        y=Ost(x)-f(x)*f(Ost(x))/((f(x)-2*f(Ost(x)))*df(x))
    endfunction

    xn_arr = [x0];
    dn_arr = [abs(g(x0)-x0)];

    k=0;
    y=x0;
    while k <> n then

        k=k+1;
        dn_arr = [dn_arr;abs(g(y)-y)];
        y=g(y);
        xn_arr = [xn_arr;y];
    end

    
    
line = [0:1:n];
    // now to  draw the table 
      disp("the table : ");

        disp(string(line(1))+"|"+string(xn_arr(1))+"|"+string(dn_arr(1))+"|"+"----"+"|"+"----"+"|"+"----"+"|");
        disp(string(line(2))+"|"+string(xn_arr(2))+"|"+string(dn_arr(2))+"|"+string(dn_arr(2)/dn_arr(1))+"|"+string(log(dn_arr(2)/dn_arr(1)))+"|"+"----"+"|");

     for i = [2:1:n]
        disp(string(line(i+1))+"|"+string(xn_arr(i+1))+"|"+string(dn_arr(i+1))+"|"+string(dn_arr(i+1)/dn_arr(i))+"|"+string(log(dn_arr(i+1)/dn_arr(i)))+"|"+string(log(dn_arr(i+1)/xn_arr(i))/log(dn_arr(i)/dn_arr(i-1)))+"|");


     end  
    
endfunction







function [y] = Secant(r0, r1, fonc, n)
    function y = g(r0, r1)
        y=r0-(r1-r0)/(fonc(r1)-fonc(r0)) *fonc(r0);
    endfunction

    if n==0 then
        y=r0;
    elseif n==1 then
        y=r1;
    else
        for i = [2:1:n]
            y=g(r0,r1);
            r0=r1;
            r1=y;
        end     
    end
endfunction
function [y] = Secant_Tabel(r0, r1, fonc, n)
    function y = g(r0, r1)
        y=r0-(r1-r0)/(fonc(r1)-fonc(r0)) *fonc(r0);
    endfunction

    Colone=[];
    DISTANS=[];
    XN=[r0,r1];
    if n==0 then
        y=r0;
    elseif n==1 then
        y=r1;
    else
        disp(string(0)+" | "+string(r0)+" | "+string(r1)+" | "+string(abs(r0-r1)));Colone=[Colone;log10(abs(r0-r1))];
        DISTANS=[DISTANS;abs(r0-r1)];
        disp(string(1)+" | "+string(r1)+" | "+string(g(r0,r1))+" | "+string(abs(g(r0,r1)-r1)));Colone=[Colone;log10(abs(g(r0,r1)-r1))];
        DISTANS=[DISTANS;abs(g(r0,r1)-r1)];
        for i = [2:1:n]
            y=g(r0,r1);
            r0=r1;
            r1=y;
            disp(string(i)+" | "+string(y)+" | "+string(g(r0,r1))+" | "+string(abs(y-g(r0,r1))));Colone=[Colone;log10(abs(g(r0,r1)-y))];
            DISTANS=[DISTANS;abs(g(r0,r1)-y)];
            XN=[XN,y];
        end     
    end

    Line=[0:1:n];
    plot(Line,Colone)

    disp(string(0)+" | "+string(r0)+" | "+string(DISTANS(1))+" | //////// | //////// | //////// ");
    disp(string(1)+" | "+string(r1)+" | "+string(DISTANS(2))+" | "+string(DISTANS(2)/DISTANS(1))+" | "+string(log(DISTANS(2)/DISTANS(1)))+" | //////// ");
    rnp=DISTANS(2)/DISTANS(1);
    for i = [2:1:n]
        rn=DISTANS(i+1)/DISTANS(i);
        disp(string(i)+" | "+string(XN(i+1))+" | "+string(DISTANS(i+1))+" | "+string(rn)+" | "+string(log(rn))+" |  "+string(log(rn)/log(rnp)));
        rnp=rn;
    end
endfunction

function [y,n] = Ostrowski(f, df, x0, e)
    function y = Ost(x)
        y=x-(f(x)/df(x));
    endfunction

    function y = g(x)
        y=Ost(x)-f(x)*f(Ost(x))/((f(x)-2*f(Ost(x)))*df(x))
    endfunction

    n=0;
    y=x0;
    while abs(f(y)) >= e then
        n=n+1;
        y=g(y);
    end
endfunction

function [y,n] = Ostrowski_table(f, df, x0, n)
    function y = Ost(x)
        y=x-(f(x)/df(x));
    endfunction

    function y = g(x)
        y=Ost(x)-f(x)*f(Ost(x))/((f(x)-2*f(Ost(x)))*df(x))
    endfunction

    colone = [0];

    k=0;
    y=x0;
    while k <> n then

        disp(string(k)+"|"+string(y)+"|"+string(f(y))+"|"+string(abs(g(y)-y)));
         colone = [colone;log10(abs(g(y)-y))];
        k=k+1;
        y=g(y);
    end

    line = [0:1:n];
    plot(line,colone);
endfunction

function y = F(x)
    y=exp(x)-sqrt(2);
endfunction

function y = dF(x)
    y=exp(x);
endfunction

disp("For Nweton method");
x0=input("Enter X0 : ");
e=input("Enter the tolerance : ");
[y,n]=Nweton(F, dF, x0, e);
disp("The result is : ( "+string(y)+" ) of order : "+string(n));
n=input("Enter the order for newton table: ");
disp(" the result of newton method table : ");
[y,n]=Nweton_table1(F,dF,x0,n);
disp("For Secant method");
r0=input("Enter R0 : ");
r1=input("Enter R1 : ");
n=input("Enter the order : ");
y=Secant(r0, r1, F, n);
disp("The result is : ( "+string(y)+" )");
disp("For Ostrowski method");
x0=input("Enter X0 : ");
e=input("Enter the tolerance : ");
[y,n]=Ostrowski(F, dF, x0, e);
disp("The result is : ( "+string(y)+" ) of order : "+string(n));






