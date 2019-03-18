Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5271BC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E868A20872
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr82gYv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCRUxL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:53:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43754 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfCRUxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 16:53:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id p20so2513088lji.10
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2gx4I97QVWpIFwrdwWG1MfbZDrCuaeeFM72macyS0Q=;
        b=kr82gYv+XTNjiQ71j/eAsKyos+2fhF7Ui/Mcgy0Irp0BFUnOpkmn/wvLG8cwmknCSC
         4ozqjd+WEJsfNf07w8W6fm4Fw1E/Fr1e8mIOJX4OuIdktrkluSVnO6PxzrR1SMiw7OlV
         thWqa346iq4fd36kc+PBpVYsGfSgm1tq2Ofi3LE1HXGhaN9LZAsycuKPJPr14W5HNZzq
         EFeD1US4okLUEvr5lZZTLm9im/Rn+snZeLyJBRSZppDGHJiL3wA6JePNdXavc8T3eYxc
         vSsNqE28bdpQR/w6Es/GOjg4P3bpuWYzw3xXJ0ETA40cNxOSQOtDBTDl0hEWkJdVLo/m
         LwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2gx4I97QVWpIFwrdwWG1MfbZDrCuaeeFM72macyS0Q=;
        b=VYrZFZRisTqCnpkwJVnXiBSROmLnheg3zjAOkHEn865gTJBBBOt/zIZ1O1VlptCbur
         ckeWgkt+AESTpgERQsgfm713szEQmUFLSLKFEFsBNa2WZ3J43B85AUIxPBTJZn9FauHl
         5oWtJPBZXDPm7yHKjVkqYC6IX3yengz8WD/j8679ixgsB+0bIcQxFw3IvcyXzwCkIv8Z
         CisRXJ1GKaYhKnTC7b05H3MVdnwHnYA8a80SWuu6CIekASinGDEGjTrSD5DDIjNihj62
         srHKEKlF5WgB6TU4huG1iBTA3qV7x6m0NbYMmFSS8ybJcEOGlLd7d0WO6EmxnAJ/beUP
         pf1A==
X-Gm-Message-State: APjAAAVCsRdGIAuYBLgdmmD2Qgu+Kpje2DolPlUtc6oZp+BFUZJRRiVT
        WLrgO1js6NwcLi/k6Twkito=
X-Google-Smtp-Source: APXvYqyT2/x7JAVpKqcpJDNxLccxMrkZk/WNDsYdHPF3DaalBwIpbaoljHGcOutWxnQh5PIhwOotxg==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr7685207ljh.174.1552942387707;
        Mon, 18 Mar 2019 13:53:07 -0700 (PDT)
Received: from localhost (89-64-60-250.dynamic.chello.pl. [89.64.60.250])
        by smtp.gmail.com with ESMTPSA id n5sm2224114lfh.6.2019.03.18.13.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 13:53:07 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:52:42 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190318205242.GA11257@arch>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,

A few comments inline.

On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:
> From: Vincent Pelletier <plr.vincent@gmail.com>
>
> Exposes the ADC device present on, at least, Intel Merrifield platform.
>
> Based on work done by:
>   Yang Bin <bin.yang@intel.com>
>   Huiquan Zhong <huiquan.zhong@intel.com>
>   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>   Pavan Kumar S <pavan.kumar.s@intel.com>
>
> Though it has been heavily rewritten for upstream.
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/Kconfig           |  13 ++
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/intel_mrfld_adc.c | 264 ++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 drivers/iio/adc/intel_mrfld_adc.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 76db6e5cc296..f30c531fc588 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -419,6 +419,19 @@ config INGENIC_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ingenic_adc.
>
> +config INTEL_MRFLD_ADC
> +	tristate "Intel Merrifield Basin Cove ADC driver"
> +	depends on INTEL_SOC_PMIC_MRFLD
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

Looks you're not using iio buffering hence these should be dropped.
Instead you should select regmap here.

