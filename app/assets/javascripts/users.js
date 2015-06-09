var ready;

ready = function() {

	shipping_fields = ['#user_shipping_add1', '#user_shipping_add2', '#user_shipping_city',
		'#user_shipping_state', '#user_shipping_zip', '#user_shipping_country'];

	billing_fields = ['#user_billing_add1', '#user_billing_add2', '#user_billing_city',
		'#user_billing_state', '#user_billing_zip', '#user_billing_country'];

	// if user check or uncheck "same as billing" box
	$('#user_billing_same').click(function() {

		// if check, fill shipping fields with billing, and disable all shipping fields
		if ($('#user_billing_same').is(':checked')) {
			shipping_fields.forEach(function(e, i){
				$(e).val( $(billing_fields[i]).val() );
				$(e).prop('disabled', true)
			});
		}

		// if uncheck, enable all shipping fields and delete all values
		if (!$('#user_billing_same').is(':checked')) {
			shipping_fields.forEach(function(e, i){
				$(e).val('');
				$(e).prop('disabled', false)
			});
		}

	});

	// if "same as billing" is checked, any billing field changes
	// will change the corresponding shipping field
	shipping_fields.forEach(function(e,i){
		$(billing_fields[i]).change(function() {
			if ($('#user_billing_same').is(':checked')) {
				$(e).val( $(billing_fields[i]).val() );
			}
		});
	});

}

$(document).ready(ready);
$(document).on('page:load', ready);

