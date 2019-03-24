Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA56C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE828222C4
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMA6UA3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCXPQe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:16:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 11:16:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so4644477pfe.2;
        Sun, 24 Mar 2019 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nObqsj0NLQ1sv9pmxRO0gM4KphDqFWVxm415dlcBoE=;
        b=DMA6UA3V6yM7UC+kyWceh4+FBJC8bJhwdgNdnQ8OAKrQ8Pw3H9MjZRU8dappl9yytq
         afQpONXqi7GmYAI9tg9d2slJbA50Z1ga1Uk+jp5SPf/TaHcuEreCO7ibfVWNEA7b16RC
         iP3oNInAkE+hoeUk3eo2FpZMZurNN4N3YywexlSYGBtU54Zy3WvBSvrQdDPY4KjjmYfK
         cAYXCnS4XaqfUfb7EX7CodMX1hUch41UIl0RWytKyJKYcHU+hD9e9HnUoEfQE9FlYL56
         2yLmdsAC6rKlaKzQd9DOoasnbbLjaT0ZiNTrLZI2vHUkTuEZM07veJT1+cYOpthn1/yc
         8rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nObqsj0NLQ1sv9pmxRO0gM4KphDqFWVxm415dlcBoE=;
        b=jzutKrmFT+oi6zPXCT/VB8n9PLtDrwauOeqg6yu7HdJg8dj26i1R2Ic77gjq30zkDj
         tBei5blyiAR9GekAE1GcNrF7TzDpIJuFTcHrh0cMQ8XN0xAKDI5Tb8K/Muz/j5G1wx/o
         2uoQKjonpJpAMz4UnxgduG2vrHzR5Qfwl/7iMmLik55Ljy5eb3vtSjWPNN1fN5vI0SIZ
         8ds2suYTGLRhhUWRRo4NQMzvIbOOsGbbl3j53KOA2bYkLE054pZ5xLspwulwUKkQvZP9
         ier0zkIhy+RK8cC5VesoS9g9omzngvFBTWZySDKa47gxHypeNvnoTkONTASg7PzyM15T
         hoEA==
X-Gm-Message-State: APjAAAWOx7Yt0su2RJkkhTmZwRsV8iiONYWgqjoWQCKJ5EIh4LWR9vYR
        5DSgIaOzQHcdGayAB6POA+Y=
X-Google-Smtp-Source: APXvYqwypwVwhBXK3Yfx3YrpoPMkpCbFUAADrwP0SLaefFsRWdhtgMHRxzOENOikBAVnmxceudN9FA==
X-Received: by 2002:a63:7e0a:: with SMTP id z10mr18527417pgc.144.1553440593361;
        Sun, 24 Mar 2019 08:16:33 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.77.43.14])
        by smtp.gmail.com with ESMTPSA id j20sm16805645pfh.141.2019.03.24.08.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 08:16:32 -0700 (PDT)
Date:   Sun, 24 Mar 2019 20:46:25 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add driver for the TI ADS8344 A/DC chips
Message-ID: <20190324151625.GA10047@himanshu-Vostro-3559>
References: <20190322111108.19383-1-gregory.clement@bootlin.com>
 <20190322111108.19383-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322111108.19383-3-gregory.clement@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 22, 2019 at 12:11:08PM +0100, Gregory CLEMENT wrote:
> This adds support for the Texas Instruments ADS8344 ADC chip. This chip
> has a 16-bit 8-Channel ADC and is access directly through SPI.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/iio/adc/Kconfig      |  10 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads8344.c | 200 +++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads8344.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 76db6e5cc296..447d3a871746 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -967,6 +967,16 @@ config TI_ADS7950
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ti-ads7950.
>  
> +config TI_ADS8344
> +	tristate "Texas Instruments ADS8344"
> +	depends on SPI && OF
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS8344
> +	  ADC chips
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads8344.
> +
>  config TI_ADS8688
>  	tristate "Texas Instruments ADS8688"
>  	depends on SPI && OF
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6fcebd167524..1f3ae934111d 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
> +obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> new file mode 100644
> index 000000000000..649ed05bf1c9
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0+

Inconsistency in License.

