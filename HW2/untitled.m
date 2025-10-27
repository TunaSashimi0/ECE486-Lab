sys1 = tf ([1], [1 2 20]);
sys2 = tf ([1,-3], [1 2 20]);
sys3 = tf ([1 3 2], [1 0 9 0 0 20]);
sys4 = tf ([1 3], [1 0 0 0 0 1]);

figure;
rlocus (sys1);
figure;
rlocus (sys2);
figure;
rlocus(sys3);
figure;
rlocus(sys4);