> +	help
> +	  Say yes here to have support for Basin Cove power management IC (PMIC) ADC
> +	  device. Depending on platform configuration, this general purpose ADC can
> +	  be used for sampling sensors such as thermal resistors.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called intel_mrfld_adc.
> +
>  config IMX7D_ADC
>  	tristate "Freescale IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6fcebd167524..6cbf2e5a51a7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_HX711) += hx711.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
> +obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> new file mode 100644
> index 000000000000..de3bc034f651
> --- /dev/null
> +++ b/drivers/iio/adc/intel_mrfld_adc.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADC driver for Basin Cove PMIC
> + *
> + * Copyright (C) 2012 Intel Corporation
> + * Author: Bin Yang <bin.yang@intel.com>
> + *
> + * Rewritten for upstream by:
> + *	 Vincent Pelletier <plr.vincent@gmail.com>
> + *	 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/mfd/intel_soc_pmic_mrfld.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

Alphabetical order is preferred. Generally it's also good idea to include
all headers which export functionality used by the driver. At least a few
seems to be missing from the list.

> +
> +#define BCOVE_GPADCREQ			0xDC
> +#define BCOVE_GPADCREQ_BUSY		BIT(0)
> +#define BCOVE_GPADCREQ_IRQEN		BIT(1)
> +
> +#define BCOVE_ADCIRQ_ALL (		\
> +	BCOVE_ADCIRQ_BATTEMP |		\
> +	BCOVE_ADCIRQ_SYSTEMP |		\
> +	BCOVE_ADCIRQ_BATTID |		\
> +	BCOVE_ADCIRQ_VIBATT |		\
> +	BCOVE_ADCIRQ_CCTICK)
> +
> +#define BCOVE_ADC_TIMEOUT		msecs_to_jiffies(1000)
> +
> +static const u8 mrfld_adc_requests[] = {
> +	BCOVE_ADCIRQ_VIBATT,
> +	BCOVE_ADCIRQ_BATTID,
> +	BCOVE_ADCIRQ_VIBATT,
> +	BCOVE_ADCIRQ_SYSTEMP,
> +	BCOVE_ADCIRQ_BATTEMP,
> +	BCOVE_ADCIRQ_BATTEMP,
> +	BCOVE_ADCIRQ_SYSTEMP,
> +	BCOVE_ADCIRQ_SYSTEMP,
> +	BCOVE_ADCIRQ_SYSTEMP,
> +};
> +
> +struct mrfld_adc {
> +	struct regmap *regmap;
> +	struct completion completion;
> +};
> +
> +static irqreturn_t mrfld_adc_thread_isr(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct mrfld_adc *adc = iio_priv(indio_dev);
> +
> +	complete(&adc->completion);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *result)
> +{
> +	struct mrfld_adc *adc = iio_priv(indio_dev);
> +	struct regmap *regmap = adc->regmap;
> +	unsigned int req;
> +	long timeout;
> +	u8 buf[2];
> +	int ret;
> +
> +	reinit_completion(&adc->completion);
> +
> +	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0);
> +	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0);
> +
> +	ret = regmap_read_poll_timeout(regmap, BCOVE_GPADCREQ, req,
> +				       !(req & BCOVE_GPADCREQ_BUSY),
> +				       2000, 1000000);
> +	if (ret)
> +		goto done;
> +
> +	req = mrfld_adc_requests[chan->channel];
> +	ret = regmap_write(regmap, BCOVE_GPADCREQ, BCOVE_GPADCREQ_IRQEN | req);
> +	if (ret)
> +		goto done;
> +
> +	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
> +							    BCOVE_ADC_TIMEOUT);
> +	if (timeout < 0) {
> +		ret = timeout;
> +		goto done;
> +	}
> +	if (timeout == 0) {
> +		ret = -ETIMEDOUT;
> +		goto done;
> +	}
> +
> +	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> +	if (ret)
> +		goto done;
> +
> +	*result = (buf[0] << 8) | buf[1];

be/le16_to_cpu() will do it for you.

