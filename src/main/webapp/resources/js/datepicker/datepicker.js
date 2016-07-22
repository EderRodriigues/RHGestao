/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function () {
//    $.extend($.fn.datepicker.defaults, {format: 'dd-mm-yyyy', language: 'pt-BR'} );
   
    $.fn.datepicker.defaults.language = "pt-BR";
    $('#dtAdmissao').datepicker({
        format: 'dd-mm-yyyy',
        language: 'pt-BR'
    });
    $('.dtpicker').datepicker({
        format: 'dd-mm-yyyy',
        language: 'pt-BR'
    });
    $('#dtpicker2').datepicker({
        format: 'dd-mm-yyyy',
        language: 'pt-BR'
    });
});
$("li").addClass("active");