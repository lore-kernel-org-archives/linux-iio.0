Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51793 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab3GELqL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 07:46:11 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: add scale_available file to channels
Date: Fri, 5 Jul 2013 13:46:03 +0200
Cc: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	lars@metafoo.de, jic23@kernel.org, fabio.estevam@freescale.com
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-4-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-4-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051346.03825.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Hector Palacios,

> Adds in_voltageX_scale_available file for every channel to read
> the different available scales.
> There are two scales per channel:
>  [0] = divider_by_two disabled (default)
>  [1] = divider_by_two enabled
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 115
> +++++++++++++++++++++++++++++++++++- 1 file changed, 114 insertions(+), 1
> deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 012c42e..7f98c99 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -37,6 +37,7 @@
>  #include <linux/input.h>
> 
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
> @@ -186,6 +187,7 @@ struct mxs_lradc {
>  	struct completion	completion;
> 
>  	const int		*vref_mv;
> +	unsigned int		scale_avail[LRADC_MAX_TOTAL_CHANS][2][2];
> 
>  	/*
>  	 * Touchscreen LRADC channels receives a private slot in the CTRL4
> @@ -362,9 +364,99 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	return ret;
>  }
> 
> +static ssize_t mxs_lradc_show_scale_available_ch(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf,
> +		int ch)
> +{
> +	struct iio_dev *iio = dev_to_iio_dev(dev);
> +	struct mxs_lradc *lradc = iio_priv(iio);
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(lradc->scale_avail[ch]); i++)
> +		len += sprintf(buf + len, "%d.%09u ",
> +			       lradc->scale_avail[ch][i][0],
> +			       lradc->scale_avail[ch][i][1]);
> +
> +	len += sprintf(buf + len, "\n");
> +
> +	return len;
> +}
> +
> +#define SHOW_SCALE_AVAILABLE_FUNC(ch) 					
\
> +static ssize_t mxs_lradc_show_scale_available##ch(struct device *dev,	
\
> +		struct device_attribute *attr, 				\
> +		char *buf)						\
> +{ 									\
> +	return mxs_lradc_show_scale_available_ch(dev, attr, buf, ch);	\
> +}
> +
> +SHOW_SCALE_AVAILABLE_FUNC(0)
> +SHOW_SCALE_AVAILABLE_FUNC(1)
> +SHOW_SCALE_AVAILABLE_FUNC(2)
> +SHOW_SCALE_AVAILABLE_FUNC(3)
> +SHOW_SCALE_AVAILABLE_FUNC(4)
> +SHOW_SCALE_AVAILABLE_FUNC(5)
> +SHOW_SCALE_AVAILABLE_FUNC(6)
> +SHOW_SCALE_AVAILABLE_FUNC(7)
> +SHOW_SCALE_AVAILABLE_FUNC(8)
> +SHOW_SCALE_AVAILABLE_FUNC(9)
> +SHOW_SCALE_AVAILABLE_FUNC(10)
> +SHOW_SCALE_AVAILABLE_FUNC(11)
> +SHOW_SCALE_AVAILABLE_FUNC(12)
> +SHOW_SCALE_AVAILABLE_FUNC(13)
> +SHOW_SCALE_AVAILABLE_FUNC(14)
> +SHOW_SCALE_AVAILABLE_FUNC(15)
> +
> +#define SHOW_SCALE_AVAILABLE_ATTR(ch)					
\
> +static IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, S_IRUGO,	\
> +		       mxs_lradc_show_scale_available##ch, NULL, 0)
> +
> +SHOW_SCALE_AVAILABLE_ATTR(0);
> +SHOW_SCALE_AVAILABLE_ATTR(1);
> +SHOW_SCALE_AVAILABLE_ATTR(2);
> +SHOW_SCALE_AVAILABLE_ATTR(3);
> +SHOW_SCALE_AVAILABLE_ATTR(4);
> +SHOW_SCALE_AVAILABLE_ATTR(5);
> +SHOW_SCALE_AVAILABLE_ATTR(6);
> +SHOW_SCALE_AVAILABLE_ATTR(7);
> +SHOW_SCALE_AVAILABLE_ATTR(8);
> +SHOW_SCALE_AVAILABLE_ATTR(9);
> +SHOW_SCALE_AVAILABLE_ATTR(10);
> +SHOW_SCALE_AVAILABLE_ATTR(11);
> +SHOW_SCALE_AVAILABLE_ATTR(12);
> +SHOW_SCALE_AVAILABLE_ATTR(13);
> +SHOW_SCALE_AVAILABLE_ATTR(14);
> +SHOW_SCALE_AVAILABLE_ATTR(15);
> +
> +static struct attribute *mxs_lradc_attributes[] = {
> +	&iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage1_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage2_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage3_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage4_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage5_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage6_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage7_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage8_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage9_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage10_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage11_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage12_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage13_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage14_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage15_scale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group mxs_lradc_attribute_group = {
> +	.attrs = mxs_lradc_attributes,
> +};
> +
>  static const struct iio_info mxs_lradc_iio_info = {
>  	.driver_module		= THIS_MODULE,
>  	.read_raw		= mxs_lradc_read_raw,
> +	.attrs			= &mxs_lradc_attribute_group,
>  };
> 
>  /*
> @@ -968,7 +1060,8 @@ static int mxs_lradc_probe(struct platform_device
> *pdev) struct resource *iores;
>  	uint32_t ts_wires = 0;
>  	int ret = 0;
> -	int i;
> +	int i, s;
> +	unsigned int scale_uv;
> 
>  	/* Allocate the IIO device. */
>  	iio = iio_device_alloc(sizeof(*lradc));
> @@ -1043,6 +1136,26 @@ static int mxs_lradc_probe(struct platform_device
> *pdev) if (ret)
>  		goto err_trig;
> 
> +	/* Populate available ADC input ranges */
> +	for (i = 0; i < LRADC_MAX_TOTAL_CHANS; i++) {
> +		for (s = 0; s < ARRAY_SIZE(lradc->scale_avail[i]); s++) {
> +			/*
> +			 * [0] = optional divider by two disabled (default)
> +			 * [1] = optional divider by two enabled
> +			 *
> +			 * The scale is calculated by doing:
> +			 *   Vref >> (realbits - s)
> +			 * which multiplies by two on the second component
> +			 * of the array.
> +			 */
> +			scale_uv = ((u64)lradc->vref_mv[i] * 100000000) >>
> +				   (iio->channels[i].scan_type.realbits - s);

Given that you do have a table of values already, can this table not be computed 
at compile-time as well?

> +			lradc->scale_avail[i][s][1] = do_div(scale_uv,
> +							     100000000) * 10;
> +			lradc->scale_avail[i][s][0] = scale_uv;

Is this correct? Why is one set to "scale_uv" and the other set to scale_uv / 
100000000 ? Maybe I just don't understand what each of the fields in the array 
stand for.

> +		}
> +	}
> +
>  	/* Configure the hardware. */
>  	mxs_lradc_hw_init(lradc);

Best regards,
Marek Vasut
