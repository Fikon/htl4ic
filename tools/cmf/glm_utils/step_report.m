function step_report(factorname, normchange, unchanged, condition, m, ...
                     stepsize, delta, params)
% step_report - Produce the summary for a step.
%
% step_report(factorname, normchange, unchanged, condition, m, ...
%             stepsize, delta, params)
% Handles global summary for a factor update (reporting statistics on the
% condition number of the covaraince, the number of changed rows, and the
% average norm change).
%
% Arguments:
%
% factorname: String description of the factor (e.g., 'U').
% normchange: The change in L2 norm after an update of the factor.
% unchanged: The number of unchanged rows
% condition: The condition number of the covariance in each row update.
% m: Number of rows total.
% stepsize: Vector of stepsize's for each row (1 x m)
% delta: The change in the objective due to updating U.
% params: Global parameters.

LogIf(params.check_condition_number && ...
      params.debug_summary_condition_number, ...
      'Condition %s: %g %g %g\n', factorname, ...
      min(condition), median(condition), max(condition));

stepsize = stepsize(isfinite(stepsize));
if isempty(stepsize)
  stepsize = [0];
end
fprintf(1,'Num unchanged %s: %d/%d , eta: min/mean/max = %.2g/%.2g/%.2g , delta = %g , mean l2 norm change: %f\n', factorname, ...
      unchanged, m, min(stepsize), mean(stepsize), max(stepsize), delta,normchange);



