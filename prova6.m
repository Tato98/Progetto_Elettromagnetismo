close all
clear all
clc

%variabili utilizzate
passo=0.1;
Mur1=1;
Mur2=1;
Mu0=4*pi*10^(-7);
Eps0=8.85418781762*10^(-12);
%f=300*10^6;
f=0.1;
z=1; 
amp=0;
Epsr1= input("Inserire un valore per la costante dielettrica relativa del mezzo 1: ");
Epsr2= input("Inserire un valore per la costante dielettrica relativa del mezzo 2: ");
Ex= input("Inserire un ampiezza per l'onda incidente: ");

%coefficiente di riflessione
rho= (sqrt(Epsr1) - sqrt(Epsr2))/(sqrt(Epsr1) + sqrt(Epsr2));
%coefficiente di trasmissione
tau=1+rho;
%pulsazione
w=2*pi*f;
%costanti di fase del mezzo 1 e del mezzo 2
B1=w*sqrt(Mu0*Eps0*Epsr1);
B2=w*sqrt(Mu0*Eps0*Epsr2);

%controllo per l'ampiezza della linea di demarcazione fra i due dielettrici
if Ex > Ex*tau
    amp = Ex;
elseif Ex < Ex*tau
    amp = Ex*tau;
end

for k=-10 : passo : 0
    i= -10 : passo : k;
    Ei= Ex*cos(w*i -(k + B1*z));
    plot(i,Ei,'r');
    line([0 0],[-(amp+0.5) (amp+0.5)],'linewidth',1,'Color','k');
    axis([-10 10 -(amp+0.5) (amp+0.5)])
    drawnow
end
i= -10 : passo : 0;
for k= 0 : passo : 10
    r= 0 : -passo : -k;
    t= 0 : passo : k;
    s= -10 : passo : k-10;
    Ei= Ex*cos(w*i -(k + B1*z));
    Er= Ex*rho*cos(w*r +(k + B1*z));
    Et= Ex*tau*cos(w*t -(k + B2*z));
    Es= Ex*(cos(w*s -(k + B1*z) + rho*cos(w*s +(k + B1*z))));
    plot(i,Ei,'r',r,Er,'b--',t,Et,'g',s,Es,'m');
    line([0 0],[-(amp+0.5) (amp+0.5)],'linewidth',1,'Color','k');
    axis([-10 10 -(amp+0.5) (amp+0.5)])
    drawnow
end
r= 0 : -passo : -10;
t= 0 : passo : 10;
s= -10 : passo : 0;
for k= 0 : passo : 100
    Ei= Ex*cos(w*i -(k + B1*z));
    Er= Ex*rho*cos(w*r +(k + B1*z));
    Et= Ex*tau*cos(w*t -(k + B2*z));
    Es= Ex*(cos(w*s -(k + B1*z) + rho*cos(w*s +(k + B1*z))));
    plot(i,Ei,'r',r,Er,'b--',t,Et,'g',s,Es,'m');
    line([0 0],[-(amp+0.5) (amp+0.5)],'linewidth',1,'Color','k');
    axis([-10 10 -(amp+0.5) (amp+0.5)])
    drawnow
end