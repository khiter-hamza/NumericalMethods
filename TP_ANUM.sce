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
    k=0;
    y=x0;
    while k <> n then

        disp(string(k)+"|"+string(y)+"|"+string(f(y))+"|"+string(abs(g(y)-y)));
        k=k+1;
        y=g(y);
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
[y,n]=Nweton_table(F,dF,x0,n);
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






