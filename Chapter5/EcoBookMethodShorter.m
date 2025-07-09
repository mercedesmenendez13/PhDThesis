%%%%%%
%This code expects an existing variable S which is a (NC x NP) sized matrix of RCAs
%and
%an (NC x NE) sized matrix Z_original which has NE environmental variables on the columns 

%Turn this to 1 in case you want residual analysis
DoResidualAnalysisInsteadofCCA = 0;

tmpMat = S;
tmpMat = tmpMat';

Ttot = sum(sum(tmpMat));
Dmat = tmpMat / Ttot;
[NP,NC] = size(Dmat);

%Delete after debugging
%Z_original = Z_original(:,1:3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,NE] = size(Z_original); 

fcol = sum(Dmat,1); %this actually is normalised diversity
frow = sum(Dmat,2); %this actually is normalised ubiquity

%first, build the Matrix Q_bar of the Chi-squared metric
tmpMat = frow * fcol;
tmpMat2 = Dmat - tmpMat;
tmpMat = tmpMat .^0.5;
Q = (tmpMat2 ./ tmpMat)';

D_col = diag(fcol);
D_row = diag(frow);
D_col_Sqrt = D_col .^0.5;
D_row_Sqrt = D_row .^0.5;


%Now standardize enviroment variables (as diversity-weighted means and stdevs)
weight_vec = fcol/sum(fcol);
tmpVec2 = sum(diag(weight_vec) * Z_original)/sum(weight_vec); 
Z = zeros(NC,NE);
for i=1:NE
    Z(:,i) = Z_original(:,i) - tmpVec2(:,i);  
