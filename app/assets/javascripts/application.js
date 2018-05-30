// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs

//= require tableExport
//= require bootstrap-table
//= require bootstrap-table-export
//= require bootstrap-table-mobile
//= require bootstrap-table-pt-BR

//= require bootstrap-sprockets
//= require adminlte
//= require chosen-jquery
//= require cocoon

//= require simple-lightbox
//= require jquery.justifiedGallery

//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR
//= require maskedinput

//= require magicsuggest
//= require jquery.blockUI
//= require blockUI

//= require js.cookie

function apply_chosen() {
    $(".chosen-select").attr("data-placeholder", "Escolha uma opção...");

    $('.chosen-select').chosen({
        allow_single_deselect: true,
        no_results_text: 'Não encontrado',
        width: '100%'
    });
}

function is_fixed() {
    document.getElementById("expense_is_fixed_value").checked = false;
    $("#expense_is_fixed_value").change(function() {
        if(this.checked) {
            $("#expense_apartment_id").val('');
            $("#expense_apartment_id").attr('disabled','disabled');
        }else{
            $("#expense_apartment_id").removeAttr('disabled');
        }
    });
}

$(document).ready(function () {
    is_fixed();

    $("#galeria_jutified").justifiedGallery({
        rowHeight: 120,
        lastRow: 'nojustify',
        margins: 2
    });

    $('.galeria_photos a').simpleLightbox({
        captionPosition: 'top',
        captionClass: 'simpleLightboxCaption',
        className: 'simple-lightbox'
    });

    $('.galeria_timeline a').simpleLightbox({
        captionPosition: 'top',
        captionClass: 'simpleLightboxCaption',
        className: 'simple-lightbox'
    });

    $('.datepicker').datepicker({
        language: 'pt-BR',
    });

    $(".monthpicker").datepicker( {
        format: "mm-yyyy",
        startView: "months",
        minViewMode: "months"
    });

    apply_chosen();

    $('#family_compositions').on('cocoon:after-insert', function (e, insertedItem) {
        apply_chosen();
    });

    $('#documents').on('cocoon:after-insert', function (e, insertedItem) {
        apply_chosen();
    });

    // tamanho limitado
    $('.bootstrap-table').bootstrapTable({
        showExport: false,
        search: false,
        striped: true,
        mobileResponsive: true
    });

    $(".addon_icon").keyup(function () {
        $(this).next().find("i").attr("class", "fa " + $(this).val());
    });

    $(".addon_color").keyup(function () {
        $(this).next().attr("class", "input-group-addon " + $(this).val());
    });

    // Fixar o campo de pesquisa ao colocar o foco no campo input
    $('input').focusin(function () {
        $('.has-feedback').addClass("showClass");
    });

    $('input').focusout(function () {
        $('.has-feedback').removeClass("showClass");
    });

    $('#photos').on('cocoon:after-insert', function (e, insertedItem) {
        $("input[id$=_avatar]:last").fileinput({
            language: 'pt-BR',
            'previewFileType': 'any',
            allowedFileExtensions: ['jpg', 'jpeg', 'png'],
            showRemove: false,
            showClose: false,
            showUpload: false
        });
        $("input[id$=_tag_list]:last").magicSuggest({
            data: $("#tags").data("tags")
        });
    });

    $("input[id$=_tag_list]").each(function (i, el) {
        $($(this)).magicSuggest({
            data: $("#tags").data("tags")
        });
    });

    $("input[id$=_avatar]").each(function (i, el) {
        $($(this)).fileinput({
            language: 'pt-BR',
            'previewFileType': 'any',
            initialPreviewAsData: true,
            initialPreview: $(this).data('url'),
            initialPreviewConfig: [
                {caption: "Moon.jpg", height: 'auto', widht: '120px', showDelete: false, showDrag: false, key: 1}
            ],
            allowedFileExtensions: ['jpg', 'jpeg', 'png'],
            showRemove: false,
            showClose: false,
            showUpload: false
        });
    });
});
