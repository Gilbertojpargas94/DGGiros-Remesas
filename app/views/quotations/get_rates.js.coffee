<% if not @rate.nil? %>
$("#tasa").empty().val(<%= @rate.value %>);
<% if @rate.country.downcase == 'colombia' %> 
$('#result_amount').val(($('#cantidadenviar').val() / $('#tasa').val()).toFixed(2));
<%else%>
$('#result_amount').val($('#tasa').val() *  $('#cantidadenviar').val());
<%end%>
<%else%>
$("#tasa").empty().val(0);
$('#result_amount').val(0);
<%end%>