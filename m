Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:44032 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186Ab3IWKxv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 Sep 2013 06:53:51 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>
Date: Mon, 23 Sep 2013 12:53:36 +0200
Subject: Re: [PATCH 4/4] iio:press: Register buffer also without specific
 trigger
Message-ID: <52401DB0.3070305@st.com>
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
 <1379494822-9985-5-git-send-email-denis.ciocca@st.com>
 <523DB27F.2000506@kernel.org>
In-Reply-To: <523DB27F.2000506@kernel.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks Jonathan!

all is fine...;)

Denis


> On 09/18/13 10:00, Denis CIOCCA wrote:
>> This patch fix buffer registration that allows to use generic IIO trigger.
>>
>> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> Forward ported and applied to the togreg branch of iio.git  Thanks,
>
> Please do confirm I didn't do anything silly, but the port to the code
> Lee updated seemed trivial so I'd rather do it and clear the patches
> out of my queue ;)
>
>> ---
>>   drivers/iio/pressure/st_pressure_core.c |   17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
>> index 93bff9b..312a093 100644
>> --- a/drivers/iio/pressure/st_pressure_core.c
>> +++ b/drivers/iio/pressure/st_pressure_core.c
>> @@ -262,11 +262,11 @@ int st_press_common_probe(struct iio_dev *indio_dev,
>>   	if (err < 0)
>>   		goto st_press_common_probe_error;
>>   
>> -	if (pdata->get_irq_data_ready(indio_dev) > 0) {
>> -		err = st_press_allocate_ring(indio_dev);
>> -		if (err < 0)
>> -			goto st_press_common_probe_error;
>> +	err = st_press_allocate_ring(indio_dev);
>> +	if (err < 0)
>> +		goto st_press_common_probe_error;
>>   
>> +	if (pdata->get_irq_data_ready(indio_dev) > 0) {
>>   		err = st_sensors_allocate_trigger(indio_dev,
>>   							ST_PRESS_TRIGGER_OPS);
>>   		if (err < 0)
>> @@ -283,8 +283,7 @@ st_press_device_register_error:
>>   	if (pdata->get_irq_data_ready(indio_dev) > 0)
>>   		st_sensors_deallocate_trigger(indio_dev);
>>   st_press_probe_trigger_error:
>> -	if (pdata->get_irq_data_ready(indio_dev) > 0)
>> -		st_press_deallocate_ring(indio_dev);
>> +	st_press_deallocate_ring(indio_dev);
>>   st_press_common_probe_error:
>>   	return err;
>>   }
>> @@ -295,10 +294,10 @@ void st_press_common_remove(struct iio_dev *indio_dev)
>>   	struct st_sensor_data *pdata = iio_priv(indio_dev);
>>   
>>   	iio_device_unregister(indio_dev);
>> -	if (pdata->get_irq_data_ready(indio_dev) > 0) {
>> +	if (pdata->get_irq_data_ready(indio_dev) > 0)
>>   		st_sensors_deallocate_trigger(indio_dev);
>> -		st_press_deallocate_ring(indio_dev);
>> -	}
>> +
>> +	st_press_deallocate_ring(indio_dev);
>>   }
>>   EXPORT_SYMBOL(st_press_common_remove);
>>   
>>