end
stnd = (sum(diag(weight_vec) *(Z .* Z))/sum(weight_vec)) .^0.5; 
Z = bsxfun(@rdivide,Z,stnd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


M1 = D_col_Sqrt * Z;
M2 = Z' * D_col * Z;
M3 = M1'* Q;
B = M2\M3;
Y_Hat = M1 * B;

S_Mat =  Y_Hat' * Y_Hat;
if(DoResidualAnalysisInsteadofCCA ==1)
  S_Mat =  (Q-Y_Hat)' * (Q-Y_Hat);
end


%Now the same reproduced by our method from Ter Braak
birs = ones(NC,1);

Z_withConstant = [birs Z];
R = diag(fcol);

RowNormDmat=bsxfun(@rdivide,Dmat,frow);
ColNormDmat=bsxfun(@rdivide,Dmat,fcol);
RowNormDmat(isnan(RowNormDmat))=0;
ColNormDmat(isnan(ColNormDmat))=0;
RowNormDmat(isinf(RowNormDmat))=0;
ColNormDmat(isinf(ColNormDmat))=0;

%CovMatP=RowNormDmat*ColNormDmat';
CovMatC=ColNormDmat'*RowNormDmat;

CCA_Reg_Transform = (Z_withConstant'*R*Z_withConstant)\(Z_withConstant'*R);
CCA_EigMat = CovMatC * Z_withConstant * CCA_Reg_Transform;
if(DoResidualAnalysisInsteadofCCA ==1)
    CCA_EigMat = CovMatC * (eye(NC)-Z_withConstant * CCA_Reg_Transform);
end

[VCCA,DCCA]=eig(CCA_EigMat);
VCCA = real(VCCA);
DCCA= real (DCCA);
DCCA=diag(DCCA)';
[~,r]=sort(DCCA,'descend');
DCCA = DCCA(r);
VCCA = VCCA(:,r);

weight_vec = fcol;

if(DoResidualAnalysisInsteadofCCA ==0)
    EigVal_Scaler = diag(DCCA(2:NE+1)).^0.5;
end
if(DoResidualAnalysisInsteadofCCA ==1) 
    EigVal_Scaler = diag(DCCA(1:(NC-1)-NE)) .^0.5;
end


if(DoResidualAnalysisInsteadofCCA ==0)
    tmpMat = VCCA(:,2:NE+1);
    %the following weighted-normalization of the EVs is not really
    %necessary, but is still useful to keep b in meaningful magnitudes
    tmpVec2 = sum(diag(weight_vec) * tmpMat)/sum(weight_vec);
    for i=1:NE
        tmpMat(:,i) =tmpMat(:,i)-tmpVec2(:,i);
    end
    stnd = (sum(diag(weight_vec) *(tmpMat .* tmpMat))/sum(weight_vec)) .^0.5;
    tmpMat = bsxfun(@rdivide,tmpMat,stnd);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    b = CCA_Reg_Transform * tmpMat;
    x = Z_withConstant*b;

    % the following normalization is very important in order to have product scores to preserve chi-squared distances
    tmpVec2 = sum(diag(weight_vec) * x)/sum(weight_vec);
    for i=1:NE
        x(:,i) = x(:,i)-tmpVec2(:,i);
    end
    stnd = (sum(diag(weight_vec) *(x .* x))/sum(weight_vec)) .^0.5;
    x = bsxfun(@rdivide,x,stnd);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if(DoResidualAnalysisInsteadofCCA ==1)
    tmpMat = VCCA(:,1:(NC-1)-NE);
    %the following weighted-normalization of the EVs is not really
    %necessary, but is still useful to keep b in meaningful magnitudes
    tmpVec2 = sum(diag(weight_vec) * tmpMat)/sum(weight_vec);
    for i=1:((NC-1)-NE)
        tmpMat(:,i) =tmpMat(:,i)-tmpVec2(:,i);
    end
    stnd = (sum(diag(weight_vec) *(tmpMat .* tmpMat))/sum(weight_vec)) .^0.5;
    tmpMat = bsxfun(@rdivide,tmpMat,stnd);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x = (eye(NC)-Z_withConstant * CCA_Reg_Transform) * tmpMat;

    % the following normalization is very important in order to have product scores to preserve chi-squared distances
    tmpVec2 = sum(diag(weight_vec) * x)/sum(weight_vec);
    for i=1:((NC-1)-NE)
        x(:,i) = x(:,i)-tmpVec2(:,i);
    end
    stnd = (sum(diag(weight_vec) *(x .* x))/sum(weight_vec)) .^0.5;
    x = bsxfun(@rdivide,x,stnd);
end


% The following pair are the ordinations Onder suggests/reccomends. This one puts the
% countries at the barycentrum of products, where country scores are
% (neatly) the RCA-weighted averages of product scores. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u = RowNormDmat * x;
x_star = (u' * ColNormDmat)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%However, Bart is not willing to with anything that is not in the EcoBook!
% Thus, let's reproduce the scalings which the EcoBook
%arbitrarily claims to be the only valid ones for biplots...
F_hat = u;
V = u/EigVal_Scaler;
F = x_star/EigVal_Scaler;
V_hat = F/EigVal_Scaler; 
Z_Scl1 = x * EigVal_Scaler;
Z_Scl2 = x;

DCCA_EcoBook = DCCA(1,2:1+nE);

%Compute the arrow corrdinates
% It is very important to note that,the transpose of these coordinate vectors can conveniently be used for projections (i.e., the rotation of the biplots) 
if(DoResidualAnalysisInsteadofCCA == 0)
    % First for the fitted variables (x)
    Arrows_x = zeros(NE,NE);
    for i=1:NE
        for j=1:NE
            Arrows_x(i,j) = sum(diag(weight_vec) *(Z_Scl2(:,j) .* Z(:,i)))/sum(weight_vec);
        end
    end

    Arrows_x_rotated = Arrows_x * Arrows_x';
 
% Then for the site scores (x_star)
    Arrows_x_star = zeros(NE,NE);
    F_norm = zeros(NC,NE);
    tmpVec2 = sum(diag(weight_vec) * F)/sum(weight_vec);     
    for i=1:NE
        F_norm(:,i) = F(:,i) - tmpVec2(:,i);  
    end
    stnd = (sum(diag(weight_vec) *(F_norm .* F_norm))/sum(weight_vec)) .^0.5; 
    F_norm = bsxfun(@rdivide,F_norm,stnd);
    for i=1:NE
        for j=1:NE
            Arrows_x_star(i,j) = sum(diag(weight_vec) *(F_norm(:,j) .* Z(:,i)))/sum(weight_vec);
        end
    end

    Arrows_x_star_rotated = Arrows_x_star * Arrows_x_star';    

end


%Finally HH (CA) with all eigenvectors at once
%CovMatP=RowNormDmat*ColNormDmat';
CovMatC=ColNormDmat'*RowNormDmat;
[VC,DC]=eig(CovMatC);
VC = real(VC);
DC= real (DC);
DC=diag(DC)';
[~,r]=sort(DC,'descend');
DC = DC(r);
VC = VC(:,r);

Inertia_HH = sum(DC(2:end));

EigVal_Scaler = diag(DC(2:end));
EigVal_Scaler = EigVal_Scaler .^0.5; 


weight_vec = fcol/sum(fcol);
tmpVec2 = sum(diag(weight_vec) * VC)/sum(weight_vec); 
VC_norm = zeros(NC,NC);
for i=1:NC
    VC_norm(:,i) = VC(:,i) - tmpVec2(:,i);  
end
stnd = (sum(diag(weight_vec) *(VC_norm .* VC_norm))/sum(weight_vec)) .^0.5; 
VC_norm = bsxfun(@rdivide,VC_norm,stnd);
VC_norm =VC_norm(:,2:end);

CS_norm = RowNormDmat * VC_norm;
VC_norm = (CS_norm' * ColNormDmat)';

VC_norm_alt = VC_norm/EigVal_Scaler; 
CS_norm_alt = RowNormDmat * VC_norm_alt;




