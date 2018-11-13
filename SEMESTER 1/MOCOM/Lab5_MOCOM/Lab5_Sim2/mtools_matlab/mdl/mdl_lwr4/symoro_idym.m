% Inverse Dynamic Model using Newton-Euler Algorithm
% Robot with rigid joints and fixed base
% 
% 
% Geometric parameters
% j       ant     sigma   mu      gamma   b       alpha   d       theta   r       
% 1       0       0       1       0       0       0       0       th1     0       
% 2       1       0       1       0       0       pi/2    0       th2     0       
% 3       2       0       1       0       0       -pi/2   0       th3     RL3     
% 4       3       0       1       0       0       -pi/2   0       th4     0       
% 5       4       0       1       0       0       pi/2    0       th5     RL5     
% 6       5       0       1       0       0       pi/2    0       th6     0       
% 7       6       0       1       0       0       -pi/2   0       th7     0       
% 
% Dynamic inertia parameters
% j       XX      XY      XZ      YY      YZ      ZZ      MX      MY      MZ      M       IA      
% 1       XX1     XY1     XZ1     YY1     YZ1     ZZ1     MX1     MY1     MZ1     M1      IA1     
% 2       XX2     XY2     XZ2     YY2     YZ2     ZZ2     MX2     MY2     MZ2     M2      IA2     
% 3       XX3     XY3     XZ3     YY3     YZ3     ZZ3     MX3     MY3     MZ3     M3      IA3     
% 4       XX4     XY4     XZ4     YY4     YZ4     ZZ4     MX4     MY4     MZ4     M4      IA4     
% 5       XX5     XY5     XZ5     YY5     YZ5     ZZ5     MX5     MY5     MZ5     M5      IA5     
% 6       XX6     XY6     XZ6     YY6     YZ6     ZZ6     MX6     MY6     MZ6     M6      IA6     
% 7       XX7     XY7     XZ7     YY7     YZ7     ZZ7     MX7     MY7     MZ7     M7      IA7     
% 
% External forces and joint parameters
% j       FX      FY      FZ      CX      CY      CZ      FS      FV      QP      QDP     GAM     eta     k       
% 1       FX1     FY1     FZ1     CX1     CY1     CZ1     FS1     FV1     QP1     QDP1    GAM1    0       0       
% 2       FX2     FY2     FZ2     CX2     CY2     CZ2     FS2     FV2     QP2     QDP2    GAM2    0       0       
% 3       FX3     FY3     FZ3     CX3     CY3     CZ3     FS3     FV3     QP3     QDP3    GAM3    0       0       
% 4       FX4     FY4     FZ4     CX4     CY4     CZ4     FS4     FV4     QP4     QDP4    GAM4    0       0       
% 5       FX5     FY5     FZ5     CX5     CY5     CZ5     FS5     FV5     QP5     QDP5    GAM5    0       0       
% 6       FX7     FY7     FZ7     CX7     CY7     CZ7     FS6     FV6     QP6     QDP6    GAM6    0       0       
% 7       FX7     FY7     FZ7     CX7     CY7     CZ7     FS7     FV7     QP7     QDP7    GAM7    0       0       
% 
% Base velicities parameters
% axis    W0      WP0     V0      VP0     G       
% X       0       0       0       0       0       
% Y       0       0       0       0       0       
% Z       0       0       0       0       G3  


function tau = symoro_idym(ab, q, qd, qdd, g, fe)

% inputs map
persistent XX1     XY1     XZ1     YY1     YZ1     ZZ1     MX1     MY1     MZ1     M1      IA1   %#ok  
persistent XX2     XY2     XZ2     YY2     YZ2     ZZ2     MX2     MY2     MZ2     M2      IA2    
persistent XX3     XY3     XZ3     YY3     YZ3     ZZ3     MX3     MY3     MZ3     M3      IA3     
persistent XX4     XY4     XZ4     YY4     YZ4     ZZ4     MX4     MY4     MZ4     M4      IA4     
persistent XX5     XY5     XZ5     YY5     YZ5     ZZ5     MX5     MY5     MZ5     M5      IA5     
persistent XX6     XY6     XZ6     YY6     YZ6     ZZ6     MX6     MY6     MZ6     M6      IA6     
persistent XX7     XY7     XZ7     YY7     YZ7     ZZ7     MX7     MY7     MZ7     M7      IA7   

