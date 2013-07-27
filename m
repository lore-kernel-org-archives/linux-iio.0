Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53032 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0J7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 05:59:15 -0400
Message-ID: <51F3A804.2000206@kernel.org>
Date: Sat, 27 Jul 2013 11:59:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 4/4] iio: adc: ad7266: Use devm_* APIs
References: <1374562210-29171-1-git-send-email-sachin.kamat@linaro.org> <51EF8AE3.6040008@metafoo.de>
In-Reply-To: <51EF8AE3.6040008@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/24/13 09:05, Lars-Peter Clausen wrote:
> On 07/23/2013 08:50 AM, Sachin Kamat wrote:
>> devm_* APIs are device managed and make code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
Thanks
> 
>> ---
>>  drivers/iio/adc/ad7266.c |   16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
>> index c2744a7..371731d 100644
>> --- a/drivers/iio/adc/ad7266.c
>> +++ b/drivers/iio/adc/ad7266.c
>> @@ -399,17 +399,17 @@ static int ad7266_probe(struct spi_device *spi)
>>  	unsigned int i;
>>  	int ret;
>>  
>> -	indio_dev = iio_device_alloc(sizeof(*st));
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>  	if (indio_dev == NULL)
>>  		return -ENOMEM;
>>  
>>  	st = iio_priv(indio_dev);
>>  
>> -	st->reg = regulator_get(&spi->dev, "vref");
>> +	st->reg = devm_regulator_get(&spi->dev, "vref");
>>  	if (!IS_ERR_OR_NULL(st->reg)) {
>>  		ret = regulator_enable(st->reg);
>>  		if (ret)
>> -			goto error_put_reg;
>> +			return ret;
>>  
>>  		ret = regulator_get_voltage(st->reg);
>>  		if (ret < 0)
>> @@ -489,11 +489,6 @@ error_free_gpios:
>>  error_disable_reg:
>>  	if (!IS_ERR_OR_NULL(st->reg))
>>  		regulator_disable(st->reg);
>> -error_put_reg:
>> -	if (!IS_ERR_OR_NULL(st->reg))
>> -		regulator_put(st->reg);
>> -
>> -	iio_device_free(indio_dev);
>>  
>>  	return ret;
>>  }
>> @@ -507,11 +502,8 @@ static int ad7266_remove(struct spi_device *spi)
>>  	iio_triggered_buffer_cleanup(indio_dev);
>>  	if (!st->fixed_addr)
>>  		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
>> -	if (!IS_ERR_OR_NULL(st->reg)) {
>> +	if (!IS_ERR_OR_NULL(st->reg))
>>  		regulator_disable(st->reg);
>> -		regulator_put(st->reg);
>> -	}
>> -	iio_device_free(indio_dev);
>>  
>>  	return 0;
>>  }
>>
> 
