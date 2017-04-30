Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34764 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756818AbdD3QX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:23:29 -0400
Subject: Re: [PATCH] Fix check-patch symbolic permissions warnings
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Swain <dudebrobro179@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <20170428230307.23491-1-dudebrobro179@gmail.com>
 <20170428230307.23491-2-dudebrobro179@gmail.com>
 <85a3789a-ec2b-67aa-88c7-3a66f0cf1eee@kernel.org>
Message-ID: <0c04f7ec-2412-c5b6-936b-42bb6023dfc2@kernel.org>
Date: Sun, 30 Apr 2017 17:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <85a3789a-ec2b-67aa-88c7-3a66f0cf1eee@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/17 17:22, Jonathan Cameron wrote:
> On 29/04/17 00:03, Quentin Swain wrote:
> A short description of why would have been good.
> 
> Anyhow, applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
oops. I didn't check my git output.  A similar patch has already
been applied.

Sorry about that!

Jonathan
> 
> Thanks,
> 
> Jonathan
>> ---
>>  drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
>> index af3910b..c63fe6a 100644
>> --- a/drivers/staging/iio/light/tsl2x7x_core.c
>> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
>> @@ -1498,34 +1498,34 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>>  	return 0;
>>  }
>>  
>> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(power_state, 0644,
>>  		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
>>  
>> -static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
>> +static DEVICE_ATTR(in_proximity0_calibscale_available, 0444,
>>  		tsl2x7x_prox_gain_available_show, NULL);
>>  
>> -static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
>> +static DEVICE_ATTR(in_illuminance0_calibscale_available, 0444,
>>  		tsl2x7x_gain_available_show, NULL);
>>  
>> -static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(in_illuminance0_integration_time, 0644,
>>  		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
>>  
>> -static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(in_illuminance0_target_input, 0644,
>>  		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
>>  
>> -static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
>> +static DEVICE_ATTR(in_illuminance0_calibrate, 0200, NULL,
>>  		tsl2x7x_do_calibrate);
>>  
>> -static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
>> +static DEVICE_ATTR(in_proximity0_calibrate, 0200, NULL,
>>  		tsl2x7x_do_prox_calibrate);
>>  
>> -static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(in_illuminance0_lux_table, 0644,
>>  		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
>>  
>> -static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(in_intensity0_thresh_period, 0644,
>>  		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
>>  
>> -static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(in_proximity0_thresh_period, 0644,
>>  		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
>>  
>>  /* Use the default register values to identify the Taos device */
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

