$(document).ready(function() {
<<<<<<< HEAD

  $(".delete_ans").on('click', function() {
    id = parseInt($(this).attr("id"));
    $("#word_answers_attributes_"+id+"__destroy").prop('value', true);
    $(this).parent().parent().slideUp(100).remove();
    number = 1;
    $('.label_answer').each(function(){
        $(this).attr("number",number);
        $(this).html("Answer "+ number);
        number++
    });
  })

  $(".answer_radio").on('click', function() {
=======
  $(".insertanswer").click(function() {
    var numItems = parseInt($('.label_answer').length)
    html  = '<div class="form-group">';
    html += '<label class="label_answer">Answer&nbsp'+(numItems+1)+'</label>';
    html += '<span class="pull-right">Is true';
    html += '<input type="checkbox" id="word_answers_attributes_'+numItems+'_status" name="word[answers_attributes]['+numItems+'][status]" value="1" class="answer_radio">';
    html += '</span>';
    html += '<div class="input-group">';
    html += '<textarea class="form-control" name="word[answers_attributes]['+numItems+'][body]"></textarea>';
    html += '<a href="javascript:void(0)" class="input-group-addon delete_ans">';
    html += '<i class="glyphicon glyphicon-remove"></i></a>';
    html += '</div>';
    $("#answer").append(html);
  });

  $(".delete_ans").live("click", function() {
    id = parseInt($(this).attr("id"));
    $("#word_answers_attributes_"+id+"__destroy").prop('value', true);
    $(this).parent().parent().slideUp(100).remove();
    thutu = 1;
    $('.label_answer').each(function(){
        $(this).attr("thutu",thutu);
        $(this).html("Answer "+ thutu);
        thutu++
    });
  })

  $(".answer_radio").live('click', function() {
>>>>>>> Admin manager: word and answer
    $(".answer_radio").prop('checked', false);
    $(".answer_radio").prop('value', false);
    $(this).prop('checked', true);
    $(this).prop('value', true);
  })
})