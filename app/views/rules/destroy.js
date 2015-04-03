$('#js-rules-area').html('<%=j render partial: "rules/rules_list", locals: { show: @show, rule: @rule } %>');
$('#js-rules-notice').html('<%=j bootstrap_alert("danger", "Rule destroyed.").html_safe %>');