> +	ret = IIO_VAL_INT;
> +
> +done:
> +	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0xff);
> +	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0xff);
> +
> +	return ret;
> +}
> +
> +static int mrfld_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = mrfld_adc_single_conv(indio_dev, chan, val);
> +
> +		iio_device_release_direct_mode(indio_dev);

claim/release api is slightly abused here. Legitimate usecase is when
you want protect against transitions between driver modes and not
concurrent reads. Mutex will work here just fine.

> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info mrfld_adc_iio_info = {
> +	.read_raw = &mrfld_adc_read_raw,
> +};
> +
> +#define BCOVE_ADC_CHANNEL(_type, _channel, _datasheet_name, _address)	\
> +	{								\
> +		.indexed = 1,						\
> +		.type = _type,						\
> +		.channel = _channel,					\
> +		.address = _address,					\
> +		.datasheet_name = _datasheet_name,			\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 10,					\
> +			.storagebits = 16,				\
> +			.shift = 0,					\
> +			.endianness = IIO_BE,				\
> +		}							\

Scan elements make sense only in buffered mode which is not supported
by this driver.

> +	}
> +
> +static const struct iio_chan_spec mrfld_adc_channels[] = {
> +	BCOVE_ADC_CHANNEL(IIO_VOLTAGE,    0, "CH0", 0xE9),
> +	BCOVE_ADC_CHANNEL(IIO_RESISTANCE, 1, "CH1", 0xEB),
> +	BCOVE_ADC_CHANNEL(IIO_CURRENT,    2, "CH2", 0xED),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       3, "CH3", 0xCC),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       4, "CH4", 0xC8),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       5, "CH5", 0xCA),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       6, "CH6", 0xC2),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       7, "CH7", 0xC4),
> +	BCOVE_ADC_CHANNEL(IIO_TEMP,       8, "CH8", 0xC6),
> +};
> +
> +static struct iio_map iio_maps[] = {
> +	IIO_MAP("CH0", "bcove-battery", "VBATRSLT"),
> +	IIO_MAP("CH1", "bcove-battery", "BATTID"),
> +	IIO_MAP("CH2", "bcove-battery", "IBATRSLT"),
> +	IIO_MAP("CH3", "bcove-temp",    "PMICTEMP"),
> +	IIO_MAP("CH4", "bcove-temp",    "BATTEMP0"),
> +	IIO_MAP("CH5", "bcove-temp",    "BATTEMP1"),
> +	IIO_MAP("CH6", "bcove-temp",    "SYSTEMP0"),
> +	IIO_MAP("CH7", "bcove-temp",    "SYSTEMP1"),
> +	IIO_MAP("CH8", "bcove-temp",    "SYSTEMP2"),
> +	{}
> +};
> +
> +static int mrfld_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +	struct iio_dev *indio_dev;
> +	struct mrfld_adc *adc;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*indio_dev));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +
> +	init_completion(&adc->completion);
> +	adc->regmap = pmic->regmap;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_adc_thread_isr,
> +					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
> +					indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = pdev->name;
> +
> +	indio_dev->channels = mrfld_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mrfld_adc_channels);
> +	indio_dev->info = &mrfld_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_map_array_register(indio_dev, iio_maps);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		goto err_array_unregister;
> +
> +	return 0;
> +
> +err_array_unregister:
> +	iio_map_array_unregister(indio_dev);
> +	return ret;
> +}
> +
> +static int mrfld_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_map_array_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id mrfld_adc_id_table[] = {
> +	{ .name = "mrfld_bcove_adc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, mrfld_adc_id_table);
> +
> +static struct platform_driver mrfld_adc_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +	.probe = mrfld_adc_probe,
> +	.remove = mrfld_adc_remove,
> +	.id_table = mrfld_adc_id_table,
> +};
> +module_platform_driver(mrfld_adc_driver);
> +
> +MODULE_AUTHOR("Bin Yang <bin.yang@intel.com>");
> +MODULE_AUTHOR("Vincent Pelletier <plr.vincent@gmail.com>");
> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
> +MODULE_DESCRIPTION("ADC driver for Basin Cove PMIC");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>
