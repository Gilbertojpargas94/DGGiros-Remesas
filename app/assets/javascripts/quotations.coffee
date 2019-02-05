# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	$('#quotation_country').change ->
		$.ajax '/get_rates',
		    type: 'GET'
		    data:{ 
		      country: $('#quotation_country').val()
		    }
		    dataType: 'script'
		    error: (jqXHR, textStatus, errorThrown) ->
      			console.log("AJAX Error: #{textStatus}")
      		success: (data, textStatus, jqXHR) ->
      			console.log("PAIS SELECIONADO CORECTAMENTE OK!")
		return		

	$('#banks').change ->
		$.ajax '/get_banks',
		    type: 'GET'
		    data:{ 
		      name: $('#banks').val()
		    }
		    dataType: 'script'
		    error: (jqXHR, textStatus, errorThrown) ->
      			console.log("AJAX Error: #{textStatus}")
      		success: (data, textStatus, jqXHR) ->
      			console.log("BANCO SELECIONADO CORECTAMENTE OK!")
		return

	$('#cantidadenviar').change ->
		if $('#quotation_country').val().toLowerCase() == 'colombia'
			if $('#tasa').val() == '0.0'
				$('#result_amount').val(0)
			else
				$('#result_amount').val(($('#cantidadenviar').val() / $('#tasa').val()).toFixed(2))
		else
			$('#result_amount').val($('#tasa').val() *  $('#cantidadenviar').val())
		return
	return
