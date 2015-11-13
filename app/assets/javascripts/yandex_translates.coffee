# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Query ->
  $('#detect_language').change ->
    text = $('#text').val()
    projects_path = $('#task_project_id').data('ajax-path')
    projects_path_with_params = "#{projects_path}?detect_lang=#{text}"

    if text
      $.ajax projects_path_with_params,
        type: 'GET'
        dataType: 'script'
