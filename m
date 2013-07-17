Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:36993 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab3GQIMI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 04:12:08 -0400
Message-ID: <51E651D5.7050906@atmel.com>
Date: Wed, 17 Jul 2013 10:12:05 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Josh Wu <josh.wu@atmel.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-3-git-send-email-josh.wu@atmel.com> <20130715125815.GC2962@lukather>
In-Reply-To: <20130715125815.GC2962@lukather>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/07/2013 14:58, Maxime Ripard :
> Hi Josh,
>
> On Sun, Jul 14, 2013 at 04:04:26PM +0800, Josh Wu wrote:
>> For at91 boards, there are different IPs for adc. Different IPs has different
>> STARTUP & PRESCAL mask in ADC_MR.
>>
>> This patch can change the masks according to the different IP version.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>   arch/arm/mach-at91/include/mach/at91_adc.h |    9 ++++--
>>   drivers/iio/adc/at91_adc.c                 |   48 ++++++++++++++++++++++++++--
>>   2 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
>> index 8e7ed5c..ab273ee 100644
>> --- a/arch/arm/mach-at91/include/mach/at91_adc.h
>> +++ b/arch/arm/mach-at91/include/mach/at91_adc.h
>> @@ -28,9 +28,12 @@
>>   #define			AT91_ADC_TRGSEL_EXTERNAL	(6 << 1)
>>   #define		AT91_ADC_LOWRES		(1 << 4)	/* Low Resolution */
>>   #define		AT91_ADC_SLEEP		(1 << 5)	/* Sleep Mode */
>> -#define		AT91_ADC_PRESCAL	(0x3f << 8)	/* Prescalar Rate Selection */
>> +#define		AT91_ADC_PRESCAL	(0xff << 8)	/* Prescalar Rate Selection */
>> +#define		AT91_ADC_PRESCAL_9260	(0x3f << 8)
>>   #define			AT91_ADC_PRESCAL_(x)	((x) << 8)
>> -#define		AT91_ADC_STARTUP	(0x1f << 16)	/* Startup Up Time */
>> +#define		AT91_ADC_STARTUP	(0xf << 16)	/* Startup Up Time */
>> +#define		AT91_ADC_STARTUP_9260	(0x1f << 16)
>> +#define		AT91_ADC_STARTUP_9G45	(0x7f << 16)
>>   #define			AT91_ADC_STARTUP_(x)	((x) << 16)
>>   #define		AT91_ADC_SHTIM		(0xf  << 24)	/* Sample & Hold Time */
>>   #define			AT91_ADC_SHTIM_(x)	((x) << 24)
>> @@ -58,4 +61,6 @@
>>   #define AT91_ADC_CHR(n)		(0x30 + ((n) * 4))	/* Channel Data Register N */
>>   #define		AT91_ADC_DATA		(0x3ff)
>>
>> +#define AT91_ADC_VERSION	0xFC
>> +
>>   #endif
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 18bd54f..14e99ba 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -39,6 +39,12 @@
>>   #define at91_adc_writel(st, reg, val) \
>>   	(writel_relaxed(val, st->reg_base + reg))
>>
>> +struct at91_adc_caps {
>> +	bool	has_tsmr;	/* only at91sam9x5, sama5d3 have TSMR reg */
>> +	u32	mr_prescal_mask;
>> +	u32	mr_startup_mask;
>> +};
>> +
>>   struct at91_adc_state {
>>   	struct clk		*adc_clk;
>>   	u16			*buffer;
>> @@ -62,6 +68,7 @@ struct at91_adc_state {
>>   	u32			res;		/* resolution used for convertions */
>>   	bool			low_res;	/* the resolution corresponds to the lowest one */
>>   	wait_queue_head_t	wq_data_avail;
>> +	struct at91_adc_caps	caps;
>>   };
>>
>>   static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>> @@ -580,6 +587,41 @@ static const struct iio_info at91_adc_info = {
>>   	.read_raw = &at91_adc_read_raw,
>>   };
>>
>> +/*
>> + * Since atmel adc support different ip for touchscreen mode. Through the
>> + * IP check, we will know the touchscreen capbilities.
>> + */
>> +static void atmel_adc_get_cap(struct at91_adc_state *st)
>> +{
>> +	unsigned int version;
>> +	struct iio_dev *idev = iio_priv_to_dev(st);
>> +
>> +	version = at91_adc_readl(st, AT91_ADC_VERSION);
>> +	dev_dbg(&idev->dev, "version: 0x%x\n", version);
>> +
>> +	st->caps.mr_prescal_mask = AT91_ADC_PRESCAL_9260;
>> +	st->caps.mr_startup_mask = AT91_ADC_STARTUP_9260;
>> +
>> +	/* keep only major version number */
>> +	switch (version & 0xf00) {
>> +	case 0x500:	/* SAMA5D3 */
>> +	case 0x400:	/* AT91SAM9X5/9N12 */
>> +		st->caps.has_tsmr = 1;
>> +		st->caps.mr_startup_mask = AT91_ADC_STARTUP;
>> +	case 0x200:	/* AT91SAM9M10/9G45 */
>> +		st->caps.mr_prescal_mask = AT91_ADC_PRESCAL;
>> +
>> +		if ((version & 0xf00) == 0x200)
>> +			st->caps.mr_startup_mask = AT91_ADC_STARTUP_9G45;
>> +	case 0x100:	/* AT91SAM9260/9G20 */
>> +		break;
>> +	default:
>> +		dev_warn(&idev->dev,
>> +				"Unmanaged adc version, use minimal capabilities\n");
>> +		break;
>> +	};
>> +}
>
> Why don't you use different compatible names and derive your
> capabilities from which compatible is declared.

Do not forget that we still have a handful of platforms that do not 
support DT (and never will).

Josh, do you think that we can deal with this with different compatible 
string instead of checking the IP revision?

Bye,
-- 
Nicolas Ferre
