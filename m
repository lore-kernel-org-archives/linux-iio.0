Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35277 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935938AbcKLOgW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 09:36:22 -0500
Subject: Re: [patch] iio:adc: ad7766: testing the wrong variable in probe
To: Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20161110193018.GB32533@mwanda>
 <62d0bc7e-45ca-6106-ace7-d33193bf49cb@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7f4f838b-9861-f294-c7c1-32cf0edaa372@kernel.org>
Date: Sat, 12 Nov 2016 14:36:16 +0000
MIME-Version: 1.0
In-Reply-To: <62d0bc7e-45ca-6106-ace7-d33193bf49cb@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/16 13:50, Lars-Peter Clausen wrote:
> On 11/10/2016 08:30 PM, Dan Carpenter wrote:
>> We should be testing "ret" here.
>>
>> Fixes: aa16c6bd0e09 ("iio:adc: Add support for AD7766/AD7767")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Applied to the togreg branch of iio.git. Will push out as testing
later for the autobuilders to play with it.

Thanks,

Jonathan
> Thanks.
> 
>>
>> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
>> index d906686..75cca42 100644
>> --- a/drivers/iio/adc/ad7766.c
>> +++ b/drivers/iio/adc/ad7766.c
>> @@ -239,8 +239,8 @@ static int ad7766_probe(struct spi_device *spi)
>>  
>>  	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg),
>>  		ad7766->reg);
>> -	if (IS_ERR(ad7766->reg))
>> -		return PTR_ERR(ad7766->reg);
>> +	if (ret)
>> +		return ret;
>>  
>>  	ad7766->pd_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
>>  		GPIOD_OUT_HIGH);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

