$(function() {
  var monthsBeforeEvent = function() {
    var plannedYear = parseInt($('#goal_planned_date_1i').val()),
        plannedMonth = parseInt($('#goal_planned_date_2i').val()),
        d1 = new Date(),
        d2 = new Date(plannedYear, plannedMonth),
        monthsDiff;

    monthsDiff = (d2.getFullYear() - d1.getFullYear()) * 12;
    monthsDiff -= d1.getMonth() + 1;
    monthsDiff += d2.getMonth();
    return monthsDiff;
  };

  var calculateContribution = function() {
    var amount = parseFloat($('#goal_amount').val()),
        balance = parseFloat($('#goal_current_balance').text()),
        contribution = $('#goal_contribution').val();

    var monthlyContribution = Math.round((amount - balance) / monthsBeforeEvent());
    $('#goal_contribution').val(monthlyContribution);
  };

  presentContributionToUser = function() {
    var fields = _([$('#goal_amount'), $('#goal_current_balance'), $('#goal_planned_date_1i'), $('#goal_planned_date_2i')]);
    fields.each(function(elem) { elem.bind('change', function() {calculateContribution()})});
  };

  presentContributionToUser();
});
