Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57171 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2FRLG3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 07:06:29 -0400
Message-ID: <4FDF0BAF.1040101@cam.ac.uk>
Date: Mon, 18 Jun 2012 12:06:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [v2 4/9] staging:iio:adc:ad7298: Use new triggered buffer setup
 helper function
References: <1339145332-26811-1-git-send-email-lars@metafoo.de> <1339145332-26811-4-git-send-email-lars@metafoo.de> <4FDEF8D0.6040504@metafoo.de>
In-Reply-To: <4FDEF8D0.6040504@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/18/2012 10:45 AM, Lars-Peter Clausen wrote:
> On 06/08/2012 10:48 AM, Lars-Peter Clausen wrote:
>> Use the new triggered buffer setup helper function to allocate and register
>> buffer and pollfunc.
>>
>> Also as part of the conversion drop scan_timestamp being enabled by default,
>> since it is a left over of an earlier cleanup.
>>
>> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
>> Acked-by: Jonathan Cameron<jic23@kernel.org>
>> ---
>>   drivers/staging/iio/adc/Kconfig       |    1 +
>>   drivers/staging/iio/adc/ad7298.h      |    5 +++
>>   drivers/staging/iio/adc/ad7298_core.c |   11 ++----
>>   drivers/staging/iio/adc/ad7298_ring.c |   64 ++++++---------------------------
>>   4 files changed, 18 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index c01df61..bb6fffd 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -13,6 +13,7 @@ config AD7291
>>   config AD7298
>>   	tristate "Analog Devices AD7298 ADC driver"
>>   	depends on SPI
>> +	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
>>   	help
>>   	  Say yes here to build support for Analog Devices AD7298
>>   	  8 Channel ADC with temperature sensor.
>> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
>> index 5051a7e..18f2787 100644
>> --- a/drivers/staging/iio/adc/ad7298.h
>> +++ b/drivers/staging/iio/adc/ad7298.h
>> @@ -55,6 +55,8 @@ struct ad7298_state {
>>   #ifdef CONFIG_IIO_BUFFER
>>   int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>>   void ad7298_ring_cleanup(struct iio_dev *indio_dev);
>> +int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>> +	const unsigned long *active_scan_mask);
>>   #else /* CONFIG_IIO_BUFFER */
>>
>>   static inline int
>> @@ -66,5 +68,8 @@ ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>>   static inline void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>>   {
>>   }
>> +
>> +#define ad7298_update_scan_mode NULL
>> +
>>   #endif /* CONFIG_IIO_BUFFER */
>>   #endif /* IIO_ADC_AD7298_H_ */
>> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
>> index c90f2b3..5e68bad 100644
>> --- a/drivers/staging/iio/adc/ad7298_core.c
>> +++ b/drivers/staging/iio/adc/ad7298_core.c
>> @@ -171,6 +171,7 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>>
>>   static const struct iio_info ad7298_info = {
>>   	.read_raw =&ad7298_read_raw,
>> +	.update_scan_mode = ad7298_update_scan_mode,
>>   	.driver_module = THIS_MODULE,
>>   };
>>
>> @@ -231,19 +232,12 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>>   	if (ret)
>>   		goto error_disable_reg;
>>
>> -	ret = iio_buffer_register(indio_dev,
>> -				&ad7298_channels[1], /* skip temp0 */
>> -				  ARRAY_SIZE(ad7298_channels) - 1);
>
> Ah, dammit... I guess it's always a good idea to do a final thorough review.
>
> I think we had this discussion before and the reason why iio_buffer_register
> take the channels and num_channels because the channels which can be used in
> buffered mode maybe a subset of the total channels. But right now these
> channels have to be either at the beginning or the end of the channel spec.
> I wonder if the following might be a better alternative:
Works for me.
>
> diff --git a/drivers/iio/industrialio-buffer.c
> b/drivers/iio/industrialio-buffer.c
> index 2f35db9..3d8d187 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>   	if (channels) {
>   		/* new magic */
>   		for (i = 0; i<  num_channels; i++) {
> +			if (channels[i].scan_index<  0)
> +				continue;
> +
>   			/* Establish necessary mask length */
>   			if (channels[i].scan_index>
>   			(int)indio_dev->masklength - 1)

