Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47295 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaAKLtV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 06:49:21 -0500
Message-ID: <52D12FCA.3070203@kernel.org>
Date: Sat, 11 Jan 2014 11:49:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V2 1/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
References: <52C49F06.3010505@gmx.de> <52C9823C.6030606@metafoo.de>
In-Reply-To: <52C9823C.6030606@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 05/01/14 16:03, Lars-Peter Clausen wrote:
> On 01/02/2014 12:04 AM, Hartmut Knaack wrote:
>> Only free an IRQ in error_free_irq, if it has been requested previously.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
I changed the title to only mention the fix as that's all that is now in this patch.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Note that given timing this won't go upstream until after 3.14-rc1

Thanks,

Jonathan

>
>> ---
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
>> index e32a555..3deb390 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c
>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>> @@ -590,7 +590,8 @@ static int ad799x_probe(struct i2c_client *client,
>>   	return 0;
>>
>>   error_free_irq:
>> -	free_irq(client->irq, indio_dev);
>> +	if (client->irq > 0)
>> +		free_irq(client->irq, indio_dev);
>>   error_cleanup_ring:
>>   	ad799x_ring_cleanup(indio_dev);
>>   error_disable_reg:
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
