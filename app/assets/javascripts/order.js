var ready;

ready = function() {

	order_shipping_fields = ['#order_shipping_add1', '#order_shipping_add2', '#order_shipping_city',
		'#order_shipping_state', '#order_shipping_zip', '#order_shipping_country'];

	order_billing_fields = ['#order_billing_add1', '#order_billing_add2', '#order_billing_city',
		'#order_billing_state', '#order_billing_zip', '#order_billing_country'];

	// if billing_same is checked, disable shipping fields
	if ($('#order_billing_same').is(':checked')) {
		order_shipping_fields.forEach(function(e, i){
			$(e).prop('disabled', true);
		});
	}

	// if order check or uncheck "same as billing" box
	$('#order_billing_same').click(function() {

		// if check, fill shipping fields with billing, and disable all shipping fields
		if ($('#order_billing_same').is(':checked')) {
			order_shipping_fields.forEach(function(e, i){
				console.log($(e));
				$(e).val('');
				$(e).prop('disabled', true);
			});
		}

		// if uncheck, enable all shipping fields and delete all values
		if (!$('#order_billing_same').is(':checked')) {
			order_shipping_fields.forEach(function(e, i){
				$(e).prop('disabled', false);
			});
		}

	});

}

$(document).ready(ready);
$(document).on('page:load', ready);

