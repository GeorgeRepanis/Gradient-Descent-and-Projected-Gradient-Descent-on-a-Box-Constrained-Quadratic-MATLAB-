%% ΘΕΜΑ 1 - Γραφήματα για gamma = 0.1, 0.3, 3, 5
clear; clc; close all;

% Συνάρτηση & gradient
f  = @(x) (1/3)*x(1).^2 + 3*x(2).^2;
gf = @(x) [ (2/3)*x(1); 6*x(2) ];

% Παράμετροι
gammas  = [0.1 0.3 3 5];   % τιμές βήματος
epsilon = 1e-3;            % ακρίβεια: ||x_k|| <= epsilon
kmax    = 1000;            % μέγιστος αριθμός επαναλήψεων (ασφάλεια)

% Αρχικό σημείο (ίδιο για όλα)
x0 = [10; 0];

for i = 1:length(gammas)
    gamma = gammas(i);

    % Αρχικοποίηση
    xk = x0;
    k  = 0;
    F_hist = f(xk);

    % Steepest Descent: τρέχουμε μέχρι ||x_k|| <= epsilon ή μέχρι kmax
    while norm(xk) > epsilon && k < kmax
        gk = gf(xk);
        dk = -gk;
        xk = xk + gamma * dk;
        k  = k + 1;

        fx = f(xk);
        F_hist(k+1) = fx;

        if ~isfinite(fx)
            % σταμάτα αν "σκάσει" αριθμητικά (απόκλιση)
            break;
        end
    end

    % Πληροφορίες για το συγκεκριμένο gamma
    fprintf('-----------------------------\n');
    fprintf('gamma = %.1f\n', gamma);
    fprintf('Τελικό k = %d\n', k);
    fprintf('Τελικό x_k = (%.6e, %.6e)^T\n', xk(1), xk(2));
    fprintf('norm(x_k) = %.6e (epsilon = %.6e)\n', norm(xk), epsilon);
    if norm(xk) <= epsilon
        fprintf('=> Ικανοποιήθηκε το κριτήριο ακρίβειας.\n');
    else
        fprintf('=> ΔΕΝ ικανοποιήθηκε το κριτήριο (πιθανή απόκλιση).\n');
    end

    % Γράφημα για το τρέχον gamma (γραμμική κλίμακα)
    figure;
    iters = 0:length(F_hist)-1;
    plot(iters, F_hist, 'o-','LineWidth',1.5);
    xlabel('Αριθμός επαναλήψεων k');
    ylabel('τιμή f(x_k)');
    title(sprintf('Σύγκλιση της f(x_k) για \\gamma = %.1f', gamma));
    grid on;

  
end
