$(document).ready(function() {
	donatable_type = $('#donation_donatable_type').val();
    $('.voucher, .physical_item,.experience').hide();

    if(donatable_type == 'Voucher'){
    	$('.voucher').show();
    }else if (donatable_type == 'PhysicalItem') {
        $('.physical_item').show();
    }else if (donatable_type == 'Experience') {
        $('.experience').show();
    }
});

$(document).ready(function() {
    $('#donation_donatable_type').change(function() {
    	donatable_type = $('#donation_donatable_type').val();
        $('.voucher, .physical_item,.experience').hide();
        
    if(donatable_type == 'Voucher'){
    	$('.voucher').show();
    }else if (donatable_type == 'PhysicalItem') {
        $('.physical_item').show();
    }else if (donatable_type == 'Experience') {
        $('.experience').show();
    }

    });
});