persistent G1   G2  G3 %#ok

persistent FX1  FY1  FZ1  CX1  CY1  CZ1 %#ok
persistent FX2  FY2  FZ2  CX2  CY2  CZ2 %#ok
persistent FX3  FY3  FZ3  CX3  CY3  CZ3 %#ok
persistent FX4  FY4  FZ4  CX4  CY4  CZ4 
persistent FX5  FY5  FZ5  CX5  CY5  CZ5 
persistent FX6  FY6  FZ6  CX6  CY6  CZ6 %#ok
persistent FX7  FY7  FZ7  CX7  CY7  CZ7 

persistent FV1 FS1 
persistent FV2 FS2 
persistent FV3 FS3 
persistent FV4 FS4 
persistent FV5 FS5 
persistent FV6 FS6 
persistent FV7 FS7 

persistent RL3 RL5

if(isempty(XX1)), 
    [XX1, YY1, ZZ1, XY1, XZ1, YZ1] = splitcol(ab.body(1).I) ;
    [XX2, YY2, ZZ2, XY2, XZ2, YZ2] = splitcol(ab.body(2).I) ;
    [XX3, YY3, ZZ3, XY3, XZ3, YZ3] = splitcol(ab.body(3).I) ;
    [XX4, YY4, ZZ4, XY4, XZ4, YZ4] = splitcol(ab.body(4).I) ;
    [XX5, YY5, ZZ5, XY5, XZ5, YZ5] = splitcol(ab.body(5).I) ;
    [XX6, YY6, ZZ6, XY6, XZ6, YZ6] = splitcol(ab.body(6).I) ;
    [XX7, YY7, ZZ7, XY7, XZ7, YZ7] = splitcol(ab.body(7).I) ;    
    
    [G1, G2, G3] = splitrow(g) ;
    
    M1 = ab.body(1).m ;
    M2 = ab.body(2).m ;
    M3 = ab.body(3).m ;
    M4 = ab.body(4).m ;
    M5 = ab.body(5).m ;
    M6 = ab.body(6).m ;
    M7 = ab.body(7).m ;
    
    FV1 = ab.body(1).Fv ;
    FV2 = ab.body(2).Fv ;
    FV3 = ab.body(3).Fv ;
    FV4 = ab.body(4).Fv ;
    FV5 = ab.body(5).Fv ;
    FV6 = ab.body(6).Fv ;
    FV7 = ab.body(7).Fv ;
    
    FS1 = ab.body(1).Fc ;
    FS2 = ab.body(2).Fc ;
    FS3 = ab.body(3).Fc ;
    FS4 = ab.body(4).Fc ;
    FS5 = ab.body(5).Fc ;
    FS6 = ab.body(6).Fc ;
    FS7 = ab.body(7).Fc ;
    
    IA1 = ab.body(1).Ia ;
    IA2 = ab.body(2).Ia ;
    IA3 = ab.body(3).Ia ;
    IA4 = ab.body(4).Ia ;
    IA5 = ab.body(5).Ia ;
    IA6 = ab.body(6).Ia ;
    IA7 = ab.body(7).Ia ;
    
    [MX1, MY1, MZ1] = splitrow(M1.*ab.body(1).cg) ;
    [MX2, MY2, MZ2] = splitrow(M2.*ab.body(2).cg) ;
    [MX3, MY3, MZ3] = splitrow(M3.*ab.body(3).cg) ;
    [MX4, MY4, MZ4] = splitrow(M4.*ab.body(4).cg) ;
    [MX5, MY5, MZ5] = splitrow(M5.*ab.body(5).cg) ;
    [MX6, MY6, MZ6] = splitrow(M6.*ab.body(6).cg) ;
    [MX7, MY7, MZ7] = splitrow(M7.*ab.body(7).cg) ;
    
    
    [FX1, FY1, FZ1, CX1, CY1, CZ1] = splitrow(fe(:,1)) ;
    [FX2, FY2, FZ2, CX2, CY2, CZ2] = splitrow(fe(:,2)) ;
    [FX3, FY3, FZ3, CX3, CY3, CZ3] = splitrow(fe(:,3)) ;
    [FX4, FY4, FZ4, CX4, CY4, CZ4] = splitrow(fe(:,4)) ;
    [FX5, FY5, FZ5, CX5, CY5, CZ5] = splitrow(fe(:,5)) ;
    [FX6, FY6, FZ6, CX6, CY6, CZ6] = splitrow(fe(:,6)) ;
    [FX7, FY7, FZ7, CX7, CY7, CZ7] = splitrow(fe(:,7)) ;
    
    RL3 = ab.body(3).r ;
    RL5 = ab.body(5).r ;
