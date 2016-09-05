Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752312AbcIHBs0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Sep 2016 21:48:26 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <maxime.ripard@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>,
        <antoine.tenart@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com> <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com> <alpine.DEB.2.02.1609041754350.2060@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1609041754350.2060@pmeerw.net>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Mon, 5 Sep 2016 00:48:51 -0600
Message-ID: <aed1e00f-ceaa-27e9-502d-51428f59a84f@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/2016 18:12, Peter Meerwald-Stadler wrote:
> 
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. This patch adds the ADC driver which is
>> based on the MFD for the same SoCs ADC.
> 
> nitpicking ahead
>  
[...]
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> new file mode 100644
>> index 0000000..a93d36d
>> --- /dev/null
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -0,0 +1,525 @@
>> +/* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
>> + *
>> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> 
> email address is incomplete
> 

As in my other patches, thanks!

>> + *
>> + * This program is free software; you can redistribute it and/or modify it under
>> + * the terms of the GNU General Public License version 2 as published by the
>> + * Free Software Foundation.
>> + *
>> + * The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> + * controller and a thermal sensor.
>> + * The thermal sensor works only when the ADC acts as a touchscreen controller
>> + * and is configured to throw an interrupt every fixed periods of time (let say
>> + * every X seconds).
>> + * One would be tempted to disable the IP on the hardware side rather than
>> + * disabling interrupts to save some power but that reset the internal clock of
> 
> resets
> 
>> + * the IP, resulting in having to wait X seconds every time we want to read the
>> + * value of the thermal sensor.
>> + * This is also the reason of using autosuspend in pm_runtime. If there were no
> 
> there was no
> 
[...]
>> +
>> +const unsigned int sun4i_gpadc_chan_select(unsigned int chan)
> 
> static instead of const?
> 

static const then?

>> +{
>> +	return SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>> +}
>> +
>> +const unsigned int sun6i_gpadc_chan_select(unsigned int chan)
> 
> static instead of const?
> 

static const then?

>> +{
>> +	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>> +}
>> +
>> +struct soc_specific {
>> +	const int		temp_offset;
> 
> wondering why you constify every member?
> 

Because they're supposed to be fixed values? It won't change in runtime.
Is there any reason why I shouldn't do that?

>> +	const int		temp_scale;
>> +	const unsigned int	tp_mode_en;
>> +	const unsigned int	tp_adc_select;
>> +	const unsigned int	(*adc_chan_select)(unsigned int chan);
>> +};
[...]
>> +static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
>> +			    unsigned int irq)
>> +{
>> +	struct sun4i_gpadc_dev *info = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +
>> +	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC,
>> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUN4I_GPADC_INT_FIFOC_TP_FIFO_FLUSH);
> 
> check retval? here and elsewhere for regmap_write()
> 

ACK. What should I do with the retval then?

There are some in:
- sun4i_gpadc_read called for read_raws => return which error code (or
-ret only?)?
- sun4i_gpadc_runtime_suspend => return value of ret, but that would
cancel the suspend right?
- sun4i_gpadc_runtime_resume => return value of ret, but that would
cancel resume right?
- sun4i_gpadc_probe in the error gotos => probe already failing so do we
actually care if regmap_update_bits fails? If yes, what's the expected
behaviour?
- sun4i_gpadc_remove => return value of ret, but that would mean the
remove failed right?

[...]
>> +static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan, int *val,
>> +				int *val2, long mask)
>> +{
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		ret = sun4i_gpadc_temp_offset(indio_dev, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_RAW:
>> +		if (chan->type == IIO_VOLTAGE) {
>> +			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
>> +						   val);
>> +			if (ret)
>> +				return ret;
> 
> could share the "if (ret) return ret;" between code path
> 

ACK.

[...]
>> +static int sun4i_irq_init(struct platform_device *pdev, const char *name,
>> +			  irq_handler_t handler, const char *devname,
>> +			  unsigned int *irq, atomic_t *atomic)
>> +{
>> +	int ret;
>> +	struct sun4i_gpadc_mfd_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
>> +	struct sun4i_gpadc_dev *info = iio_priv(dev_get_drvdata(&pdev->dev));
>> +
>> +	/*
>> +	 * Once the interrupt is activated, the IP continuously performs
>> +	 * conversions thus throws interrupts. The interrupt is activated right
>> +	 * after being requested but we want to control when these interrupts
>> +	 * occurs thus we disable it right after being requested. However, an
> 
> occur
> 

ACK for all typos.
Thanks!

Quentin
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

