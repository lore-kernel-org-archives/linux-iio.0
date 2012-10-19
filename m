Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58449 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759052Ab2JSRmy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:54 -0400
Message-ID: <50817118.80807@kernel.org>
Date: Fri, 19 Oct 2012 16:26:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio:lpc32xx_adc: Use resource_size instead
 of opencoding it
References: <1350571399-17723-1-git-send-email-lars@metafoo.de> <1350571399-17723-2-git-send-email-lars@metafoo.de> <50802B4F.3040709@antcom.de>
In-Reply-To: <50802B4F.3040709@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2012 05:16 PM, Roland Stigge wrote:
> On 10/18/2012 04:43 PM, Lars-Peter Clausen wrote:
>> Fixes the following error from coccicheck:
>> 	drivers/staging/iio/adc/lpc32xx_adc.c:153:43-46: ERROR: Missing resource_size with res
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Acked-by: Roland Stigge <stigge@antcom.de>
Applied to togreg branch of iio.git
> 
>> Cc: Roland Stigge <stigge@antcom.de>
>> ---
>>  drivers/staging/iio/adc/lpc32xx_adc.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
>> index 7e9bd00..10c5962 100644
>> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
>> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
>> @@ -150,7 +150,7 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
>>  
>>  	info = iio_priv(iodev);
>>  
>> -	info->adc_base = ioremap(res->start, res->end - res->start + 1);
>> +	info->adc_base = ioremap(res->start, resource_size(res));
>>  	if (!info->adc_base) {
>>  		dev_err(&pdev->dev, "failed mapping memory\n");
>>  		retval = -EBUSY;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
