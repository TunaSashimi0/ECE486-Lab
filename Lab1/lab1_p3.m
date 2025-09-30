wn = 1;
zetas = [1.5, 5, 40];
tFinal = 20;
t = linspace(0, tFinal, 2000);

figure('Units','normalized','Position',[0.05 0.05 0.9 0.85]);
sgtitle('Overdamped 2nd-order vs 1st-order approximation ( \omega_n = 1 )','FontSize',14);

for k = 1:length(zetas)
    zeta = zetas(k);
    
    % 2nd-order transfer: H2(s) = wn^2 / (s^2 + 2*zeta*wn*s + wn^2)
    num2 = wn^2;
    den2 = [1, 2*zeta*wn, wn^2];
    sys2 = tf(num2, den2);
    
    % compute poles analytically (for clarity)
    % s = -zeta +/- sqrt(zeta^2 - 1)  (with wn = 1)
    r = sqrt(zeta^2 - 1);
    alpha1 = zeta + r;
    alpha2 = zeta - r;
    p1 = -alpha1;   % fast pole (more negative)
    p2 = -alpha2;   % slow pole (closer to origin)
    
    % choose pole closer to origin (dominant) for 1st-order approx
    poles2 = pole(sys2);           % alternative: [p1; p2]
    [~, idx] = min(abs(poles2));  % index of pole closest to origin
    p_dom = poles2(idx);
    alpha_dom = -real(p_dom);      % positive magnitude
    
    % 1st-order approx H1(s) = alpha_dom / (s + alpha_dom)
    num1 = alpha_dom;
    den1 = [1, alpha_dom];
    sys1 = tf(num1, den1);
    
    % step responses
    y2 = step(sys2, t);
    y1 = step(sys1, t);
    
    % compute simple error metrics
    max_abs_err = max(abs(y2 - y1));
    rms_err = sqrt(mean((y2 - y1).^2));
    
    % Plot step responses (left column)
    subplot(length(zetas), 2, 2*(k-1) + 1);
    plot(t, y2, 'LineWidth', 1.6); hold on;
    plot(t, y1, '--', 'LineWidth', 1.2);
    xlabel('Time (s)');
    ylabel('Step response');
    title(sprintf('Step responses for \\zeta = %.1f', zeta));
    legend(sprintf('2^{nd}-order (\\zeta=%.1f)', zeta), ...
           sprintf('1^{st}-order approx (pole = %.4g)', -p_dom), ...
           'Location','best');
    grid on;
    xlim([0 tFinal]);
    ylim([-0.05 1.2]);
    
    % Plot pole locations (right column)
    subplot(length(zetas), 2, 2*(k-1) + 2);
    plot(real(poles2), imag(poles2), 'x', 'MarkerSize', 12, 'LineWidth', 2); hold on;
    plot(real(p_dom), imag(p_dom), 'o', 'MarkerSize', 8, 'LineWidth', 1.5);
    xlabel('Real(s)');
    ylabel('Imag(s)');
    title('Pole locations (s-plane)');
    legend('2^{nd}-order poles','approx pole (dominant)','Location','best');
    grid on;
    axis equal;
    % set x-limits to show poles clearly (scale adaptively)
    left = min(real(poles2)) * 1.2;
    right = 1;
    xlim([left right]);
    ylim([-1 1]);
    
    % print numeric errors to console
    fprintf('zeta = %.2f : dominant pole = %.6f, max_abs_err = %.6e, rms_err = %.6e\n', ...
            zeta, real(p_dom), max_abs_err, rms_err);
end