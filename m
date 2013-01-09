Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38758 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484Ab3AIUHU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 15:07:20 -0500
Message-ID: <50EDCDF6.6040806@kernel.org>
Date: Wed, 09 Jan 2013 20:07:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: indexes are unsigned
References: <1357607117-5868-1-git-send-email-festevam@gmail.com> <201301080757.56301.marex@denx.de>
In-Reply-To: <201301080757.56301.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/2013 06:57 AM, Marek Vasut wrote:
> Dear Fabio Estevam,
> 
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Fix the following warning when building with W=1 option:
>>
>> drivers/staging/iio/adc/mxs-lradc.c: In function
>> 'mxs_lradc_trigger_handler': drivers/staging/iio/adc/mxs-lradc.c:244:2:
>> warning: comparison between signed and unsigned integer expressions
>> [-Wsign-compare]
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Maybe use "unsigned int" instead? Either way:
>
Agreed, I've switched it over on the assumption no one will mind.

If one of you wants to check I didn't do anything silly
that would be great.
> Acked-by: Marek Vasut <marex@denx.de>
added to fixes-togreg branch of iio.git on git.kernel.org
> 
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index fb31b45..6cf3af8 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -239,7 +239,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq,
>> void *p) struct mxs_lradc *lradc = iio_priv(iio);
>>  	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
>>  		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
>> -	int i, j = 0;
>> +	u32 i, j = 0;
>>
>>  	for_each_set_bit(i, iio->active_scan_mask, iio->masklength) {
>>  		lradc->buffer[j] = readl(lradc->base + LRADC_CH(j));
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
