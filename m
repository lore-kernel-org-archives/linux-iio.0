Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56059 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaC3SOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 30 Mar 2014 14:14:02 -0400
Message-ID: <53385F2F.2000208@kernel.org>
Date: Sun, 30 Mar 2014 19:15:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 1/4] staging:iio:adc:spear adc - prefix defines to avoid
 namespace clashes.
References: <1394895308-19154-1-git-send-email-jic23@kernel.org> <1394895308-19154-2-git-send-email-jic23@kernel.org> <5324ED56.8010702@gmx.de>
In-Reply-To: <5324ED56.8010702@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/14 00:16, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Stefan Roese <sr@denx.de>
>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 73 ++++++++++++++++++-------------------
>>   1 file changed, 36 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
>> index 970d9ed..9234e05 100644
>> --- a/drivers/staging/iio/adc/spear_adc.c
>> +++ b/drivers/staging/iio/adc/spear_adc.c
>> @@ -22,39 +22,36 @@
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>>
>> -/*
>> - * SPEAR registers definitions
>> - */
>> -
>> -#define SCAN_RATE_LO(x)		((x) & 0xFFFF)
>> -#define SCAN_RATE_HI(x)		(((x) >> 0x10) & 0xFFFF)
>> -#define CLK_LOW(x)		(((x) & 0xf) << 0)
>> -#define CLK_HIGH(x)		(((x) & 0xf) << 4)
>> +/* SPEAR registers definitions */
>> +#define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
>> +#define SPEAR600_ADC_SCAN_RATE_HI(x)	(((x) >> 0x10) & 0xFFFF)
>> +#define SPEAR_ADC_CLK_LOW(x)		(((x) & 0xf) << 0)
>> +#define SPEAR_ADC_CLK_HIGH(x)		(((x) & 0xf) << 4)
>>
>>   /* Bit definitions for SPEAR_ADC_STATUS */
>> -#define START_CONVERSION	(1 << 0)
>> -#define CHANNEL_NUM(x)		((x) << 1)
>> -#define ADC_ENABLE		(1 << 4)
>> -#define AVG_SAMPLE(x)		((x) << 5)
>> -#define VREF_INTERNAL		(1 << 9)
>> +#define SPEAR_ADC_STATUS_START_CONVERSION	(1 << 0)
>> +#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
>> +#define SPEAR_ADC_STATUS_ADC_ENABLE		(1 << 4)
>> +#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
>> +#define SPEAR_ADC_STATUS_VREF_INTERNAL		(1 << 9)
>>
>> -#define DATA_MASK		0x03ff
>> -#define DATA_BITS		10
>> +#define SPEAR_ADC_DATA_MASK		0x03ff
>> +#define SPEAR_ADC_DATA_BITS		10
>>
>> -#define MOD_NAME "spear-adc"
>> +#define SPEAR_ADC_MOD_NAME "spear-adc"
>>
>> -#define ADC_CHANNEL_NUM		8
>> +#define SPEAR_ADC_CHANNEL_NUM		8
>>
>> -#define CLK_MIN			2500000
>> -#define CLK_MAX			20000000
>> +#define SPEAR_ADC_CLK_MIN			2500000
>> +#define SPEAR_ADC_CLK_MAX			20000000
>>
>>   struct adc_regs_spear3xx {
>>   	u32 status;
>>   	u32 average;
>>   	u32 scan_rate;
>>   	u32 clk;	/* Not avail for 1340 & 1310 */
>> -	u32 ch_ctrl[ADC_CHANNEL_NUM];
>> -	u32 ch_data[ADC_CHANNEL_NUM];
>> +	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
>> +	u32 ch_data[SPEAR_ADC_CHANNEL_NUM];
>>   };
>>
>>   struct chan_data {
>> @@ -66,8 +63,8 @@ struct adc_regs_spear6xx {
>>   	u32 status;
>>   	u32 pad[2];
>>   	u32 clk;
>> -	u32 ch_ctrl[ADC_CHANNEL_NUM];
>> -	struct chan_data ch_data[ADC_CHANNEL_NUM];
>> +	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
>> +	struct chan_data ch_data[SPEAR_ADC_CHANNEL_NUM];
>>   	u32 scan_rate_lo;
>>   	u32 scan_rate_hi;
>>   	struct chan_data average;
>> @@ -106,7 +103,7 @@ static void spear_adc_set_clk(struct spear_adc_info *info, u32 val)
>>   	clk_high = count - clk_low;
>>   	info->current_clk = apb_clk / count;
>>
>> -	__raw_writel(CLK_LOW(clk_low) | CLK_HIGH(clk_high),
>> +	__raw_writel(SPEAR_ADC_CLK_LOW(clk_low) | SPEAR_ADC_CLK_HIGH(clk_high),
>>   		     &info->adc_base_spear6xx->clk);
>>   }
>>
>> @@ -120,19 +117,19 @@ static u32 spear_adc_get_average(struct spear_adc_info *info)
>>   {
>>   	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
>>   		return __raw_readl(&info->adc_base_spear6xx->average.msb) &
>> -			DATA_MASK;
>> +			SPEAR_ADC_DATA_MASK;
>>   	} else {
>>   		return __raw_readl(&info->adc_base_spear3xx->average) &
>> -			DATA_MASK;
>> +			SPEAR_ADC_DATA_MASK;
>>   	}
>>   }
>>
>>   static void spear_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
>>   {
>>   	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
>> -		__raw_writel(SCAN_RATE_LO(rate),
>> +		__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
>>   			     &info->adc_base_spear6xx->scan_rate_lo);
>> -		__raw_writel(SCAN_RATE_HI(rate),
>> +		__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
>>   			     &info->adc_base_spear6xx->scan_rate_hi);
>>   	} else {
>>   		__raw_writel(rate, &info->adc_base_spear3xx->scan_rate);
>> @@ -152,11 +149,12 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>>   	case IIO_CHAN_INFO_RAW:
>>   		mutex_lock(&indio_dev->mlock);
>>
>> -		status = CHANNEL_NUM(chan->channel) |
>> -			AVG_SAMPLE(info->avg_samples) |
>> -			START_CONVERSION | ADC_ENABLE;
>> +		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
>> +			SPEAR_ADC_STATUS_AVG_SAMPLE(info->avg_samples) |
>> +			SPEAR_ADC_STATUS_START_CONVERSION |
>> +			SPEAR_ADC_STATUS_ADC_ENABLE;
>>   		if (info->vref_external == 0)
>> -			status |= VREF_INTERNAL;
>> +			status |= SPEAR_ADC_STATUS_VREF_INTERNAL;
>>
>>   		spear_adc_set_status(info, status);
>>   		wait_for_completion(&info->completion); /* set by ISR */
>> @@ -168,7 +166,7 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>>
>>   	case IIO_CHAN_INFO_SCALE:
>>   		*val = info->vref_external;
>> -		*val2 = DATA_BITS;
>> +		*val2 = SPEAR_ADC_DATA_BITS;
>>   		return IIO_VAL_FRACTIONAL_LOG2;
>>   	}
>>
>> @@ -253,7 +251,7 @@ static ssize_t spear_adc_write_frequency(struct device *dev,
>>
>>   	mutex_lock(&indio_dev->mlock);
>>
>> -	if ((lval < CLK_MIN) || (lval > CLK_MAX)) {
>> +	if ((lval < SPEAR_ADC_CLK_MIN) || (lval > SPEAR_ADC_CLK_MAX)) {
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>> @@ -339,7 +337,8 @@ static int spear_adc_probe(struct platform_device *pdev)
>>   		goto errout3;
>>   	}
>>
>> -	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, MOD_NAME, info);
>> +	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
>> +			info);
> Better indent with opening parenthesis.
Honestly this is in the category of really doesn't matter, but what the heck,
I'm redoing the series anyway so might as well fix this as well ;)
>>   	if (ret < 0) {
>>   		dev_err(dev, "failed requesting interrupt\n");
>>   		goto errout3;
>> @@ -370,7 +369,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>>
>>   	init_completion(&info->completion);
>>
>> -	iodev->name = MOD_NAME;
>> +	iodev->name = SPEAR_ADC_MOD_NAME;
>>   	iodev->dev.parent = dev;
>>   	iodev->info = &spear_adc_iio_info;
>>   	iodev->modes = INDIO_DIRECT_MODE;
>> @@ -419,7 +418,7 @@ static struct platform_driver spear_adc_driver = {
>>   	.probe		= spear_adc_probe,
>>   	.remove		= spear_adc_remove,
>>   	.driver		= {
>> -		.name	= MOD_NAME,
>> +		.name	= SPEAR_ADC_MOD_NAME,
>>   		.owner	= THIS_MODULE,
>>   		.of_match_table = of_match_ptr(spear_adc_dt_ids),
>>   	},
>