end

[~, th2, th3, th4, th5, th6, th7] = splitrow(q) ;
[QP1, QP2, QP3, QP4, QP5, QP6, QP7] = splitrow(qd) ;
[QDP1, QDP2, QDP3, QDP4, QDP5, QDP6, QDP7] = splitrow(qdd) ;

% equations

% C1 = cos(th1);
% S1 = sin(th1);
C2 = cos(th2);
S2 = sin(th2);
C3 = cos(th3);
S3 = sin(th3);
C4 = cos(th4);
S4 = sin(th4);
C5 = cos(th5);
S5 = sin(th5);
C6 = cos(th6);
S6 = sin(th6);
C7 = cos(th7);
S7 = sin(th7);
% DV61 = QP1^2;
W12 = QP1*S2;
W22 = C2*QP1;
WP12 = QDP1*S2 + QP2*W22;
WP22 = C2*QDP1 - QP2*W12;
DV12 = W12^2;
DV22 = W12*W22;
% DV32 = QP2*W12;
% DV42 = W22^2;
DV52 = QP2*W22;
DV62 = QP2^2;
% U112 = -DV42 - DV62;
% U212 = DV22 + QDP2;
% U312 = DV32 - WP22;
U122 = DV22 - QDP2;
U222 = -DV12 - DV62;
U322 = DV52 + WP12;
% U132 = DV32 + WP22;
% U232 = DV52 - WP12;
% U332 = -DV12 - DV42;
VP12 = -G3*S2;
VP22 = -C2*G3;
W13 = C3*W12 - QP2*S3;
W23 = -C3*QP2 - S3*W12;
W33 = QP3 + W22;
WP13 = C3*WP12 - QDP2*S3 + QP3*W23;
WP23 = -C3*QDP2 - QP3*W13 - S3*WP12;
WP33 = QDP3 + WP22;
DV13 = W13^2;
DV23 = W13*W23;
DV33 = W13*W33;
DV43 = W23^2;
DV53 = W23*W33;
DV63 = W33^2;
U113 = -DV43 - DV63;
U213 = DV23 + WP33;
% U313 = DV33 - WP23;
U123 = DV23 - WP33;
U223 = -DV13 - DV63;
% U323 = DV53 + WP13;
U133 = DV33 + WP23;
U233 = DV53 - WP13;
% U333 = -DV13 - DV43;
VSP13 = U122*RL3 + VP12;
VSP23 = U222*RL3 + VP22;
VSP33 = U322*RL3;
VP13 = C3*VSP13 - S3*VSP33;
VP23 = -C3*VSP33 - S3*VSP13;
W14 = C4*W13 - S4*W33;
W24 = -C4*W33 - S4*W13;
W34 = QP4 + W23;
WP14 = C4*WP13 + QP4*W24 - S4*WP33;
WP24 = -C4*WP33 - QP4*W14 - S4*WP13;
WP34 = QDP4 + WP23;
DV14 = W14^2;
DV24 = W14*W24;
DV34 = W14*W34;
DV44 = W24^2;
DV54 = W24*W34;
DV64 = W34^2;
U114 = -DV44 - DV64;
U214 = DV24 + WP34;
U314 = DV34 - WP24;
U124 = DV24 - WP34;
U224 = -DV14 - DV64;
U324 = DV54 + WP14;
U134 = DV34 + WP24;
U234 = DV54 - WP14;
U334 = -DV14 - DV44;
VP14 = C4*VP13 - S4*VSP23;
VP24 = -C4*VSP23 - S4*VP13;
W15 = C5*W14 + S5*W34;
W25 = C5*W34 - S5*W14;
W35 = QP5 - W24;
WP15 = C5*WP14 + QP5*W25 + S5*WP34;
WP25 = C5*WP34 - QP5*W15 - S5*WP14;
WP35 = QDP5 - WP24;
DV15 = W15^2;
DV25 = W15*W25;
DV35 = W15*W35;
DV45 = W25^2;
DV55 = W25*W35;
DV65 = W35^2;
U115 = -DV45 - DV65;
U215 = DV25 + WP35;
U315 = DV35 - WP25;
U125 = DV25 - WP35;
U225 = -DV15 - DV65;
U325 = DV55 + WP15;
U135 = DV35 + WP25;
U235 = DV55 - WP15;
U335 = -DV15 - DV45;
VSP15 = -U124*RL5 + VP14;
VSP25 = -U224*RL5 + VP24;
VSP35 = -U324*RL5 + VP23;
VP15 = C5*VSP15 + S5*VSP35;
VP25 = C5*VSP35 - S5*VSP15;
W16 = C6*W15 + S6*W35;
W26 = C6*W35 - S6*W15;
W36 = QP6 - W25;
WP16 = C6*WP15 + QP6*W26 + S6*WP35;
WP26 = C6*WP35 - QP6*W16 - S6*WP15;
WP36 = QDP6 - WP25;
DV16 = W16^2;
DV26 = W16*W26;
DV36 = W16*W36;
DV46 = W26^2;
DV56 = W26*W36;
DV66 = W36^2;
U116 = -DV46 - DV66;
U216 = DV26 + WP36;
U316 = DV36 - WP26;
U126 = DV26 - WP36;
U226 = -DV16 - DV66;
U326 = DV56 + WP16;
U136 = DV36 + WP26;
U236 = DV56 - WP16;
U336 = -DV16 - DV46;
VP16 = C6*VP15 - S6*VSP25;
VP26 = -C6*VSP25 - S6*VP15;
W17 = C7*W16 - S7*W36;
W27 = -C7*W36 - S7*W16;
W37 = QP7 + W26;
WP17 = C7*WP16 + QP7*W27 - S7*WP36;
WP27 = -C7*WP36 - QP7*W17 - S7*WP16;
WP37 = QDP7 + WP26;
DV17 = W17^2;
DV27 = W17*W27;
DV37 = W17*W37;
DV47 = W27^2;
DV57 = W27*W37;
DV67 = W37^2;
U117 = -DV47 - DV67;
U217 = DV27 + WP37;
U317 = DV37 - WP27;
U127 = DV27 - WP37;
U227 = -DV17 - DV67;
U327 = DV57 + WP17;
U137 = DV37 + WP27;
U237 = DV57 - WP17;
U337 = -DV17 - DV47;
VP17 = C7*VP16 + S7*VP25;
VP27 = C7*VP25 - S7*VP16;
% F11 = -DV61*MX1 - MY1*QDP1;
% F21 = -DV61*MY1 + MX1*QDP1;
% F31 = -G3*M1;
% PSI11 = QP1*XZ1;
% PSI21 = QP1*YZ1;
% PSI31 = QP1*ZZ1;
% No11 = -PSI21*QP1 + QDP1*XZ1;
% No21 = PSI11*QP1 + QDP1*YZ1;
No31 = QDP1*ZZ1;
% F12 = M2*VP12 + MX2*U112 + MY2*U122 + MZ2*U132;
% F22 = M2*VP22 + MX2*U212 + MY2*U222 + MZ2*U232;
% F32 = MX2*U312 + MY2*U322 + MZ2*U332;
PSI12 = QP2*XZ2 + W12*XX2 + W22*XY2;
PSI22 = QP2*YZ2 + W12*XY2 + W22*YY2;
PSI32 = QP2*ZZ2 + W12*XZ2 + W22*YZ2;
No12 = -PSI22*QP2 + PSI32*W22 + QDP2*XZ2 + WP12*XX2 + WP22*XY2;
No22 = PSI12*QP2 - PSI32*W12 + QDP2*YZ2 + WP12*XY2 + WP22*YY2;
No32 = -PSI12*W22 + PSI22*W12 + QDP2*ZZ2 + WP12*XZ2 + WP22*YZ2;
F13 = M3*VP13 + MX3*U113 + MY3*U123 + MZ3*U133;
F23 = M3*VP23 + MX3*U213 + MY3*U223 + MZ3*U233;
% F33 = M3*VSP23 + MX3*U313 + MY3*U323 + MZ3*U333;
PSI13 = W13*XX3 + W23*XY3 + W33*XZ3;
PSI23 = W13*XY3 + W23*YY3 + W33*YZ3;
PSI33 = W13*XZ3 + W23*YZ3 + W33*ZZ3;
No13 = -PSI23*W33 + PSI33*W23 + WP13*XX3 + WP23*XY3 + WP33*XZ3;
No23 = PSI13*W33 - PSI33*W13 + WP13*XY3 + WP23*YY3 + WP33*YZ3;
No33 = -PSI13*W23 + PSI23*W13 + WP13*XZ3 + WP23*YZ3 + WP33*ZZ3;
F14 = M4*VP14 + MX4*U114 + MY4*U124 + MZ4*U134;
F24 = M4*VP24 + MX4*U214 + MY4*U224 + MZ4*U234;
F34 = M4*VP23 + MX4*U314 + MY4*U324 + MZ4*U334;
PSI14 = W14*XX4 + W24*XY4 + W34*XZ4;
PSI24 = W14*XY4 + W24*YY4 + W34*YZ4;
PSI34 = W14*XZ4 + W24*YZ4 + W34*ZZ4;
No14 = -PSI24*W34 + PSI34*W24 + WP14*XX4 + WP24*XY4 + WP34*XZ4;
No24 = PSI14*W34 - PSI34*W14 + WP14*XY4 + WP24*YY4 + WP34*YZ4;
No34 = -PSI14*W24 + PSI24*W14 + WP14*XZ4 + WP24*YZ4 + WP34*ZZ4;
F15 = M5*VP15 + MX5*U115 + MY5*U125 + MZ5*U135;
F25 = M5*VP25 + MX5*U215 + MY5*U225 + MZ5*U235;
F35 = -M5*VSP25 + MX5*U315 + MY5*U325 + MZ5*U335;
PSI15 = W15*XX5 + W25*XY5 + W35*XZ5;
PSI25 = W15*XY5 + W25*YY5 + W35*YZ5;
PSI35 = W15*XZ5 + W25*YZ5 + W35*ZZ5;
No15 = -PSI25*W35 + PSI35*W25 + WP15*XX5 + WP25*XY5 + WP35*XZ5;
No25 = PSI15*W35 - PSI35*W15 + WP15*XY5 + WP25*YY5 + WP35*YZ5;
No35 = -PSI15*W25 + PSI25*W15 + WP15*XZ5 + WP25*YZ5 + WP35*ZZ5;
F16 = M6*VP16 + MX6*U116 + MY6*U126 + MZ6*U136;
F26 = M6*VP26 + MX6*U216 + MY6*U226 + MZ6*U236;
F36 = -M6*VP25 + MX6*U316 + MY6*U326 + MZ6*U336;
PSI16 = W16*XX6 + W26*XY6 + W36*XZ6;
PSI26 = W16*XY6 + W26*YY6 + W36*YZ6;
PSI36 = W16*XZ6 + W26*YZ6 + W36*ZZ6;
No16 = -PSI26*W36 + PSI36*W26 + WP16*XX6 + WP26*XY6 + WP36*XZ6;
No26 = PSI16*W36 - PSI36*W16 + WP16*XY6 + WP26*YY6 + WP36*YZ6;
No36 = -PSI16*W26 + PSI26*W16 + WP16*XZ6 + WP26*YZ6 + WP36*ZZ6;
F17 = M7*VP17 + MX7*U117 + MY7*U127 + MZ7*U137;
F27 = M7*VP27 + MX7*U217 + MY7*U227 + MZ7*U237;
F37 = M7*VP26 + MX7*U317 + MY7*U327 + MZ7*U337;
PSI17 = W17*XX7 + W27*XY7 + W37*XZ7;
PSI27 = W17*XY7 + W27*YY7 + W37*YZ7;
PSI37 = W17*XZ7 + W27*YZ7 + W37*ZZ7;
No17 = -PSI27*W37 + PSI37*W27 + WP17*XX7 + WP27*XY7 + WP37*XZ7;
No27 = PSI17*W37 - PSI37*W17 + WP17*XY7 + WP27*YY7 + WP37*YZ7;
No37 = -PSI17*W27 + PSI27*W17 + WP17*XZ7 + WP27*YZ7 + WP37*ZZ7;
E17 = F17 + FX7;
E27 = F27 + FY7;
E37 = F37 + FZ7;
N17 = CX7 + MY7*VP26 - MZ7*VP27 + No17;
N27 = CY7 - MX7*VP26 + MZ7*VP17 + No27;
N37 = CZ7 + MX7*VP27 - MY7*VP17 + No37;
FDI17 = C7*E17 - E27*S7;
FDI37 = -C7*E27 - E17*S7;
E16 = F16 + FDI17 + FX7;
E26 = E37 + F26 + FY7;
E36 = F36 + FDI37 + FZ7;
N16 = C7*N17 + CX7 - MY6*VP25 - MZ6*VP26 - N27*S7 + No16;
N26 = CY7 + MX6*VP25 + MZ6*VP16 + N37 + No26;
N36 = -C7*N27 + CZ7 + MX6*VP26 - MY6*VP16 - N17*S7 + No36;
FDI16 = C6*E16 - E26*S6;
FDI36 = C6*E26 + E16*S6;
E15 = F15 + FDI16 + FX5;
E25 = -E36 + F25 + FY5;
E35 = F35 + FDI36 + FZ5;
N15 = C6*N16 + CX5 - MY5*VSP25 - MZ5*VP25 - N26*S6 + No15;
N25 = CY5 + MX5*VSP25 + MZ5*VP15 - N36 + No25;
N35 = C6*N26 + CZ5 + MX5*VP25 - MY5*VP15 + N16*S6 + No35;
FDI15 = C5*E15 - E25*S5;
FDI35 = C5*E25 + E15*S5;
E14 = F14 + FDI15 + FX4;
E24 = -E35 + F24 + FY4;
E34 = F34 + FDI35 + FZ4;
N14 = C5*N15 + CX4 - FDI35*RL5 + MY4*VP23 - MZ4*VP24 - N25*S5 + No14;
N24 = CY4 - MX4*VP23 + MZ4*VP14 - N35 + No24;
N34 = C5*N25 + CZ4 + FDI15*RL5 + MX4*VP24 - MY4*VP14 + N15*S5 + No34;
FDI14 = C4*E14 - E24*S4;
% FDI34 = -C4*E24 - E14*S4;
E13 = F13 + FDI14 + FX3;
E23 = E34 + F23 + FY3;
% E33 = F33 + FDI34 + FZ3;
N13 = C4*N14 + CX3 + MY3*VSP23 - MZ3*VP23 - N24*S4 + No13;
N23 = CY3 - MX3*VSP23 + MZ3*VP13 + N34 + No23;
N33 = -C4*N24 + CZ3 + MX3*VP23 - MY3*VP13 - N14*S4 + No33;
FDI13 = C3*E13 - E23*S3;
FDI33 = -C3*E23 - E13*S3;
% E12 = F12 + FDI13 + FX2;
% E22 = E33 + F22 + FY2;
% E32 = F32 + FDI33 + FZ2;
N12 = C3*N13 + CX2 + FDI33*RL3 - MZ2*VP22 - N23*S3 + No12;
N22 = CY2 + MZ2*VP12 + N33 + No22;
N32 = -C3*N23 + CZ2 - FDI13*RL3 + MX2*VP22 - MY2*VP12 - N13*S3 + No32;
% FDI12 = C2*E12 - E22*S2;
% FDI32 = C2*E22 + E12*S2;
% E11 = F11 + FDI12 + FX1;
% E21 = -E32 + F21 + FY1;
% E31 = F31 + FDI32 + FZ1;
% N11 = C2*N12 + CX1 - G3*MY1 - N22*S2 + No11;
% N21 = CY1 + G3*MX1 - N32 + No21;
N31 = C2*N22 + CZ1 + N12*S2 + No31;
% FDI11 = C1*E11 - E21*S1;
% FDI21 = C1*E21 + E11*S1;
GAM1 = FS1*sign(QP1) + FV1*QP1 + IA1*QDP1 + N31;
GAM2 = FS2*sign(QP2) + FV2*QP2 + IA2*QDP2 + N32;
GAM3 = FS3*sign(QP3) + FV3*QP3 + IA3*QDP3 + N33;
GAM4 = FS4*sign(QP4) + FV4*QP4 + IA4*QDP4 + N34;
GAM5 = FS5*sign(QP5) + FV5*QP5 + IA5*QDP5 + N35;
GAM6 = FS6*sign(QP6) + FV6*QP6 + IA6*QDP6 + N36;
GAM7 = FS7*sign(QP7) + FV7*QP7 + IA7*QDP7 + N37;

tau = [GAM1; GAM2; GAM3; GAM4; GAM5; GAM6; GAM7] ;
