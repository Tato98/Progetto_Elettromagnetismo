close all
clear all
clc

%variabili utilizzate
Mur1=1;
Mur2=1;
Mu0=4*pi*10^(-7);
Eps0=8.85418781762*10^(-12);
f=300*10^6;
z=1;
amp=0;
Epsr1= input("Inserire un valore per la costante dielettrica relativa del mezzo 1: ");
Epsr2= input("Inserire un valore per la costante dielettrica relativa del mezzo 2: ");
Ex= input("Inserire un ampiezza per l'onda incidente: ");

%coefficiente di riflessione
p= (sqrt(Epsr1) - sqrt(Epsr2))/(sqrt(Epsr1) + sqrt(Epsr2));
%coefficiente di trasmissione
tao=1+p;
%pulsazione
w=2*pi*f;
%parametri beta del mezzo 1 e del mezzo 2
B1=w*sqrt(Mu0*Eps0*Epsr1);
B2=w*sqrt(Mu0*Eps0*Epsr2);

%plot
t= linspace(-10,0,1000);
x= linspace(0,10,1000);
axis([-10 10 -10 10])
%controllo per l'ampiezza della linea di demarcazione fra i due dielettrici
if Ex > Ex*tao
    amp = Ex;
elseif Ex < Ex*tao
    amp = Ex*tao;
end   

for i= 0 : 0.2 : 1000
    %onda incidente
    Ei= Ex*cos(w*t -(i*pi + B1*z));
    %onda riflessa
    Er= Ex*p*cos(w*t +(i*pi + B1*z));
    %onda trasmessa
    Et= Ex*tao*cos(w*x -(i*pi + B2*z));
    %somma onda incidente e onda riflessa
    E1= Ex*(cos(w*t -(i*pi + B1*z) + p*cos(w*t +(i*pi + B1*z))));
    plot(t,Ei,'b',t,Er,'r--',t,E1,'g',x,Et,'y','linewidth',2);
    line([0 0],[-amp amp],'linewidth',2,'Color','k');
    title('Incidenza di onde piane uniformi su di una superficie di separazione tra due dielettrici');
    legend('Onda incidente','Onda riflessa','Somma onda incidente e onda riflessa','Onda trasmessa');
    grid on
    drawnow
end
