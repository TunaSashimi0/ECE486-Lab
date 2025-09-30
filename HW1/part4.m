num = 8000;
den = [1 52 927 6000 10150 8500];
sys_full = tf(num, den);
[r_all, p_all, k_all] = residue(num, den);   
[~, idx1] = max(real(p_all));
p1 = p_all(idx1);
r1 = r_all(idx1);

tol = 1e-6;
idx2 = find(abs(p_all - conj(p1)) < tol, 1);

if ~isempty(idx2) && idx2 ~= idx1
    % use conjugate pair -> second-order approx
    p2 = p_all(idx2);
    r2 = r_all(idx2);
    denA = real(poly([p1 p2]));                      % (s-p1)(s-p2)
    numA = real([ (r1 + r2), (-r1*p2 - r2*p1) ]);     % r1/(s-p1)+r2/(s-p2)
else
    % use single real dominant pole -> first-order approx
    denA = real(poly(p1));    % (s - p1)
    numA = real(r1);          % numerator constant
end

sys_apx = tf(numA, denA);

poles = roots(den);
taus = -1./real(poles(real(poles) < 0));  
if isempty(taus)
    Tfinal = 5;
else
    Tfinal = max(5, 8*max(taus));
end
t = linspace(0, Tfinal, 1000);

% step responses
[y_full, t_full] = step(sys_full, t);
[y_apx,  t_apx]  = step(sys_apx,  t);

% plot
figure();
plot(t_full, y_full); hold on;
plot(t_apx,  y_apx,  '--');
xlabel('Time (s)');
ylabel('Amplitude');
title('Step response for G(s) and dominant pole approximation');
legend('Full G(s)', 'Dominant-pole approx', 'Location', 'Best');
grid on;