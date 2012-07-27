(function($){
  $.fn.acumenTestForm = function() {
    var init = function() {
      var form = $(this),
          smilesContainer = $('.answer_smiles', form),
          fieldsContainer = $('.answer_fields', form),
          smiles = $('.smile', smilesContainer),
          smilesFields = $('.field', smilesContainer),
          fields = $('.field', fieldsContainer)
          checkboxes = $('.question_fields.checkboxes .checkbox');

      smiles.each(function() {
        var smileClass = $('input', $(this))[0].className,
            smileContainer = $(this).children('span');
        smileContainer.addClass(smileClass);
      });

      smiles.click(function() {
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      });

      smilesFields.click(function() {
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      });

      fields.click(function(){
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      })

      checkboxes.click(function() {
        var that = $(this),
            checkboxInput = $('input[type=checkbox]', that),
            container = that.parents('.question_fields');

        // checkboxInput.attr('checked', !checkboxInput.attr('checked'));
        if (checkboxInput.is(':checked') == true) {
          checkboxInput.removeAttr('checked')
          that.removeClass('checked')

          checkAllCheckboxes(container);
        } else {
          checkboxInput.prop('checked', true)
          that.addClass('checked')

          checkAllCheckboxes(container);
        }
      });

      var checkAllCheckboxes = function(container) {
        var checkbox = $('input[type=checkbox]:checked', container);
        if (checkbox.length > 0) {
          container.addClass('done');
        } else {
          container.removeClass('done');
        }
      }

      var checkAnswerPresent = function(container){
        var radio = $('input[type=radio]:checked', container);
        if (radio.length > 0) {
          container.addClass('done');
        }
      };

      checkAnswerPresent();
    };

    return init.call(this);
  };
})(jQuery)
