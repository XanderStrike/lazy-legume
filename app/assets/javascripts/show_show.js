function tokenizeStr(str) {
  return str.toLowerCase().split(/\W/).filter(function(v){return v!==''}).join('.*');
}

function regexTitle() {
  return tokenizeStr($('.js-show-title').text());
}

function buildRegexForRule(form_id) {
  var regex_field = $(form_id + ' #rule_regex');

  var keywords = $(form_id + ' #rule_keywords').val();
  var quality = $(form_id + ' #rule_quality').val();

  var regex = '';

  (keywords != '') && (regex += tokenizeStr(keywords));
  (quality != '') && (regex += '.*' + quality);

  regex_field.val(regex);
}

function attachChangeHandlers(form_id) {
  $(form_id + ' #rule_keywords').keyup(function () {
    buildRegexForRule(form_id);
  });
  $(form_id + ' #rule_quality').change(function () {
    buildRegexForRule(form_id);
  });

  $(form_id + ' #rule_regex').click(function() {
    $(this).removeAttr('readonly');
  })
}

function initialize() {
  $('.edit_rule').map(function() {
    attachChangeHandlers('#' + this.id);
  });
}

$(document).ready(initialize);
