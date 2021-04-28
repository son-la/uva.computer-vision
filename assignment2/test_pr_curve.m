load('data.mat');
[p, r, AUC] = pr_curve(score, gt);
[sol_p, sol_r, sol_AUC] = sol_pr_curve(score, gt);
p_err = sum(sol_p - p)
r_err = sum(sol_r - r)
AUC_err = sum(sol_AUC - AUC)

