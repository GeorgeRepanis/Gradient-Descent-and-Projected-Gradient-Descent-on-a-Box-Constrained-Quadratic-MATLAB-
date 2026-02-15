%% ΘΕΜΑ 3 - Μέθοδος Μέγιστης Καθόδου με Προβολή
clear; clc; close all;

% Αντικειμενική συνάρτηση & gradient
f  = @(x) (1/3)*x(1).^2 + 3*x(2).^2;
gf = @(x) [ (2/3)*x(1); 6*x(2) ];

% Προβολή στο κουτί X: -10<=x1<=5, -8<=x2<=12
projX = @(z) [ ...
    min(5,  max(-10, z(1))); ...
    min(12, max(-8,  z(2))) ];

% Παράμετροι μεθόδου (Θέμα 3)
s       = 15;        % "προ-βήμα" πάνω στο -grad
gamma   = 0.1;       % βήμα προς το προβληθέν σημείο
epsilon = 1e-2;      % ακρίβεια: ||x_k|| <= epsilon
kmax    = 500;       % μέγιστος αριθμός επαναλήψεων (ασφάλεια)

% Αρχικό σημείο
x0 = [-5; 10];

% Αρχικοποίηση
xk = x0;
k  = 0;

F_hist = f(xk);      % ιστορικό f(x_k)
N_hist = norm(xk);   % (αν θες και ||x_k||)

% Επανάληψη Μέγιστης Καθόδου με Προβολή
while norm(xk) > epsilon && k < kmax
    gk = gf(xk);          % gradient στο x_k

    % 1) Προ-βήμα καθόδου
    yk = xk - s * gk;

    % 2) Προβολή στο X
    zk = projX(yk);

    % 3) Διεύθυνση
    dk = zk - xk;

    % 4) Τελικό βήμα
    xk = xk + gamma * dk;

    k = k + 1;

    % Αποθήκευση ιστορικού
    F_hist(k+1) = f(xk);
    N_hist(k+1) = norm(xk);

    if ~isfinite(F_hist(k+1))
        break;      % σταμάτα αν "σκάσει" αριθμητικά
    end
end

% Εκτύπωση βασικών αποτελεσμάτων
fprintf('Τελικό k = %d\n', k);
fprintf('Τελικό x_k = (%.6f, %.6f)^T\n', xk(1), xk(2));
fprintf('norm(x_k) = %.6e (epsilon = %.6e)\n', norm(xk), epsilon);

if norm(xk) <= epsilon
    fprintf('=> Ικανοποιήθηκε το κριτήριο ακρίβειας.\n');
else
    fprintf('=> ΔΕΝ ικανοποιήθηκε το κριτήριο ακρίβειας.\n');
end

%% Γράφημα σύγκλισης της f(x_k) ως προς k
figure;
iters = 0:length(F_hist)-1;
plot(iters, F_hist, 'o-','LineWidth',1.5);
xlabel('Αριθμός επαναλήψεων k');
ylabel('τιμή f(x_k)');
title('Σύγκλιση της f(x_k) για Μέθοδο Καθόδου με Προβολή (Θέμα 3)');
grid on;

