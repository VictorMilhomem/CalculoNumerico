disp("Solu��o de sistema linear triangular e diagonal");

function [sol info res err] = subsparatras(a, b, exa)
  [m n] = size(a);
  mB = size(b, 1);
  info = 1;
  if (m != n)
    info = 2; %matriz n�o quadrada
  elseif (m != mB)
    info = 3; % b tem numero de linhas diferente do numero de linhas de a
  else  
    for i=1:m
      for j=1:n
        if (i == j)
          if (a(i, j) == 0)
            info = 4; % diagonal principal contendo zero
          endif
        endif
      endfor
    endfor
  endif
  if (info == 1)
    sol = zeros(m, 1); % gera o vetor solu��o contendo zeros
    for i = n:-1:1  % loop para resolver o sistema triangular superior
      s = 0.0; 
      for j = (i+1):n
        s = s + a(i,j) * sol(j);
      endfor
      sol(i) = (b(i) - s) / a(i,i);
    endfor
    
    % como info == 1 o calculo do residuo � a norma de a * sol - b    
    res = norm(a * sol - b);
    % como info == 1 o erro � a norma de sol - exa
    err = norm(sol - exa);
  else
    % para os casos de info != 1
    sol = Inf;
    res = Inf;
    err = Inf;
  endif 
endfunction


function [sol info res err] = diagonal(a, b, exa)
  [m n] = size(a);
  mB = size(b, 1);
  info = 1;
  if (m != n)
    info = 2; %matriz n�o quadrada
  elseif (m != mB)
    info = 3; % b tem numero de linhas diferente do numero de linhas de a
  else  
    for i=1:m
      for j=1:n
        if (i == j)
          if (a(i, j) == 0)
            info = 4; % diagonal principal contendo zero
          endif
        endif
      endfor
    endfor
  endif
  if (info == 1)
    sol = zeros(m, 1); % gera o vetor solu��o contendo zeros
    for i = 1:m
      sol(i) = b(i)/a(i,i);
    endfor
    % como info == 1 o calculo do residuo � a norma de a * sol - b    
    res = norm(a * sol - b);
    % como info == 1 o erro � a norma de sol - exa
    err = norm(sol - exa);
  else
    % para os casos de info != 1
    sol = Inf;
    res = Inf;
    err = Inf;
  endif 
endfunction


% testes

% este c�digo realiza 8 testes: 4 para matrizes triangulares superiores
%  e 4 para matrizes diagonais.
%
n=input(''); %entrada de teclado 
switch n
  case 1 % teste para matriz invers�vel
    a=triu(rand(5))+2*eye(5); % monta matriz invers�vel
    b=rand(5,1); % monta lado direito
    exa=a\b; % calcula solu��o exata
    resexa=norm(a*exa-b); % calcula res�duo
    [sol info res err]=subsparatras(a,b,exa);
    disp(info)
    %
    % caso diferen�a entre res�duo
    % calculado na fun��o e o calculado aqui
    % seja pequena
    %
    if(norm(resexa-res)<10^(-10))
        disp(0)
    else
        disp(1)
    endif  
    %
    % caso diferen�a  entre erro
    % calculado na fun��o e o calculado aqui
    % seja pequena
    %
    if((abs(norm(exa-sol)-err))<10^(-10))
        disp(0)
    else
        disp(1)
    endif     
case 2 % teste para matriz n�o quadrada
    a=triu(rand(5,6)); %monta matriz n�o quadrada
    b=rand(5,1);
    exa=Inf;
    [sol info res err]=subsparatras(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif 
case 3 % teste para lado direito n�o conforme
    a=triu(rand(5));
    b=rand(6,1);
    exa=Inf;
    [sol info res err]=subsparatras(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif
case 4 % teste para matriz com zero na diagonal principal
    a=triu(rand(5))+2*eye(5);
    b=rand(5,1);
    exa=Inf;
    ind=randi(5);
 coloca zero em uma das entradas da diagonal principal    
    a(ind,ind)=0; 
    [sol info res err]=subsparatras(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif 

case 5 %teste com matriz diagonal invers�vel
    a=diag(diag(rand(5)))+2*eye(5);
    b=rand(5,1);
    exa=a\b;
    resexa=norm(a*exa-b);
    [sol info res err]=diagonal(a,b,exa);
    disp(info)
    if(norm(resexa-res)<10^(-10))
        disp(0)
    else
        disp(1)
    endif  
    if((abs(norm(exa-sol)-err))<10^(-10))
        disp(0)
    else
        disp(1)
    endif 

case 6 % teste para matriz n�o quadrada
    a=[diag(diag(rand(5))) zeros(5,1)];
    b=rand(5,1);
    exa=Inf;
    [sol info res err]=diagonal(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif 

case 7 % teste para lado direito n�o conforme
    a=diag(diag(rand(5)))+2*eye(5);
    b=rand(6,1);
    exa=Inf;
    [sol info res err]=diagonal(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif
case 8 % teste para matriz com zero na diagonal principal
    a=diag(diag(rand(5)))+2*eye(5);
    b=rand(5,1);
    exa=Inf;
    ind=randi(5);
 % coloca zero em uma das entradas da diagonal principal 
    a(ind,ind)=0;
    [sol info res err]=diagonal(a,b,exa);
    disp(info)
    if(res==Inf)
        disp(0)
    else
        disp(1)
    endif    
    if(err==Inf)
        disp(0)
    else
        disp(1)
    endif 

otherwise 
    disp('op��o inv�lida. escolha n�meros de 1 a 8')
endswitch