>
> + * ADS8344 16-bit 8-Channel ADC driver
> + *
> + * Author: Gregory CLEMENT <gregory.clement@bootlin.com>
> + *
> + * Datasheet: http://www.ti.com/lit/ds/symlink/ads8344.pdf
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define ADS8344_START BIT(7)
> +#define ADS8344_SINGLE_END BIT(2)
> +#define ADS8344_CHANNEL(channel) ((channel) << 4)
> +#define ADS8344_CLOCK_INTERNAL 0x2 /* PD1 = 1 and PD0 = 0 */
> +
> +struct ads8344 {
> +	struct spi_device *spi;
> +	struct regulator *reg;
> +	struct mutex lock;

This requires a comment explaining its purpose.
checkpatch issues a warning IIRC.

> +
> +	u8 tx_buf ____cacheline_aligned;
> +	u16 rx_buf;
> +};
> +
> +#define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = chan,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	}
> +
> +#define ADS8344_VOLTAGE_CHANNEL_DIFF(chan1, chan2, si)			\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (chan1),					\
> +		.channel2 = (chan2),					\
> +		.differential = 1,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	}
> +
> +static const struct iio_chan_spec ads8344_channels[] = {
> +	ADS8344_VOLTAGE_CHANNEL(0, 0),
> +	ADS8344_VOLTAGE_CHANNEL(1, 4),
> +	ADS8344_VOLTAGE_CHANNEL(2, 1),
> +	ADS8344_VOLTAGE_CHANNEL(3, 5),
> +	ADS8344_VOLTAGE_CHANNEL(4, 2),
> +	ADS8344_VOLTAGE_CHANNEL(5, 6),
> +	ADS8344_VOLTAGE_CHANNEL(6, 3),
> +	ADS8344_VOLTAGE_CHANNEL(7, 7),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(0, 1, 8),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(2, 3, 9),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(4, 5, 10),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(6, 7, 11),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(1, 0, 12),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(3, 2, 13),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(5, 4, 14),
> +	ADS8344_VOLTAGE_CHANNEL_DIFF(7, 6, 15),
> +};
> +
> +static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
> +				  bool differential)
> +{
> +	struct spi_device *spi = adc->spi;
> +	int ret;
> +
> +	adc->tx_buf = ADS8344_START;
> +	if (!differential)
> +		adc->tx_buf |= ADS8344_SINGLE_END;
> +	adc->tx_buf |= ADS8344_CHANNEL(channel);
> +	adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
> +
> +	ret = spi_write(spi, &adc->tx_buf, 1);
> +	if (ret)
> +		return ret;
> +
> +	udelay(9);
> +
> +	ret = spi_read(spi, &adc->rx_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	return adc->rx_buf;
> +}
> +
> +static int ads8344_read_raw(struct iio_dev *iio,
> +			    struct iio_chan_spec const *channel, int *value,
> +			    int *shift, long mask)
> +{
> +	struct ads8344 *adc = iio_priv(iio);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&adc->lock);

Just curious:
What would happen if you don't lock ?

I'm interested in looking for whatever happens in such a case
and how to exploit it ?

Also, bus transactions are often atomic using their locking/unlocking
procedures. So, why do we need locking procedures in iio drivers itself ?

> +		*value = ads8344_adc_conversion(adc, channel->scan_index,
> +						channel->differential);
> +		mutex_unlock(&adc->lock);
> +		if (*value < 0)
> +			return *value;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*value = regulator_get_voltage(adc->reg);
> +		if (*value < 0)
> +			return *value;
> +
> +		/* convert regulator output voltage to mV */
> +		*value /= 1000;
> +		*shift = 16;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ads8344_info = {
> +	.read_raw = ads8344_read_raw,
> +};
> +
> +static int ads8344_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads8344 *adc;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +	mutex_init(&adc->lock);
> +
> +	indio_dev->name = dev_name(&spi->dev);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->info = &ads8344_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads8344_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads8344_channels);
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
> +
> +	ret = regulator_enable(adc->reg);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		regulator_disable(adc->reg);
> +		return ret;
> +	}

IDK but it is advised not to mix devm_* with regular functions.

If there is any possibilty to use `devm_add_action_or_reset` here ?

This would help get rid of `ads8344_remove` and help smooth
unwinding in failure w/o any race.

> +	return 0;
> +}
> +
> +static int ads8344_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ads8344 *adc = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(adc->reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ads8344_of_match[] = {
> +	{ .compatible = "ti,ads8344", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ads8344_dt_ids);
> +
> +static struct spi_driver ads8344_driver = {
> +	.driver = {
> +		.name = "ads8344",
> +		.of_match_table = ads8344_of_match,
> +	},
> +	.probe = ads8344_probe,
> +	.remove = ads8344_remove,
> +};
> +module_spi_driver(ads8344_driver);
> +
> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@bootlin.com>");
> +MODULE_DESCRIPTION("ADS8344 driver");


> +MODULE_LICENSE("GPL v2");

this is a mismatch.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
