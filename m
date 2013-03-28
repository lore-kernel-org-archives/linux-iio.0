Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:37049 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab3C1Lvw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2013 07:51:52 -0400
Message-ID: <51542ED5.4090200@free-electrons.com>
Date: Thu, 28 Mar 2013 12:51:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>,
	brian@crystalfontz.com, linux-iio@vger.kernel.org, jimwall@q.com,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mxs-lradc: Do hardware initialization earlier
References: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com> <201303281222.21285.marex@denx.de>
In-Reply-To: <201303281222.21285.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/2013 12:22, Marek Vasut wrote:
> Dear Alexandre Belloni,
>
>> We need to initialize hardware before registering the touchscreen. Else,
>> we end up setting registers in mxs_lradc_ts_open(), getting called just
>> after registering the touchscreen with input_register_device() and by
>> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
>> correct configuration.
>>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index 55a459b..e927e3f 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -933,6 +933,9 @@ static int mxs_lradc_probe(struct platform_device
>> *pdev)
>>
>>  	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
>>
>> +	/* Configure the hardware. */
>> +	mxs_lradc_hw_init(lradc);
>> +
>>  	/* Check if touchscreen is enabled in DT. */
>>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> Isn't this too early? At least lradc->use_touchscreen is configured only after 
> you call mxs_lradc_hw_init() in this case, while mxs_lradc_hw_init() uses it's 
> value.
>
> I think mxs_lradc_hw_init() shall be called just before mxs_lradc_ts_register().
>
>
That's right, this would break 5 wires touchscreens. I'll fix that.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

