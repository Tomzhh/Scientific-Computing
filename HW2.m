% Analytic function to integrate
f = @(x) cos(x);

% Exact integral of the function
exact_integral = @(xmin, xmax) sin(xmax) - sin(xmin);

% Midpoint rule for numerical integration
function integral = midpoint_rule(f, xmin, xmax, NP)
    h = (xmax - xmin) / NP;
    integral = 0;
    for i = 0:(NP - 1)
        x = xmin + (i + 0.5) * h;
        integral = integral + h * f(x);
    end
end

% Define the range [xmin, xmax]
xmin = 0;
xmax = 5;

% List of NP values to test
NPs = [10, 50, 100, 200, 500];

% Lists to store runtimes and errors
runtimes_tic_toc = zeros(1, numel(NPs));
runtimes_cputime = zeros(1, numel(NPs));
errors = zeros(1, numel(NPs));

% Perform the integration for each NP value
for i = 1:numel(NPs)
    NP = NPs(i);
    
    % Measure runtime using tic-toc
    start_time = tic;
    numerical_integral = midpoint_rule(f, xmin, xmax, NP);
    end_time = toc(start_time);
    runtimes_tic_toc(i) = end_time;
    
    % Measure runtime using cputime
    start_time = cputime;
    numerical_integral = midpoint_rule(f, xmin, xmax, NP);
    end_time = cputime - start_time;
    runtimes_cputime(i) = end_time;
    
    exact = exact_integral(xmin, xmax);
    error = abs(numerical_integral - exact);
    errors(i) = error;
end

% Plot runtime performance using tic-toc
figure(1);
plot(NPs, runtimes_tic_toc, 'o-');
xlabel('Number of Discretization Points (NP)');
ylabel('Runtime (s)');
title('Runtime Performance (tic-toc)', 'FontSize', 14);
grid on;

% Plot runtime performance using cputime
figure(2);
plot(NPs, runtimes_cputime, 'o-');
xlabel('Number of Discretization Points (NP)');
ylabel('Runtime (s)');
title('Runtime Performance (cputime)', 'FontSize', 14);
grid on;

% Plot errors on a log scale
figure(3);
loglog(NPs, errors, 'o-');
xlabel('Number of Discretization Points (NP)');
ylabel('Error');
title('Error vs. NP (log scale)'), 'FontSize', 14;
grid on;
