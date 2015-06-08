var ready;

ready = function() {

	$('#user_billing_same').click(function() {

		if ($('#user_billing_same').is(':checked')) {
			$('#user_billing_add1').val($('#user_shipping_add1').val());
			$('#user_billing_add2').val($('#user_shipping_add2').val());
			$('#user_billing_city').val($('#user_shipping_city').val());
			$('#user_billing_state').val($('#user_shipping_state').val());
			$('#user_billing_zip').val($('#user_shipping_zip').val());
			$('#user_billing_country').val($('#user_shipping_country').val());
		}

		if (!$('#user_billing_same').is(':checked')) {
			$('#user_billing_add1').val('');
			$('#user_billing_add2').val('');
			$('#user_billing_city').val('');
			$('#user_billing_state').val('');
			$('#user_billing_zip').val('');
			$('#user_billing_country').val('');
		}

	});

}

$(document).ready(ready);
$(document).on('page:load', ready);

